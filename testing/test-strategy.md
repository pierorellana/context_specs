# Estrategia de pruebas

## Flutter
- Domain/use cases: unit.
- Repositories/mappers/cache: unit.
- Providers: unit.
- Widgets: login, Home sections, account card, transactions, Face ID states, degraded states.
- Integration test: Login -> Home -> Cuenta -> Movimientos -> Detalle.

## NestJS
- Services/use cases.
- Controllers con supertest.
- Repositories contra PostgreSQL ephemeral.
- Adapter FX fake para CI y real para smoke demo.
- Idempotency/concurrency tests.

## Contract
Validar OpenAPI y mantener examples.

## Quality gate
`dart format`, `flutter analyze`, `flutter test`, Nest lint/test/build, migration apply, secret scan.
