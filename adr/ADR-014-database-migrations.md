# ADR-014 · Migraciones de base de datos
**Estado:** aceptado

Prisma Migrate versiona esquema PostgreSQL. Migraciones son forward-only en ambientes
compartidos; rollback operacional usa una migración compensatoria. CI valida schema y aplica
migraciones sobre una base efímera.

El API contiene actualmente `0001_init`, `0002_dashboard_profile_notifications`,
`0003_operations` y `0004_cards`. Los archivos SQL numerados en
`database/migrations/` son snapshots/documentación del contrato; la fuente ejecutable
es `binova_api/prisma/migrations/`.
