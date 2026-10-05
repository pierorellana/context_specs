# Logging and API Response Envelope Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add safe API response logging to Flutter and NestJS, standardize API responses around `data`, `message`, and `statusCode`, remove comments only from `binova_app/lib`, synchronize the contract and READMEs, and document the remaining technical-test gaps.

**Architecture:** Keep the existing feature-first Flutter and modular NestJS boundaries. The API response helper and global exception filter own the wire envelope; the existing correlation and observability boundaries own structured request logging; Flutter's `ApiClient` owns response parsing and delegates sanitized log emission to the existing `Observability` abstraction. OpenAPI and the shared specs remain synchronized with the implementation.

**Tech Stack:** Flutter/Dart 3.5+, `package:http`, `dart:developer`, Provider, NestJS 11, TypeScript 5.7, Jest, Prisma 6, PostgreSQL, OpenAPI 3.0.3.

## Global Constraints

- Required response fields are exactly `data`, `message`, and numeric `statusCode`; optional `meta` preserves `traceId`, `generatedAt`, and cursor pagination.
- Error responses use `data: null`, a safe `message`, `statusCode`, stable top-level `code`, safe `details`, and `meta` correlation data.
- Never log request/response bodies, authorization headers, access/refresh tokens, passwords, API keys, balances, PAN/CVV, complete account numbers, or raw idempotency keys.
- `binova_app/lib` is the only directory from which comments are removed; tests, configuration, platform files, READMEs and `context_specs` comments remain.
- Controllers do not access Prisma or own logging policy; Flutter presentation and Provider code do not perform HTTP.
- No third-party logger, Firebase/FCM SDK, Crashlytics/Sentry integration, production dashboard or unrelated refactor is added.
- Every task ends with focused tests and a small commit in the affected repository.

---

### Task 1: Implement the API success envelope and HTTP status alignment

**Files:**
- Modify: `api_binova/src/common/responses/api-response.ts`
- Test: `api_binova/src/common/responses/api-response.spec.ts`
- Modify: `api_binova/src/modules/auth/auth.controller.ts`
- Modify: `api_binova/src/modules/profile/profile.controller.ts`
- Modify: `api_binova/src/modules/profile/devices.controller.ts`
- Modify: `api_binova/src/modules/dashboard/dashboard.controller.ts`
- Modify: `api_binova/src/modules/accounts/accounts.controller.ts`
- Modify: `api_binova/src/modules/transactions/transactions.controller.ts`
- Modify: `api_binova/src/modules/operations/operations.controller.ts`
- Modify: `api_binova/src/modules/cards/cards.controller.ts`
- Modify: `api_binova/src/modules/insights/insights.controller.ts`
- Modify: `api_binova/src/modules/exchange/exchange.controller.ts`
- Modify: `api_binova/src/modules/notifications/notifications.controller.ts`

**Interfaces:**
- Produces `ApiMeta`, `ApiEnvelope<T>`, `SuccessOptions`, and `success<T>(data, traceId, options?)` from `src/common/responses/api-response.ts`.
- `SuccessOptions` has `message?: string`, `statusCode?: number`, and `nextCursor?: string | null`.
- Existing callers migrate from `success(data, traceId, nextCursor)` to `success(data, traceId, { nextCursor })`.

- [ ] **Step 1: Write failing envelope tests**

Add these assertions to `api-response.spec.ts`:

```ts
it('returns the requested fields and preserves correlation metadata', () => {
  const response = success([{ id: 'tx-1' }], 'trace-1', {
    message: 'Movimientos consultados.',
    statusCode: 200,
    nextCursor: 'cursor-2',
  });

  expect(response).toMatchObject({
    data: [{ id: 'tx-1' }],
    message: 'Movimientos consultados.',
    statusCode: 200,
    meta: { traceId: 'trace-1', nextCursor: 'cursor-2' },
  });
  expect(new Date(response.meta.generatedAt).toString()).not.toBe('Invalid Date');
});

it('uses safe defaults when no options are provided', () => {
  expect(success({ ok: true }, 'trace-2')).toMatchObject({
    data: { ok: true },
    message: 'Operación exitosa.',
    statusCode: 200,
    meta: { traceId: 'trace-2' },
  });
});
```

