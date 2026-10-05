# Evidencia de validación local · 2026-10-04

## Backend con PostgreSQL

Comandos ejecutados desde `binova_api`:

```powershell
docker compose up -d postgres
npm run prisma:deploy
npm run seed
npm run build
npm start
```

Resultados:

- `binova-postgres` ejecutándose en `localhost:5432`.
- Migraciones Prisma `0001_init` a `0004_cards` aplicadas; esquema actualizado.
- Seed demo aplicado.
- `GET /v1/health` respondió `{"status":"ok"}`.
- Login demo respondió con sesión completa.
- Lecturas autenticadas verificadas para dashboard, cuentas, movimientos,
  tarjetas, insights y exchange rates.

Credencial demo: `demo@binova.local` / `Demo1234!`.

## Flutter

Comandos ejecutados desde `binova_app`:

```powershell
dart analyze lib
flutter test --no-pub -r expanded
cd android
./gradlew.bat app:assembleDebug
```

Resultados:

- Análisis sin errores; quedaron únicamente avisos informativos de estilo del analyzer.
- 8 tests Flutter pasando.
- APK debug compilado correctamente.
- Developer Tools disponible en debug/demo para normal, slow, offline, server
  error y timeout.
- APK `android-x64` instalada y ejecutada en el emulador `emulator-5554`.
- Flujos visuales verificados: onboarding, login, inicio, tarjetas, creación
  de tarjeta virtual, insights, notificaciones, transferencia, pago de
  servicio, recarga, conversor y perfil/seguridad.
- La creación de tarjeta virtual avanzó correctamente hasta la validación
  biométrica; el AVD reportó Face ID no disponible, por lo que no se envió la
  solicitud de creación durante esta validación.
- No se observaron excepciones `FATAL EXCEPTION`, `E/flutter` ni errores no
  controlados en el logcat del paquete.

## Validación de repositorios

- App: commits `8f270f4`, `2536f60` y `f802e0c` publicados en `binova_app`.
- API: commits `98dd2d4` y `7914694` publicados en `api_binova`.
- Context: commit `5712895` publicado en `context_specs`.
- Los tres `main` quedaron sin cambios locales pendientes al cierre de esta evidencia.

## Pendiente externo

La validación de push real y Firebase/FCM queda pendiente de las credenciales
del ambiente; los endpoints de dispositivos y notificaciones ya están
disponibles para fixtures.

También quedan pendientes la automatización E2E/CI, validación OpenAPI en pipeline y
el build release/demo como artefacto final.
