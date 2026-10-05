# Android Push Notifications Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use inline execution with checkpoints to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deliver Android-only Firebase Cloud Messaging for BInova with safe API dispatch, foreground local notifications, background/terminated handling, device lifecycle, and validated deep links.

**Architecture:** NestJS owns notification persistence, device registrations, FCM delivery, invalid-token revocation, and notification-producing business events. Flutter owns Firebase initialization, Android permission/token lifecycle, foreground presentation, background/tap callbacks, and allowlisted navigation. The API persists the inbox notification before dispatching FCM after the database transaction commits.

**Tech Stack:** NestJS 11, Firebase Admin Node SDK, PostgreSQL/Prisma, Flutter/Dart, `firebase_core`, `firebase_messaging`, `flutter_local_notifications`, Provider, Android Gradle Plugin.

## Global Constraints

- Android only; do not add Firebase configuration or behavioral changes to iOS.
- `com.example.binova_app` and Firebase project `binova-92083` must match the supplied Android configuration.
- The service-account JSON is local-only, ignored by Git, never copied to the app, and never printed or logged.
- FCM payload data contains only `type`, `notificationId`, `resourceType`, and `resourceId`.
- Do not log FCM tokens, access tokens, balances, amounts, account numbers, card data, or service-account fields.
- The existing API response envelope remains `{data,message,statusCode,meta}` for successful responses and the existing error envelope for failures.
- The existing `/v1/devices` and `/v1/notifications` contracts remain compatible; new routes and fields update OpenAPI and traceability.
- No comments are added under `binova_app/lib`; existing comments outside that scope remain untouched.
- Every implementation task ends with focused tests or a documented environment limitation.

---

### Task 1: Protect local Firebase credentials and add configuration contract

