# ADR-001 · Stack y repositorios
**Estado:** aceptado

## Decisión
Flutter/Dart para mobile, NestJS/TypeScript para API, PostgreSQL + Prisma para persistencia,
Firebase para push/telemetría y repositorios separados `binova_app`, `binova_api` y
`context_specs`.

## Trade-off
Más coordinación contractual que un monorepo, a cambio de límites claros y evolución
independiente. Los tres repositorios ya están creados y publicados; `context_specs`
mantiene la fuente SDD, no código ejecutable.
