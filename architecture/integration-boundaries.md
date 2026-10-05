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
- Estado actual: frontera documentada y contrato de dispositivos/inbox implementado;
  SDK, credenciales, recepción push y deep links reales quedan pendientes.
