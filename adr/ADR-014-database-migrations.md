# ADR-014 · Migraciones de base de datos
**Estado:** aceptado

Prisma Migrate versiona esquema PostgreSQL. Migraciones son forward-only en ambientes
compartidos; rollback operacional usa una migración compensatoria. CI valida schema y aplica
migraciones sobre una base efímera.
