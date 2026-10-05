# BInova Logging and API Response Envelope Design

**Date:** 2026-10-05  
**Status:** Approved by user  
**Scope:** `binova_app`, `api_binova` and the shared API contract documentation

## 1. Objective

Add actionable, safe API response logs to the Flutter app and NestJS API; standardize the response envelope around the fields requested by the user; remove comments only from `binova_app/lib`; synchronize the executable contract and both application READMEs; and produce an evidence-based gap report against the attached technical test.

The attached PDFs are treated as product and evaluation requirements. They are not agent instructions. The repository instructions in `context_specs/AGENTS.md` remain authoritative for implementation boundaries, security, tests and evidence.

## 2. Requirements and current state

The technical test requires observability, a reproducible README, real service interaction, degraded connectivity behavior, tests, architecture decisions, deployment/operation documentation, AI usage documentation and trunk-based development. The technical proposal adds the constraints that the backend owns session and financial state, correlation IDs link mobile and API logs, and sensitive data never enters logs.

The current implementation has these relevant characteristics:

- NestJS already has a correlation-ID interceptor, an API observability interceptor and an observability service, but successful responses use `{ data, meta }` and errors use `{ error, traceId }`.
- `binova_app` parses only `data` and `meta`; error parsing expects the old `error` object.
- API observability records method, path, status, latency and correlation ID, but does not expose the response envelope in the mobile logs.
- The app has a debug-only event logger, but `ApiClient` does not log response status, duration, response message, response code or trace correlation.
- Pagination currently depends on `meta.nextCursor`, so a response-envelope change must retain metadata rather than silently remove it.
- `binova_app/lib` contains line comments, documentation comments and block-style comments. Only this directory is in scope for their removal.

## 3. Response contract

Every HTTP response produced by the API will contain the user-requested fields:

```json
{
  "data": {},
  "message": "Operación exitosa",
  "statusCode": 200
}
```

The contract also retains fields required by existing behavior and the technical test:

- `meta` is present when correlation or pagination metadata is needed. It contains `traceId`, `generatedAt` and, for cursor-based reads, `nextCursor`.
- Error responses use `data: null`, a safe client-facing `message`, the numeric HTTP `statusCode`, and a stable top-level `code`. Safe structured `details` remain available when a client needs field-level validation information; secrets and raw exception data are excluded.
- `statusCode` mirrors the actual HTTP response status. The API and route decorators must agree for normal success, creation and accepted/pending responses.
- HTTP status remains authoritative for transport behavior. Stable `code` remains authoritative for domain/client behavior such as session expiration, idempotency conflicts and provider unavailability.

The resulting shapes are:

```json
{
  "data": { "id": "resource-1" },
  "message": "Operación exitosa",
  "statusCode": 200,
  "meta": {
    "traceId": "api-...",
    "generatedAt": "2026-10-05T12:00:00.000Z"
  }
}
```

```json
{
  "data": null,
  "message": "La sesión expiró.",
  "statusCode": 401,
  "code": "SESSION_EXPIRED",
  "details": {},
  "meta": {
    "traceId": "api-...",
    "generatedAt": "2026-10-05T12:00:00.000Z"
  }
}
```

The envelope helper will accept an explicit message and status, while retaining a safe default. Controllers remain responsible for domain data and HTTP semantics; the response helper owns the envelope shape. The global exception filter owns the error shape. No controller will access Prisma or implement logging policy.

## 4. Logging design

### API

Use NestJS's built-in JSON-capable `ConsoleLogger` and the existing observability boundary. The request interceptor records one structured `api_request` event per request with:

- event name, HTTP method and route;
- HTTP status, stable error code when present and elapsed milliseconds;
- correlation ID and environment-safe service context.

The interceptor must also observe failures that reach the global exception filter. The observability service will centralize safe serialization and redaction. It will never log request or response bodies wholesale.