- [ ] **Step 2: Run the focused test and verify it fails**

Run: `npm test -- --runInBand src/common/responses/api-response.spec.ts`

Expected: FAIL because the current helper returns `meta` but no `message` or `statusCode`, and its third parameter is a cursor string.

- [ ] **Step 3: Implement the helper**

Replace the helper types and function with this shape:

```ts
export interface ApiMeta {
  traceId: string;
  generatedAt: string;
  nextCursor?: string | null;
}

export interface SuccessOptions {
  message?: string;
  statusCode?: number;
  nextCursor?: string | null;
}

export interface ApiEnvelope<T> {
  data: T;
  message: string;
  statusCode: number;
  meta: ApiMeta;
}

export function success<T>(
  data: T,
  traceId: string,
  options: SuccessOptions = {},
): ApiEnvelope<T> {
  return {
    data,
    message: options.message ?? 'Operación exitosa.',
    statusCode: options.statusCode ?? 200,
    meta: {
      traceId,
      generatedAt: new Date().toISOString(),
      ...(options.nextCursor !== undefined
        ? { nextCursor: options.nextCursor }
        : {}),
    },
  };
}
```

- [ ] **Step 4: Migrate paginated and non-200 callers**

Change both paginated controllers to pass `{ nextCursor: page.nextCursor }`. Pass `{ statusCode: 202, message: 'Operación recibida.' }` for transfers, payments, topups, virtual-card creation and Wallet provisioning. Add `@HttpCode(HttpStatus.OK)` to POST auth/logout, card freeze/unfreeze and notification actions where OpenAPI declares 200; add `{ statusCode: 201 }` for device registration. Keep GET/PATCH/DELETE defaults at 200 and keep existing `@HttpCode(202)` decorators for accepted operations.

- [ ] **Step 5: Run API tests and build**

Run: `npm test -- --runInBand`

Expected: PASS for existing tests and the updated response helper tests.

Run: `npm run build`

Expected: TypeScript compilation succeeds with no signature or status-code errors.

- [ ] **Step 6: Commit the API envelope change**

```bash
git add src/common/responses/api-response.ts src/common/responses/api-response.spec.ts \
  src/modules/auth/auth.controller.ts \
  src/modules/profile/profile.controller.ts \
  src/modules/profile/devices.controller.ts \
  src/modules/dashboard/dashboard.controller.ts \
  src/modules/accounts/accounts.controller.ts \
  src/modules/transactions/transactions.controller.ts \
  src/modules/operations/operations.controller.ts \
  src/modules/cards/cards.controller.ts \
  src/modules/insights/insights.controller.ts \
  src/modules/exchange/exchange.controller.ts \
  src/modules/notifications/notifications.controller.ts
git commit -m "feat: standardize api success envelope"
```

---

### Task 2: Standardize API errors and add redacted structured API logs

**Files:**
- Modify: `api_binova/src/common/filters/http-exception.filter.ts`
- Create: `api_binova/src/common/filters/http-exception.filter.spec.ts`
- Create: `api_binova/src/common/observability/log-sanitizer.ts`
- Create: `api_binova/src/common/observability/log-sanitizer.spec.ts`
- Modify: `api_binova/src/common/observability/api-observability.interceptor.ts`
- Modify: `api_binova/src/common/observability/observability.service.ts`
- Modify: `api_binova/src/main.ts`

**Interfaces:**
- Produces `ApiErrorEnvelope` from `http-exception.filter.ts` with `data: null`, `message`, `statusCode`, `code`, `details`, and `meta`.
- Produces `sanitizeApiLog(fields)` from `log-sanitizer.ts`, returning only the allowlisted log fields.
- `ObservabilityService.recordRequest()` continues to accept method, route, status, latency, correlation ID and optional error code, but emits a JSON-safe allowlisted event.

- [ ] **Step 1: Write failing filter and sanitizer tests**

Create a filter test that invokes `catch()` with a mocked `UnauthorizedException`, request correlation ID `trace-error`, and response spy, then asserts:

