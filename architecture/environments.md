# Ambientes

| Ambiente | Mobile | API | Datos | Observabilidad |
|---|---|---|---|---|
| local | debug | localhost/LAN | seed demo | consola redactada |
| dev | internal | no desplegado en este workspace | demo persistente | pendiente |
| test | CI | previsto, aún sin workflow | fixtures | pendiente |
| demo | release/profile | no desplegado en este workspace | seed controlado | pendiente |
| prod-evolution | store | fuera del alcance de la prueba | real | fuera del alcance |

Variables comunes: `API_BASE_URL`, `ENVIRONMENT`, `ENABLE_DEMO_TOOLS`, `MIN_APP_VERSION`.

El cliente Flutter usa `local_auth` para Face ID/biometría. En Android Emulator el
valor local por defecto es `http://10.0.2.2:3000/v1`; en iOS Simulator, escritorio y
web es `http://localhost:3000/v1`. `API_BASE_URL` puede sobrescribirlo. En Android el MVP requiere
minSdk 23, compileSdk 36 y NDK 27.0.12077973; en iOS se declara
`NSFaceIDUsageDescription`. La disponibilidad real se detecta durante bootstrap.

Variables exclusivas del backend FX: `FX_PROVIDER_BASE_URL`, `FX_PROVIDER_NAME`,
`FX_PROVIDER_API_KEY` si aplica, `FX_PROVIDER_TIMEOUT_MS`, `FX_CACHE_TTL_SECONDS` y
`FX_STALE_MAX_AGE_SECONDS`. La configuración sigue ADR-016 y los secretos nunca se
versionan ni se envían al mobile.

Firebase/FCM todavía no está configurado porque faltan los archivos y credenciales de
cada ambiente. Los endpoints de dispositivos y el contrato de notificaciones están
implementados y pueden probarse con fixtures.
