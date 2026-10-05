# ADR-001 · Stack y repositorios
**Estado:** aceptado

## Decisión
Flutter/Dart para mobile, NestJS/TypeScript para API, PostgreSQL + Prisma para persistencia,
Firebase para push/telemetría y repositorios separados `binova-mobile`, `binova-api`,
`binova-specs`.

## Trade-off
Más coordinación contractual que un monorepo, a cambio de límites claros y evolución independiente.