```ts
expect(json).toHaveBeenCalledWith(expect.objectContaining({
  data: null,
  message: 'La sesión expiró.',
  statusCode: 401,
  code: 'SESSION_EXPIRED',
  details: {},
  meta: expect.objectContaining({ traceId: 'trace-error' }),
}));
```

Create sanitizer tests that assert:

```ts
expect(sanitizeApiLog({
  event: 'api_request',
  method: 'POST',
  route: '/v1/auth/login',
  statusCode: 401,
  latencyMs: 12,
  correlationId: 'trace-1',
  code: 'AUTH_INVALID_CREDENTIALS',
  password: 'must-not-appear',
  authorization: 'Bearer secret',
})).toEqual({
  event: 'api_request',
  method: 'POST',
  route: '/v1/auth/login',
  statusCode: 401,
  latencyMs: 12,
  correlationId: 'trace-1',
  code: 'AUTH_INVALID_CREDENTIALS',
});
```

- [ ] **Step 2: Run focused tests and verify they fail**

Run: `npm test -- --runInBand src/common/filters/http-exception.filter.spec.ts src/common/observability/log-sanitizer.spec.ts`

Expected: FAIL because the current filter returns `{ error, traceId }` and no sanitizer exists.

- [ ] **Step 3: Implement the error envelope**

Use this response construction in `HttpExceptionFilter`:

```ts
response.status(status).json({
  data: null,
  message,
  statusCode: status,
  code,
  details: typeof details.details === 'object' && details.details !== null
    ? details.details
    : {},
  meta: {
    traceId,
    generatedAt: new Date().toISOString(),
  },
});
```

Preserve the existing safe fallback messages and status-to-code mapping. Never include the raw exception, request body or headers in the response.

- [ ] **Step 4: Implement allowlisted API log serialization**

Implement `sanitizeApiLog` by copying only `event`, `method`, `route`, `statusCode`, `latencyMs`, `correlationId`, `errorCode`/`code`, `dependency`, `succeeded` and `message` when they are present. Do not recursively serialize arbitrary objects. Use `Logger` with JSON output in `main.ts`:

```ts
const app = await NestFactory.create(AppModule, {
  logger: new ConsoleLogger({
    json: true,
    logLevels: ['log', 'warn', 'error', 'fatal'],
  }),
});
```

Update `ApiObservabilityInterceptor.errorCode()` to read the new top-level `code` and retain the old nested lookup only for migration compatibility. Keep the event names `api_request` and `dependency_call`.

- [ ] **Step 5: Run focused and full API tests**

Run: `npm test -- --runInBand src/common/filters/http-exception.filter.spec.ts src/common/observability/log-sanitizer.spec.ts src/common/responses/api-response.spec.ts`

Expected: PASS.

Run: `npm test -- --runInBand`

Expected: PASS with no sensitive value present in sanitizer assertions.

- [ ] **Step 6: Commit API errors and logging**

```bash
git add src/common/filters src/common/observability src/main.ts
git commit -m "feat: add redacted api response logging"
```

---

### Task 3: Parse the new envelope and log sanitized API responses in Flutter

**Files:**
- Modify: `binova_app/lib/core/observability/observability.dart`
- Modify: `binova_app/lib/core/network/api_client.dart`
- Modify: `binova_app/lib/core/errors/app_failure.dart`
- Modify: `binova_app/lib/app/bootstrap/app_services.dart`
- Modify: `binova_app/test/authenticated_api_client_test.dart`
- Modify: `binova_app/test/demo_network_mode_test.dart`
- Create: `binova_app/test/api_client_logging_test.dart`
- Modify: any Dart implementation of `Observability` found by `rg -n "implements Observability" binova_app/lib binova_app/test`

**Interfaces:**
- `ApiResponse` exposes `statusCode`, `data`, `message`, `meta`, optional `code` and `details`.
- `Observability` adds `logApiResponse(...)` and `logApiError(...)` with only scalar safe fields.
- `DebugObservability` uses `dart:developer.log` and keeps its current allowlist for business events.

- [ ] **Step 1: Write failing parser and logging tests**