**Files:**
- Modify: `/Users/jorge/Desktop/workspace/api_binova/.gitignore`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/.env.example`
- Create locally, do not commit: `/Users/jorge/Desktop/workspace/api_binova/.env`
- Preserve locally, do not commit: `/Users/jorge/Desktop/workspace/api_binova/binova-92083-firebase-adminsdk-fbsvc-9500400d3b.json`

**Interfaces:**
- Produces `FIREBASE_SERVICE_ACCOUNT_PATH`, `PUSH_ENABLED`, and `PUSH_TEST_ENDPOINT_ENABLED` configuration consumed by the API push module.

- [ ] **Step 1: Verify the service-account file is untracked and contains the expected project without printing secrets.**

Run:

```bash
git -C /Users/jorge/Desktop/workspace/api_binova status --short
node -e "const fs=require('fs'); const p='binova-92083-firebase-adminsdk-fbsvc-9500400d3b.json'; const v=JSON.parse(fs.readFileSync(p)); if(v.project_id!=='binova-92083'||!v.client_email||!v.private_key) process.exit(1); console.log(v.project_id, v.client_email)"
```

Expected: the JSON is untracked and the command prints only the project id and service-account email.

- [ ] **Step 2: Add an explicit ignore rule before any implementation commit.**

Add this line to `.gitignore`:

```gitignore
*firebase-adminsdk*.json
```

Keep the existing `.env` rules unchanged.

- [ ] **Step 3: Document local and production configuration.**

Append to `.env.example`:

```env
FIREBASE_SERVICE_ACCOUNT_PATH=./binova-92083-firebase-adminsdk-fbsvc-9500400d3b.json
PUSH_ENABLED=false
PUSH_TEST_ENDPOINT_ENABLED=false
```

Create the ignored local `.env` with `PUSH_ENABLED=true` and `PUSH_TEST_ENDPOINT_ENABLED=true` for local development. Production uses a secret manager or environment-injected credentials.

- [ ] **Step 4: Verify the credential is ignored and not staged.**

```bash
git -C /Users/jorge/Desktop/workspace/api_binova check-ignore -v binova-92083-firebase-adminsdk-fbsvc-9500400d3b.json
git -C /Users/jorge/Desktop/workspace/api_binova diff --check
```

Expected: `check-ignore` reports the new rule and `diff --check` is clean.

- [ ] **Step 5: Commit only the ignore/config example changes.**

```bash
git -C /Users/jorge/Desktop/workspace/api_binova add .gitignore .env.example
git -C /Users/jorge/Desktop/workspace/api_binova commit -m "chore: protect firebase admin credentials"
```

### Task 2: Add the NestJS Firebase Admin gateway

**Files:**
- Modify: `/Users/jorge/Desktop/workspace/api_binova/package.json`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/package-lock.json`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/infrastructure/push/push.types.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/infrastructure/push/push.gateway.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/infrastructure/push/firebase-messaging.gateway.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/infrastructure/push/push.module.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/infrastructure/push/firebase-messaging.gateway.spec.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/app.module.ts`

**Interfaces:**
- `PushGateway.send(message: PushMessage, recipients: readonly PushRecipient[]): Promise<PushDeliveryResult>`.
- `PushMessage` contains `notificationId`, `type`, `title`, `body`, and nullable `resourceType/resourceId`.
- `PushRecipient` contains `deviceId` and `pushToken`; tokens and keys never appear in logs.
- `PushDeliveryResult` contains `sentDeviceIds`, `invalidDeviceIds`, and `failedCount`.

- [ ] **Step 1: Add the dependency.**

Run from `api_binova`:

```bash
npm install firebase-admin
```

Expected: `firebase-admin` appears in `dependencies` and the lockfile changes without unrelated removals.

- [ ] **Step 2: Define the gateway contract and safe message shape.**

Export the three interfaces above. Restrict `resourceType` to `transaction | account | card | session | null` and `type` to `financial | security | informational`.

- [ ] **Step 3: Implement Firebase initialization without embedding credentials.**

`FirebaseMessagingGateway` must read `PUSH_ENABLED` and `FIREBASE_SERVICE_ACCOUNT_PATH` from `ConfigService`, resolve the path from `process.cwd()`, read the JSON only when enabled, initialize the default Firebase app with `cert(serviceAccount)` exactly once, and send with `getMessaging(app).sendEachForMulticast`.

Map invalid registration responses to device ids and count other failures. Disabled push is a no-op result. Delivery failures never throw past the gateway. Logs may contain only enabled/disabled status, delivery counts, correlation id, and Firebase error codes.

- [ ] **Step 4: Register the gateway in an infrastructure module.**

`PushModule` provides and exports the `PushGateway` token. Import it from `AppModule`. Unit-test compilation with `PUSH_ENABLED=false` must not initialize Firebase.

- [ ] **Step 5: Test the gateway with mocked Firebase Admin functions.**

Cover:

```ts
it('returns a no-op result when push is disabled')
it('maps invalid registration responses to device ids')
it('keeps message data limited to routing fields')
it('does not throw when Firebase returns a provider failure')
```

Run:

```bash
npm test -- --runInBand src/infrastructure/push/firebase-messaging.gateway.spec.ts
```

Expected: focused tests pass.

- [ ] **Step 6: Commit the gateway.**

```bash
git add package.json package-lock.json src/infrastructure/push src/app.module.ts
git commit -m "feat: add firebase messaging gateway"
```

### Task 3: Persist and dispatch safe notifications from the API

**Files:**
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/notifications.service.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/notifications.controller.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/notifications.module.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/operations/operations.service.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/operations/operations.module.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/cards/cards.service.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/modules/cards/cards.module.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/dto/create-test-notification.dto.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/notifications.service.spec.ts`
- Create: `/Users/jorge/Desktop/workspace/api_binova/src/modules/notifications/notifications.controller.spec.ts`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/src/common/observability/log-sanitizer.ts`

**Interfaces:**
- `NotificationsService.createInTransaction(tx, input): Promise<string>` inserts the inbox row and returns its id.
- `NotificationsService.dispatch(notificationId): Promise<void>` fetches the notification and active Android devices, invokes `PushGateway`, and revokes invalid registrations.
- `NotificationsService.createDevelopmentTest(userId): Promise<NotificationContract>` creates safe informational content and dispatches it.

- [ ] **Step 1: Add transaction-safe notification creation.**

Use the supplied Prisma transaction client. Require `userId`, `type`, `title`, `body`, `resourceType`, and `resourceId`. Financial operation notifications use:

```text
title: Operación completada
body: Revisa el detalle en BInova.
```

Do not include amount, currency, account, card, or beneficiary values.

- [ ] **Step 2: Add post-commit dispatch and invalid-token revocation.**

Select active Android registrations, pass `{deviceId,pushToken}` to `PushGateway`, revoke every `invalidDeviceId`, and catch provider failures so the original operation remains successful. Observability uses scalar metadata only.

- [ ] **Step 3: Connect transfer, payment, and top-up without duplicate sends.**

Update `OperationsService.executeIdempotent` so a newly created operation creates exactly one notification in the same Prisma transaction. Return the notification id only in the internal helper result, dispatch after the transaction resolves, and return the existing operation contract to controllers. Idempotent replays return the existing operation without creating or dispatching another notification. Use `resourceType: 'transaction'` and the created transaction id.

- [ ] **Step 4: Connect virtual-card creation.**

In the existing card creation transaction, create one informational notification for a newly created virtual card with `resourceType: 'card'` and the card id. Dispatch only after commit. Idempotent replays must not duplicate it.

- [ ] **Step 5: Add a development-only authenticated test route.**

Add `POST /v1/notifications/test` before the parameterized read route. When `PUSH_TEST_ENDPOINT_ENABLED` is not true, return the existing `NOT_FOUND` error shape. When enabled, create:

```json
{
  "type": "informational",
  "title": "Prueba de notificaciones",
  "body": "La integración push de BInova está activa.",
  "resourceType": null,
  "resourceId": null
}
```

Return the standard envelope with HTTP 202 and no token data.

- [ ] **Step 6: Add service/controller tests.**

Cover safe notification creation, active Android selection, invalid-token revocation, delivery failure isolation, idempotent no-duplicate behavior, and the disabled test route.

Run:

```bash
npm test -- --runInBand src/modules/notifications/notifications.service.spec.ts src/modules/notifications/notifications.controller.spec.ts
```

Expected: focused tests pass.

- [ ] **Step 7: Commit notification dispatch integration.**

```bash
git add src/modules/notifications src/modules/operations src/modules/cards src/common/observability/log-sanitizer.ts
git commit -m "feat: dispatch firebase notifications from api events"
```

### Task 4: Configure the Android Flutter Firebase client

**Files:**
- Modify: `/Users/jorge/Desktop/workspace/binova_app/pubspec.yaml`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/pubspec.lock`
- Create: `/Users/jorge/Desktop/workspace/binova_app/lib/firebase_options.dart`
- Create: `/Users/jorge/Desktop/workspace/binova_app/android/app/google-services.json`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/android/settings.gradle.kts`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/android/app/build.gradle.kts`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/android/app/src/main/AndroidManifest.xml`
- Create: `/Users/jorge/Desktop/workspace/binova_app/android/app/src/main/res/drawable/ic_stat_binova.xml`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/lib/main.dart`

