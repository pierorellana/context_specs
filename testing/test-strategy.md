# Estrategia de pruebas

## Flutter

- Domain/use cases: unit.
- Repositories, mappers y cache policy: unit.
- Providers: unit.
- Widgets: login, Home sections, account card, transactions, Face ID states, degraded states y accesibilidad.
- Integration test: Login -> Home -> Cuenta -> Movimientos -> Detalle.

La suite completa actual pasa con 16 pruebas. La suite específica de widgets y accesibilidad pasa con 2 pruebas y verifica semántica, etiquetas y objetivos táctiles mínimos.

Comandos:

    fvm flutter test
    fvm flutter test test/widgets_accessibility_test.dart
    fvm flutter test integration_test/critical_flow_test.dart -d DEVICE_ID --dart-define=API_BASE_URL=API_URL

## NestJS

- Services y use cases.
- Controllers con supertest.
- Repositories contra PostgreSQL efímero cuando exista CI.
- Adapter FX fake para CI y real para smoke demo.
- Idempotency y concurrencia.
- Envelope, correlación, sanitización y push aislados de credenciales reales en la suite.

Comandos:

    npm test -- --runInBand --watchman=false
    npm run build
    npx prisma validate

## Contract

Validar OpenAPI y mantener examples. La validación manual del contrato existe en contracts/openapi.yaml; falta integrarla como gate automático del workflow CI.

## Quality gate

dart format, flutter analyze, flutter test, Nest lint/test/build, aplicación de migraciones desde cero y secret scan. Los comandos y resultados ejecutados deben conservarse en evidence/ con fecha.
