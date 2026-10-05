# Android Push Notifications Design

**Date:** 2026-10-05
**Status:** Approved for implementation
**Scope:** Android only

## Goal

Integrate Firebase Cloud Messaging across the BInova API and Flutter Android app so authenticated users receive safe push notifications while the app is open, in the background, or terminated. Notifications must persist in the existing inbox and navigate only to allowlisted app destinations.

## Constraints

- The Android Firebase application is `com.example.binova_app` in project `binova-92083`.
- The mobile configuration uses `google-services.json` and generated `lib/firebase_options.dart`.
- The API uses Firebase Admin SDK credentials from environment configuration or an explicitly configured local service-account path.
- The service-account JSON must remain ignored and must never be committed, logged, or copied into the mobile app.
- iOS Firebase configuration and notification behavior are out of scope.
- Push data must not contain balances, amounts, account numbers, card data, access tokens, FCM tokens, or other sensitive financial information.

## Architecture

### API

1. `FirebaseMessagingGateway` owns Firebase Admin SDK initialization and FCM delivery.
2. `NotificationsService` remains the authority for notification persistence, inbox contracts, device registration, and token revocation.
3. Successful financial operations and virtual-card creation create an inbox notification inside the same database transaction when the operation is newly created. After commit, the gateway sends the push to active Android registrations.
4. A protected development-only test route creates a non-sensitive notification and exercises the same persistence and delivery path. It is disabled unless explicitly enabled by configuration.
5. Delivery failures do not roll back a successful financial operation. Invalid/unregistered tokens are revoked. Other provider failures are logged with sanitized metadata and can be retried through a later token refresh or test action.

### Mobile

1. Firebase is initialized before `AppServices` and uses `DefaultFirebaseOptions.android`.
2. `PushNotificationService` owns permission requests, token acquisition, token refresh, foreground/background listeners, and registration with `/v1/devices`.
3. `flutter_local_notifications` displays a local Android notification for foreground messages, because FCM notification messages are not automatically shown in the system tray while the app is open.
4. Background messages are handled by the FCM background callback. Notification taps from background and terminated states are consumed through `onMessageOpenedApp` and `getInitialMessage`.
5. Registration is linked to the authenticated session, stored locally by device registration id, and revoked during normal logout when possible.
6. Deep-link payloads are validated against the existing notification route allowlist. Unknown or malformed destinations open Home without blocking the user.

## Payload contract

FCM data contains only routing identifiers:

```json
{
  "type": "financial",
  "notificationId": "uuid",
  "resourceType": "transaction",
  "resourceId": "uuid"
}
```

The visible title and body are safe, generic copy such as `Operación completada` and `Revisa el detalle en BInova`. The inbox stores the same safe content and remains the source for full display context.

## Lifecycle

```text
login/unlock
  -> request Android notification permission
  -> obtain FCM token
  -> POST /v1/devices
  -> listen for token refresh

API operation succeeds
  -> persist Notification + operation in one transaction
  -> send FCM to active Android devices

foreground message
  -> local Android notification

background/terminated tap
  -> validate payload
  -> route to allowlisted resource
  -> refresh/read notification from API

logout
  -> revoke current device registration when available
  -> clear local session
```

## Observability and security

- API logs include delivery outcome, provider error code, device count, notification id, and correlation id; never tokens or message bodies containing user data.
- Mobile logs include lifecycle state and sanitized routing metadata; never FCM tokens or access tokens.
- Missing Firebase credentials disable delivery with a clear operational log in development and a startup/configuration error when push is required in production.
- Android 13+ permission denial is non-fatal: the app remains usable and the user can retry through the notification preference flow.

## Validation

- API unit tests cover Firebase initialization, safe payload construction, successful delivery, invalid-token revocation, provider failure isolation, and the development test route.
- Flutter tests cover Android option initialization, permission/token registration orchestration, foreground message presentation, background/terminated tap routing, malformed payload fallback, and logout revocation.
- Manual validation uses a Firebase-enabled Android device or emulator with Google Play Services and an API reachable from that device.
- Documentation records the required local service-account path, production secret configuration, FCM console state, and known platform limitations.

## Completion criteria

- A logged-in Android device registers an FCM token in `GET /v1/devices`.
- A development test notification appears in the inbox and as a system notification in foreground and background states.
- Tapping a notification from background or terminated state opens the expected allowlisted screen.
- An operation-generated notification is persisted even when FCM delivery is temporarily unavailable.
- No service-account file, FCM token, access token, or financial data is committed or emitted in logs.
