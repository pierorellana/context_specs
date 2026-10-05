# Límites de integración

## Flutter <-> NestJS
- JSON/HTTPS.
- Envelope de éxito y error estable.
- Versionado `/v1`.
- `X-Correlation-Id` propagado.
- `Idempotency-Key` obligatorio en operaciones financieras de escritura.

## NestJS <-> FX
- Puerto/adaptador reemplazable con timeout explícito, cache y fallback stale.
- Configuración y credenciales solo en NestJS por ambiente; ver ADR-016.
- Credenciales solo backend.
- El proveedor se puede reemplazar sin nueva versión Flutter.

## Flutter <-> Firebase
- FCM para token/push.
- Crashlytics/Analytics/Performance por configuración de ambiente.
- Payload de push contiene tipo y resourceId; nunca saldo ni PII sensible.
- Estado actual: Firebase Messaging/Admin y el contrato de dispositivos/inbox están
  implementados para Android. Las credenciales privadas permanecen únicamente en el API
  por ambiente; la validación manual de entrega y deep link requiere un dispositivo o
  emulador con Google Play Services y conectividad hacia el API.
