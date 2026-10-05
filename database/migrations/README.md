# Estrategia de migraciones

1. Prisma es la herramienta operativa prevista; `database/prisma/schema.prisma` es el modelo ORM y estos SQL documentan la intención ejecutable del esquema.
2. Cada cambio de schema genera una migración nueva; no se edita una migración ya aplicada.
3. CI crea PostgreSQL efímero y ejecuta todas las migraciones desde cero.
4. En ambientes compartidos se usa forward-only; rollback = migración compensatoria.
5. Seed demo va separado de migración.

## Orden vigente

- `001_init.sql`: usuarios, cuentas y movimientos.
- `002_cards_operations.sql`: tarjetas, operaciones financieras e idempotencia.
- `003_personalization_notifications.sql`: dashboard, inbox, dispositivos y auditoría.
- `004_contract_completion.sql`: sesiones, beneficiarios, límites de tarjetas, provisión a Wallet y campos de trazabilidad de operaciones.
- `005_profile_preferences.sql`: preferencias sincronizadas de perfil definidas por SPEC-014.

La recuperación de contraseña del prototipo es únicamente visual y no forma parte
del esquema ni del contrato API del MVP.
