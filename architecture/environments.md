# Ambientes

| Ambiente | Mobile | API | Datos | Observabilidad |
|---|---|---|---|---|
| local | debug | localhost/LAN | seed demo | consola redactada |
| dev | internal | dev API | demo persistente | Firebase/Sentry dev |
| test | CI | ephemeral | fixtures | reporte CI |
| demo | release/profile | demo API | seed controlado | dashboards demo |
| prod-evolution | store | prod API | real | controles reforzados |

Variables comunes: `API_BASE_URL`, `ENVIRONMENT`, `ENABLE_DEMO_TOOLS`, `MIN_APP_VERSION`.

El cliente Flutter usa `local_auth` para Face ID/biometría. En Android el MVP requiere
minSdk 23, compileSdk 36 y NDK 27.0.12077973; en iOS se declara
`NSFaceIDUsageDescription`. La disponibilidad real se detecta durante bootstrap.

Variables exclusivas del backend FX: `FX_PROVIDER_BASE_URL`, `FX_PROVIDER_NAME`,
`FX_PROVIDER_API_KEY` si aplica, `FX_PROVIDER_TIMEOUT_MS`, `FX_CACHE_TTL_SECONDS` y
`FX_STALE_MAX_AGE_SECONDS`. La configuración sigue ADR-016 y los secretos nunca se
versionan ni se envían al mobile.

Firebase/FCM se configurará en la fase final cuando se entreguen los archivos y
credenciales de cada ambiente. Mientras tanto, los endpoints de dispositivos y el
contrato de notificaciones permanecen definidos y pueden probarse con fixtures.
