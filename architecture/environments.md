# Ambientes

| Ambiente | Mobile | API | Datos | Observabilidad |
|---|---|---|---|---|
| local | debug | localhost, LAN o túnel | seed demo | consola redactada |
| dev | internal | desplegable según entorno | demo persistente | pendiente |
| test | CI | previsto, aún sin workflow | fixtures | pendiente |
| demo | release/profile | no desplegado en este workspace | seed controlado | pendiente |
| prod-evolution | store | fuera del alcance de la prueba | real | fuera del alcance |

Variables comunes: API_BASE_URL, ENVIRONMENT, ENABLE_DEMO_TOOLS, MIN_APP_VERSION.

El cliente Flutter admite API_BASE_URL por dart-define. El valor por defecto actual del proyecto es el túnel de desarrollo https://9hqbzkgw-3000.use.devtunnels.ms/v1 para facilitar pruebas con dispositivos físicos fuera de la red local. Para ejecución local se puede sobrescribir con:

- Android Emulator: http://10.0.2.2:3000/v1
- iOS Simulator, escritorio y web: http://localhost:3000/v1
- Dispositivo físico en la misma LAN: http://IP_DEL_HOST:3000/v1
- Dispositivo físico sin acceso a la LAN: URL HTTPS de un túnel accesible

La disponibilidad real de Face ID o biometría se detecta durante bootstrap. En Android el MVP requiere minSdk 23, compileSdk 36 y NDK 27.0.12077973; en iOS se declara NSFaceIDUsageDescription.

Variables exclusivas del backend FX: FX_PROVIDER_BASE_URL, FX_PROVIDER_NAME, FX_PROVIDER_API_KEY si aplica, FX_PROVIDER_TIMEOUT_MS, FX_CACHE_TTL_SECONDS y FX_STALE_MAX_AGE_SECONDS. Los secretos nunca se versionan ni se envían al mobile.

Firebase/FCM Android está configurado en el proyecto local: Flutter usa android/app/google-services.json y el API usa FIREBASE_SERVICE_ACCOUNT_PATH, PUSH_ENABLED y PUSH_TEST_ENDPOINT_ENABLED. La cuenta de servicio se mantiene fuera de los repositorios. Android push fue validado manualmente por el usuario en foreground, background y app terminada. Falta configurar secretos equivalentes en cada ambiente desplegado.