**Interfaces:**
- `DefaultFirebaseOptions.android` returns the supplied Firebase Android configuration for project `binova-92083`.
- Firebase initialization runs only on Android; iOS behavior stays unchanged.

- [ ] **Step 1: Add Flutter packages.**

```bash
/Users/jorge/.fvm/versions/3.41.1/bin/flutter pub add firebase_core firebase_messaging flutter_local_notifications
```

Expected: the three packages appear in `pubspec.yaml` and the lockfile changes without unrelated app dependencies.

- [ ] **Step 2: Add the exact Android Firebase config.**

Copy `/Users/jorge/Downloads/google-services (4).json` to `android/app/google-services.json`. Verify the package is `com.example.binova_app`. Do not alter the supplied values.

- [ ] **Step 3: Generate the Android-only options file.**

Create `lib/firebase_options.dart` from the supplied JSON:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMnAZS1QKWWK_hbXOTN-k7-fuvf9oQKh4',
    appId: '1:475028356738:android:111e8f4e7713f09a967e9b',
    messagingSenderId: '475028356738',
    projectId: 'binova-92083',
    storageBucket: 'binova-92083.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) return android;
    throw UnsupportedError('Firebase is configured only for Android.');
  }
}
```

- [ ] **Step 4: Apply Android Firebase and notification configuration.**

Add the Google Services plugin to `android/settings.gradle.kts` and `android/app/build.gradle.kts`. Add `POST_NOTIFICATIONS` to the manifest, define a default notification channel id, add its application metadata, and create a white `ic_stat_binova` drawable.

- [ ] **Step 5: Initialize Firebase before app services.**

After `WidgetsFlutterBinding.ensureInitialized()` and before `AppServices.create()`, initialize Firebase on Android using `DefaultFirebaseOptions.android`. Keep existing orientation/system UI setup and do not initialize Firebase on iOS.

- [ ] **Step 6: Format and compile.**

```bash
/Users/jorge/.fvm/versions/3.41.1/bin/dart format lib/main.dart lib/firebase_options.dart
/Users/jorge/.fvm/versions/3.41.1/bin/flutter pub get
/Users/jorge/.fvm/versions/3.41.1/bin/flutter build apk --debug
```

Expected: formatting succeeds and the debug APK compiles. Record any local Flutter cache permission failure exactly.

- [ ] **Step 7: Commit Android Firebase configuration.**

```bash
git add pubspec.yaml pubspec.lock lib/main.dart lib/firebase_options.dart android/settings.gradle.kts android/app/build.gradle.kts android/app/src/main/AndroidManifest.xml android/app/src/main/res
git commit -m "feat: configure firebase messaging on android"
```

### Task 5: Implement Flutter push lifecycle and safe navigation

**Files:**
- Create: `/Users/jorge/Desktop/workspace/binova_app/lib/core/notifications/push_notification_payload.dart`
- Create: `/Users/jorge/Desktop/workspace/binova_app/lib/core/notifications/push_notification_service.dart`
- Create: `/Users/jorge/Desktop/workspace/binova_app/lib/core/storage/push_registration_store.dart`
- Create: `/Users/jorge/Desktop/workspace/binova_app/lib/features/notifications/domain/notification_link.dart`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/lib/features/notifications/presentation/pages/notifications_page.dart`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/lib/app/bootstrap/app_services.dart`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/lib/app/app.dart`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/lib/features/auth/presentation/providers/auth_controller.dart`

**Interfaces:**
- `PushNotificationPayload.fromRemoteMessage(RemoteMessage message): PushNotificationPayload?` validates the four data fields.
- `PushRegistrationStore.readDeviceId(): Future<String?>`, `writeDeviceId(String)`, and `clearDeviceId()` persist only the API device registration id.
- `PushNotificationService.activate(): Future<void>` starts permission/token/listener setup for an authenticated Android session.
- `PushNotificationService.deactivate(): Future<void>` revokes the saved registration when possible, cancels listeners, and clears the saved id.
- `NotificationLink.fromPayload(PushNotificationPayload payload): NotificationLink?` allows only existing transaction/account/card/session destinations.

- [ ] **Step 1: Extract the existing notification link allowlist.**

Move the private link mapping from `notifications_page.dart` into `notification_link.dart`, preserving transaction, account, card, informational, and security mappings. Unknown resource types return `null`. Update the page without changing current behavior.

- [ ] **Step 2: Implement payload validation.**

Accept only `financial`, `security`, and `informational`; require a non-empty `notificationId`; allow nullable resource fields; copy no arbitrary data into navigation. Local notification payload JSON contains only the four allowlisted fields.

- [ ] **Step 3: Implement registration storage.**

Use `SharedPreferences` key `binova.push.registration.v1`. Store only the API registration id, never the FCM token. Malformed/missing values return `null`.

- [ ] **Step 4: Implement all message states.**

`PushNotificationService` must return on non-Android, create `binova_general`, request Android 13+ permission, register the token through `ProfileRepository.registerDevice(platform: 'android', ...)`, handle `onTokenRefresh`, display local notifications for `onMessage`, handle `onMessageOpenedApp`, consume `getInitialMessage`, and navigate only through the shared link resolver. It must cancel listeners and revoke the saved registration on normal logout. Token and message contents are never logged.

Define a top-level `@pragma('vm:entry-point')` background callback that initializes Firebase in the background isolate and does not access UI state. Background notification payloads use the Android tray; foreground payloads use the local notification plugin.

- [ ] **Step 5: Wire lifecycle into auth and navigation.**

Pass a push service to `AuthController`. Activate after password login and biometric unlock. Deactivate before clearing the session during logout; revocation failure must not block local logout. Add a `GlobalKey<NavigatorState>` used by `MaterialApp.navigatorKey` and the push tap handler. Keep HTTP/business rules outside widgets.

- [ ] **Step 6: Add Flutter unit tests.**

Create tests for malformed payload rejection, allowed transaction navigation, unknown-resource fallback, registration-id-only storage, non-Android no-op, and auth activation/deactivation. Use fakes for Firebase messaging, local presentation, profile repository, and navigation.

- [ ] **Step 7: Run Flutter validation.**

```bash
/Users/jorge/.fvm/versions/3.41.1/bin/dart format lib test
/Users/jorge/.fvm/versions/3.41.1/bin/flutter test --no-pub
DART_SUPPRESS_ANALYTICS=true /Users/jorge/.fvm/versions/3.41.1/bin/cache/dart-sdk/bin/dart analyze
```

Expected: tests pass and analysis reports no errors. Platform guards are tested through injected fakes rather than environment mutation.

- [ ] **Step 8: Commit Flutter lifecycle.**

```bash
git add lib test
git commit -m "feat: handle android push notification lifecycle"
```

### Task 6: Update contracts, traceability, README files, and evidence

**Files:**
- Modify: `/Users/jorge/Desktop/workspace/context_specs/specs/SPEC-013-notifications.md`
- Modify: `/Users/jorge/Desktop/workspace/context_specs/adr/ADR-008-push-deep-links.md`
- Modify: `/Users/jorge/Desktop/workspace/context_specs/contracts/openapi.yaml`
- Modify: `/Users/jorge/Desktop/workspace/context_specs/specs/traceability.md`
- Create: `/Users/jorge/Desktop/workspace/context_specs/evidence/android-push-validation-2026-10-05.md`
- Modify: `/Users/jorge/Desktop/workspace/api_binova/README.md`
- Modify: `/Users/jorge/Desktop/workspace/binova_app/README.md`

**Interfaces:**
- OpenAPI documents `POST /v1/notifications/test` as development-only and preserves the response envelope schemas.
- SPEC-013 records Android FCM as implemented while iOS remains out of scope for this iteration.
- Both READMEs explain Firebase files, secret handling, foreground/background/terminated behavior, tests, and remaining production configuration.

- [ ] **Step 1: Update contract and traceability.**

Document the test endpoint request/response, HTTP 202, the configuration gate, and safe FCM data fields. Map implementation to RF-13, RF-14, and RN-14. Do not document private-key contents.

- [ ] **Step 2: Update SPEC-013 and ADR-008.**

Record foreground local notifications, background/terminated FCM behavior, device registration through `/v1/devices`, allowlisted deep links, and iOS configuration as pending/out of scope.

- [ ] **Step 3: Update API README.**

Document:

```bash
cp .env.example .env
# Set FIREBASE_SERVICE_ACCOUNT_PATH to the ignored local JSON path
# Set PUSH_ENABLED=true and PUSH_TEST_ENDPOINT_ENABLED=true for local validation
npm run start:dev
```

Also document the authenticated test call, delivery-failure isolation, invalid-token cleanup, and production secret requirements.

- [ ] **Step 4: Update app README.**

Document `android/app/google-services.json`, `lib/firebase_options.dart`, Android 13 permission behavior, foreground local notification behavior, background/terminated taps, and the need for the API to be reachable from the device. State that the service-account JSON belongs only to the API.

- [ ] **Step 5: Record evidence.**

Capture API tests/build, Flutter tests/analysis, `git check-ignore`, manual Android foreground/background/terminated status, and any unavailable physical-device, Firebase Console, database, or network prerequisite.

- [ ] **Step 6: Commit docs and evidence.**

```bash
git -C /Users/jorge/Desktop/workspace/context_specs add specs/SPEC-013-notifications.md adr/ADR-008-push-deep-links.md contracts/openapi.yaml specs/traceability.md evidence/android-push-validation-2026-10-05.md
git -C /Users/jorge/Desktop/workspace/context_specs commit -m "docs: record android push notification validation"
git -C /Users/jorge/Desktop/workspace/api_binova add README.md
git -C /Users/jorge/Desktop/workspace/api_binova commit -m "docs: document api push setup"
git -C /Users/jorge/Desktop/workspace/binova_app add README.md
git -C /Users/jorge/Desktop/workspace/binova_app commit -m "docs: document android push setup"
```

### Task 7: End-to-end validation and main-branch handoff

**Files:**
- Verify: `/Users/jorge/Desktop/workspace/api_binova`
- Verify: `/Users/jorge/Desktop/workspace/binova_app`
- Verify: `/Users/jorge/Desktop/workspace/context_specs`

- [ ] **Step 1: Run API validation.**

```bash
PATH=/Users/jorge/.nvm/versions/node/v24.5.0/bin:/usr/bin:/bin npm test -- --runInBand
npm run build
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/binova npx prisma validate
```

Expected: tests, build, and Prisma validation pass. A missing local PostgreSQL instance is recorded as an environment limitation.

- [ ] **Step 2: Verify the API manually without exposing secrets.**

Start the API with the ignored `.env`, log in with the existing seeded user, register the Android token from the app, call the enabled test endpoint, and confirm the standard envelope plus inbox row. Inspect logs only for counts/status/codes.

- [ ] **Step 3: Run mobile validation.**

```bash
/Users/jorge/.fvm/versions/3.41.1/bin/flutter test --no-pub
DART_SUPPRESS_ANALYTICS=true /Users/jorge/.fvm/versions/3.41.1/bin/cache/dart-sdk/bin/dart analyze
/Users/jorge/.fvm/versions/3.41.1/bin/flutter build apk --debug
```

Expected: tests and analysis pass; the APK includes Firebase Android configuration.

- [ ] **Step 4: Perform the three-state Android smoke test.**

Verify on a Firebase-enabled Android device/emulator: foreground local display, background tray display, terminated `getInitialMessage` routing, token refresh update, and invalid-token revocation without failing the originating operation.

- [ ] **Step 5: Verify repository hygiene.**

```bash
git -C /Users/jorge/Desktop/workspace/api_binova status --short --branch
git -C /Users/jorge/Desktop/workspace/binova_app status --short --branch
git -C /Users/jorge/Desktop/workspace/context_specs status --short --branch
git -C /Users/jorge/Desktop/workspace/api_binova diff --check
git -C /Users/jorge/Desktop/workspace/binova_app diff --check
git -C /Users/jorge/Desktop/workspace/context_specs diff --check
```

Expected: only the pre-existing mobile `.fvm/` remains untracked; the service-account JSON is ignored; no generated iOS changes appear.

- [ ] **Step 6: Report remaining external prerequisites.**

The final handoff states whether each item was verified: FCM enabled, Android package match, Android 13 permission, device/emulator with Google Play Services, API reachable from device, local database seeded, production secret manager configured, and remote `main` push performed. No remote push is performed without explicit authorization.