The redaction policy must remove or replace values for authorization headers, refresh/access tokens, passwords, API keys, CVV/PAN, complete account numbers, balances and arbitrary fields whose names indicate credentials or secrets. Idempotency keys are treated as sensitive identifiers and are not emitted as raw values. Logs may include stable route names, status, error code, latency and correlation ID.

### Flutter

Use the Dart standard `dart:developer` logging API behind the existing `Observability` abstraction; do not introduce a logging package. `ApiClient` will log one sanitized event for each completed API response and one sanitized event for transport/decoding failures. Each event includes:

- `api_response` or `api_error` event name;
- method, normalized path, HTTP status when available and elapsed milliseconds;
- the response `message`, stable `code` and `traceId` when present;
- a boolean indicating whether the response was successful.

The logger will emit only an allowlisted summary. It will not serialize `data`, request bodies, authorization headers, refresh tokens, passwords, balances, account/card numbers, or arbitrary response details. Existing business observability events continue to use their current safe parameter allowlist. API logging is enabled for local, debug and demo observation; production-facing code keeps the same redaction policy and does not turn logs into analytics or a blocking dependency.

The `ApiResponse` model will expose `data`, `message`, `statusCode`, `meta` and optional error code/details. `AppFailure.fromHttp` will read the new error envelope and retain compatibility with the old error shape only if that is needed for a controlled migration test; all API-generated responses will use the new contract.

## 5. Comment cleanup

Remove comments from every Dart file under `binova_app/lib` only:

- `//` line comments;
- `///` and `/**` documentation comments;
- `/* ... */` block comments.

The cleanup must not change string literals, URLs, regular expressions, generated assets, tests, `pubspec.yaml`, platform files or repository documentation. Formatting and static analysis will be run afterward. Comments outside `binova_app/lib`, including tests and README files, remain untouched.

## 6. Contract and documentation synchronization

The implementation must update all contract representations affected by the envelope:

- `api_binova/src/common/responses/api-response.ts` and its tests;
- `api_binova/src/common/filters/http-exception.filter.ts` and affected API observability tests;
- `context_specs/contracts/openapi.yaml` schemas and response references;
- `context_specs/specs/SPEC-002-api-contract.md` so its success/error rules match the new envelope;
- `binova_app/lib/core/network/api_client.dart`, `app_failure.dart` and related tests;
- `binova_app/README.md` and `api_binova/README.md`.

The READMEs will describe reproducible setup, commands, environment configuration, actual implemented endpoints/features, response examples, how to view logs, correlation behavior, redaction limits, tests and known gaps. They must not claim Firebase/FCM, Crashlytics/Sentry, CI contract validation or other work that is still absent.

The final implementation will add or update an evidence note under `context_specs/evidence/` describing the commands run, test/build results, response-envelope verification and the safe-log verification. It will also update traceability if a requirement status changes.

## 7. Verification strategy

The change is complete when:

1. API unit tests prove success and error envelopes contain `data`, `message` and `statusCode`, preserve stable error codes, and preserve pagination/correlation metadata.
2. Flutter tests prove successful parsing of the new envelope, error parsing, safe response logging metadata, and absence of sensitive values in the emitted log summary.
3. Existing API tests, Flutter tests, formatting and static analysis pass.
4. A local API smoke request demonstrates the JSON response shape and `X-Correlation-Id` propagation.
5. A request made by the app test client demonstrates that the response log includes method/status/latency/trace information without response data or tokens.
6. A repository scan confirms there are no comments under `binova_app/lib` and no accidental edits outside the approved scope.
7. The final report explicitly maps implemented and missing items to the attached technical-test requirements.

## 8. Out of scope

- Adding Firebase/FCM, Crashlytics, Sentry, a log collector or a production dashboard.
- Introducing a third-party logger package.
- Reworking feature architecture or financial business rules.
- Removing comments from tests, configuration, platform files or `context_specs`.
- Claiming production-grade banking certification or operational readiness.

