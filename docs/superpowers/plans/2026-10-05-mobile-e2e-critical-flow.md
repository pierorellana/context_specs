# Mobile E2E Critical Flow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add and execute a reproducible Flutter integration test for the critical BInova flow on the connected physical device.

**Architecture:** The test will launch the production app entry point, use the configured Dev Tunnel API, and interact through semantic labels and visible text. It will cover onboarding when present, demo login, home loading, product navigation, account detail, movements, and transaction detail without adding test-only behavior to the application.

**Tech Stack:** Flutter `integration_test`, `flutter_test`, Provider app bootstrap, physical mobile device, BInova API seed.

## Global Constraints

- Use the demo account `demo@binova.local` / `Demo1234!`.
- Use the configured API base URL `https://9hqbzkgw-3000.use.devtunnels.ms/v1`.
- Preserve the Android-only Firebase push scope; this E2E does not test push again.
- Do not add production shortcuts, mock data, or test-only routes.
- Keep evidence under `context_specs/evidence/`.

### Task 1: Configure Flutter integration testing

**Files:**
- Modify: `binova_app/pubspec.yaml`
- Modify: `binova_app/pubspec.lock`

- [x] **Step 1: Add the Flutter SDK integration test dependency**

Add this entry under `dev_dependencies`:

```yaml
  integration_test:
    sdk: flutter
```

- [x] **Step 2: Resolve the dependency lock**

Run:

```bash
fvm flutter pub get
```

Expected: dependency resolution completes successfully and `pubspec.lock` records `integration_test`.

### Task 2: Author the critical flow test

**Files:**
- Create: `binova_app/integration_test/critical_flow_test.dart`

- [x] **Step 1: Initialize the integration binding and launch the app**

The test must call `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`, import `lib/main.dart` as `app`, call `await app.main()`, and wait for the app to settle.

- [x] **Step 2: Handle first-run onboarding without assuming device state**

If `Omitir` is visible, tap it and wait. If onboarding is already complete, continue directly to authentication.

- [x] **Step 3: Fill the login fields and assert Home**

Use the first two `TextField` widgets for username and password, tap the semantic button `Ingresar`, wait for the API response, and assert the demo user name `Pierre` is visible.

- [x] **Step 4: Navigate through products and movements**

Tap the semantic navigation item `Productos`, tap the semantic account card containing `Cuenta de ahorros`, tap `Ver movimientos`, wait for `Movimientos`, tap the first transaction row, and assert that the transaction detail sheet is visible.

- [x] **Step 5: Capture an integration screenshot**

Use `IntegrationTestWidgetsFlutterBinding.instance.takeScreenshot('critical-flow-transaction-detail')` after the final assertion so the device run produces a visual artifact when the platform test runner supports screenshots.

### Task 3: Execute on the connected physical device

**Files:**
- Evidence: `context_specs/evidence/e2e-critical-flow-2026-10-05.md`

- [x] **Step 1: Confirm the physical device and API**

Run:

```bash
fvm flutter devices
curl -i https://9hqbzkgw-3000.use.devtunnels.ms/v1/health
```

Expected: the physical device appears and the API health response is `200`.

- [x] **Step 2: Run the integration test**

Run:

```bash
fvm flutter test integration_test/critical_flow_test.dart -d 00008140-001461680A7B801C
```

Expected: the test finishes with `All tests passed!`.

- [x] **Step 3: Record the result**

Document the device, API URL, command, timestamp, covered steps, result, and any limitation in `context_specs/evidence/e2e-critical-flow-2026-10-05.md`.

### Task 4: Commit the reproducible E2E evidence

**Files:**
- Add: `binova_app/integration_test/critical_flow_test.dart`
- Modify: `binova_app/pubspec.yaml`
- Modify: `binova_app/pubspec.lock`
- Add: `context_specs/evidence/e2e-critical-flow-2026-10-05.md`

- [x] **Step 1: Check formatting and the diff**

Run:

```bash
fvm dart format integration_test/critical_flow_test.dart
git diff --check
```

- [x] **Step 2: Commit after the physical run passes**

```bash
git add pubspec.yaml pubspec.lock integration_test/critical_flow_test.dart ../context_specs/evidence/e2e-critical-flow-2026-10-05.md
git commit -m "test: add critical mobile e2e flow"
```
