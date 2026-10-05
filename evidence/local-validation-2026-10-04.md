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
- Migraciones Prisma `0001` a `0004` aplicadas; esquema actualizado.
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

- Análisis sin issues.
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

## Pendiente externo

La validación de push real y Firebase/FCM queda pendiente de las credenciales
del ambiente; los endpoints de dispositivos y notificaciones ya están
disponibles para fixtures.