Update test fixtures from `{ data, meta }` to:

```dart
jsonEncode(<String, dynamic>{
  'data': <String, dynamic>{'ok': true},
  'message': 'Operación exitosa.',
  'statusCode': 200,
  'meta': <String, dynamic>{
    'traceId': 'trace-test',
    'generatedAt': '2026-10-05T12:00:00.000Z',
  },
})
```

Add a fake observability sink and assert one success event contains method, path, status, duration, message and trace ID but never contains `ok`, `access-token`, `refresh-token`, `password` or a balance. Add an error fixture with `data: null`, `message`, `statusCode` and top-level `code`, then assert `AppFailure.fromHttp` preserves `code`, `message`, `statusCode` and `details`.

- [ ] **Step 2: Run the focused Flutter tests and verify they fail**

Run from `binova_app`: `flutter test --no-pub test/authenticated_api_client_test.dart test/demo_network_mode_test.dart test/api_client_logging_test.dart`

Expected: FAIL because `ApiResponse` requires `meta` only and `AppFailure.fromHttp` reads the old nested `error` object.

- [ ] **Step 3: Extend the observability abstraction**

Add these methods to `Observability`:

```dart
void logApiResponse({
  required String method,
  required String path,
  required int statusCode,
  required int latencyMs,
  required String message,
  String? traceId,
  String? code,
});

void logApiError({
  required String method,
  required String path,
  required int? statusCode,
  required int latencyMs,
  required String code,
  String? traceId,
});
```

Implement the methods in `NoopObservability` and `DebugObservability`. `DebugObservability` must call `developer.log` with only those scalar fields and an allowlisted event name; it must not receive or serialize `ApiResponse.data`.

- [ ] **Step 4: Update `ApiClient` and `AppFailure`**

Construct `ApiResponse` from `data`, `message`, `statusCode`, `meta`, `code` and `details`. Start a stopwatch before the demo simulation/HTTP send and log after decoding. For non-2xx responses, call `AppFailure.fromHttp`, emit `logApiError`, then rethrow. For timeout, `http.ClientException` and decode failures, emit `logApiError` with a stable safe code and rethrow the existing `AppFailure`.

Change `AppFailure.fromHttp` to parse the new shape:

```dart
final code = payload['code'] as String? ?? 'HTTP_ERROR';
final message = payload['message'] as String? ?? 'Ocurrió un error inesperado.';
final rawDetails = payload['details'];
```

Keep a fallback to `payload['error']` only for the controlled compatibility fixture; API-generated errors must use the new top-level fields. Read `meta.traceId` into an optional `traceId` property if present.

- [ ] **Step 5: Inject the logger without changing feature boundaries**

Create one configured `DebugObservability` in `AppServices.create()` using the current environment, pass it to `ApiClient`, and return the same instance in `AppServices`. Keep `ApiClient` test construction valid by defaulting to `const NoopObservability()` when no sink is supplied.

- [ ] **Step 6: Run Flutter tests and analysis**

Run: `flutter test --no-pub`

Expected: PASS, including the new envelope/error/logging assertions.

Run: `flutter analyze`

Expected: no analyzer errors.

- [ ] **Step 7: Commit Flutter contract and logging**

```bash
git add lib/core/observability lib/core/network/api_client.dart lib/core/errors/app_failure.dart lib/app/bootstrap/app_services.dart test
git commit -m "feat: log sanitized api responses in mobile"
```

---

### Task 4: Synchronize OpenAPI and project specifications

**Files:**
- Modify: `context_specs/contracts/openapi.yaml`
- Modify: `context_specs/specs/SPEC-002-api-contract.md`
- Modify: `context_specs/specs/SPEC-016-observability.md`
- Modify: `context_specs/traceability.md` if the envelope/observability status changes require a row update

- [ ] **Step 1: Replace the OpenAPI error schema**

Replace `ErrorResponse`/`ApiError` with a single error envelope that requires `data`, `message`, `statusCode`, `code`, `details` and `meta`, where `data` is nullable and `statusCode` is an integer. Keep the stable error-code enum and `ApiMeta` definition.

- [ ] **Step 2: Update every success envelope schema**

For `SessionEnvelope`, `LogoutEnvelope`, `ProfileEnvelope`, `PreferencesEnvelope`, `DashboardEnvelope`, `AccountsEnvelope`, `AccountEnvelope`, `TransactionsEnvelope`, `TransactionEnvelope`, `BeneficiariesEnvelope`, `OperationEnvelope`, `DebtEnvelope`, `CardsEnvelope`, `CardEnvelope`, `CardLimitsEnvelope`, `WalletProvisioningEnvelope`, `InsightsEnvelope`, `ExchangeRateEnvelope`, `NotificationsEnvelope`, `NotificationEnvelope`, `ReadAllNotificationsEnvelope`, `DevicesEnvelope` and `DeviceEnvelope`, require `data`, `message`, `statusCode`, and `meta`; add the `message` and `statusCode` properties while retaining the domain-specific `data` and `ApiMeta` reference.

- [ ] **Step 3: Update the written contract rules**

Change SPEC-002 to state that success and error responses use the shared envelope, that errors have `data: null` plus top-level `code`, and that `meta.nextCursor` remains the pagination field. Change SPEC-016 to state that `api_request` and mobile `api_response`/`api_error` logs include status, latency and correlation while excluding sensitive values.

- [ ] **Step 4: Validate YAML and inspect the diff**

Run from `context_specs`: `ruby -e "require 'yaml'; YAML.load_file('contracts/openapi.yaml'); puts 'OpenAPI YAML OK'"`

Expected: `OpenAPI YAML OK`.

Run: `git diff --check`

Expected: no whitespace errors.

- [ ] **Step 5: Commit the contract documentation**

```bash
git add contracts/openapi.yaml specs/SPEC-002-api-contract.md specs/SPEC-016-observability.md traceability.md
git commit -m "docs: align api envelope and observability contract"
```

---

### Task 5: Remove comments from `binova_app/lib` and preserve Dart behavior

**Files:**
- Modify: every `*.dart` file under `binova_app/lib` that contains comments
- Do not modify: `binova_app/test`, `pubspec.yaml`, `analysis_options.yaml`, platform directories or READMEs

- [ ] **Step 1: Capture the pre-cleanup comment inventory**

Run from `binova_app`: `rg -n --glob '*.dart' '(^|[[:space:]])//|/\*|\*/' lib > /private/tmp/binova-lib-comments-before.txt`

Expected: a non-empty inventory proving the cleanup has work to do.

- [ ] **Step 2: Run a lexical comment stripper**

Use a temporary Dart scanner outside the repository that tracks single-quoted, double-quoted, triple-quoted and raw string states, removes `//`, `///`, `/* ... */` and `/** ... */` only while in normal code, and preserves newlines. Apply it only to files from `binova_app/lib` selected by `rg --files lib -g '*.dart'`. Do not use a regex-only replacement because URLs, regular expressions and string content must remain unchanged.

- [ ] **Step 3: Format and verify comment removal**

Run: `dart format lib`

Expected: all changed Dart files are formatted.

Run: `rg -n --glob '*.dart' '(^|[[:space:]])//|/\*|\*/' lib`

Expected: no output.

Run: `rg -n --glob '*.dart' '(^|[[:space:]])//|/\*|\*/' test pubspec.yaml analysis_options.yaml || true`

Expected: any existing comments remain outside the requested scope; no file outside `lib` is changed by this task.

- [ ] **Step 4: Re-run Flutter verification**

Run: `flutter test --no-pub && flutter analyze`

Expected: tests pass and analyzer reports no errors after comment removal.

- [ ] **Step 5: Commit the scoped cleanup**

```bash
git add lib
git commit -m "chore: remove comments from mobile source"
```

---

### Task 6: Update both READMEs and record evidence/gaps

**Files:**
- Modify: `binova_app/README.md`
- Modify: `api_binova/README.md`
- Create: `context_specs/evidence/response-logging-validation-2026-10-05.md`
- Create: `context_specs/evidence/technical-test-gap-report-2026-10-05.md`

- [ ] **Step 1: Update the Flutter README**

Document:

```text
flutter pub get
flutter analyze
flutter test --no-pub
flutter run --dart-define=API_BASE_URL=http://localhost:3000/v1 --dart-define=ENVIRONMENT=local
```

Add the current response example with `data`, `message`, `statusCode` and `meta`, explain that API logs appear in the debug console through `dart:developer`, list the scalar fields logged, and explicitly state that response data, tokens, credentials, balances and card/account secrets are not logged.

- [ ] **Step 2: Update the API README**

Document setup, migrations, seed, `npm test -- --runInBand`, `npm run build`, `npx prisma validate`, `/v1` and `/docs`, the response/error examples, `X-Correlation-Id`, JSON request logs, the redaction policy and the currently implemented endpoint groups. Remove claims that Firebase/FCM or other future integrations are already complete.

- [ ] **Step 3: Write the evidence note**

Record exact commands, date, branch/commit, focused/full test results, build/analyze results, one smoke response example and the log redaction checks. Mark any command that cannot run because an external service or credential is unavailable instead of claiming success.

- [ ] **Step 4: Write the technical-test gap report**

Map each required item to `implemented`, `partial` or `missing` with evidence:

| Requirement | Expected final classification to verify |
|---|---|
| Onboarding/authentication | Implemented |
| Accounts, balances and movements | Implemented |
| Dynamic personalization | Implemented in bounded dashboard configuration |
| Real external service | Partial until a real FX provider request is demonstrated with configuration |
| Push notifications | Partial/missing for real FCM delivery, credentials and deep-link proof |
| Production monitoring | Partial: structured logs/correlation exist; crash/metrics/dashboard/alerts remain |
| Limited connectivity/latency/partial outage | Implemented in demo mode if tests/evidence pass |
| Unit/widget/E2E tests | Partial: unit/widget exist; critical E2E must be added or evidenced |
| AI usage documentation | Implemented if existing AI log is current and linked |
| Architecture decisions/diagrams | Partial until ADRs/diagrams are linked and current |
| Deployment/operation strategy | Partial until a reproducible deployment runbook exists |
| Trunk Based Development/history | Verify from repository history and CI; classify missing if no CI gate exists |

- [ ] **Step 5: Commit documentation and evidence**

Commit each repository separately so no file is staged across repository boundaries:

```bash
cd /Users/jorge/Desktop/workspace/binova_app
git add README.md
git commit -m "docs: update mobile runbook"

cd /Users/jorge/Desktop/workspace/api_binova
git add README.md
git commit -m "docs: update api runbook"

cd /Users/jorge/Desktop/workspace/context_specs
git add evidence/response-logging-validation-2026-10-05.md evidence/technical-test-gap-report-2026-10-05.md
git commit -m "docs: record validation and technical test gaps"
```

---

### Task 7: Run the integrated verification and hand off the result

**Files:**
- Read-only verification across `binova_app`, `api_binova` and `context_specs`

- [ ] **Step 1: Run backend verification**

From `api_binova`, run:

```bash
npm test -- --runInBand
npm run build
npx prisma validate
```

Expected: all Jest tests pass, NestJS builds, and Prisma schema validation succeeds.

- [ ] **Step 2: Run mobile verification**

From `binova_app`, run:

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test --no-pub
```

Expected: formatting check, analyzer and tests all pass.

- [ ] **Step 3: Verify contract and scope**

Run from the workspace:

```bash
rg -n '"data"|"message"|"statusCode"|"meta"|"code"' context_specs/contracts/openapi.yaml api_binova/src/common binova_app/lib/core/network binova_app/lib/core/errors
rg -n --glob '*.dart' '(^|[[:space:]])//|/\*|\*/' binova_app/lib
git -C binova_app status --short
git -C api_binova status --short
git -C context_specs status --short
```

Expected: contract references show the new fields, the comment scan has no output, and each repository contains only the intended committed/uncommitted changes.

- [ ] **Step 4: Produce the final handoff**

Report the actual API response shape, where to view mobile/API logs, which tests/builds passed, the three repository commit IDs, and the gap report classifications. Distinguish completed implementation from items that remain partial or unavailable because of external credentials/services.
