# Estrategia de migraciones

1. Prisma es la herramienta operativa; `database/prisma/schema.prisma` documenta el
   modelo y `binova_api/prisma/migrations/` contiene las migraciones ejecutables.
   Los SQL de esta carpeta son snapshots de contrato y trazabilidad del esquema.
2. Cada cambio de schema genera una migración nueva; no se edita una migración ya aplicada.
3. CI debe crear PostgreSQL efímero y ejecutar todas las migraciones del API desde cero;
   este workflow aún está pendiente.
4. En ambientes compartidos se usa forward-only; rollback = migración compensatoria.
5. Seed demo va separado de migración.

## Orden documental

- `001_init.sql`: usuarios, cuentas y movimientos.
- `002_cards_operations.sql`: tarjetas, operaciones financieras e idempotencia.
- `003_personalization_notifications.sql`: dashboard, inbox, dispositivos y auditoría.
- `004_contract_completion.sql`: sesiones, beneficiarios, límites de tarjetas, provisión a Wallet y campos de trazabilidad de operaciones.
- `005_profile_preferences.sql`: preferencias sincronizadas de perfil definidas por SPEC-014.

## Orden ejecutable actual del API

- `0001_init`
- `0002_dashboard_profile_notifications`
- `0003_operations`
- `0004_cards`

La migración ejecutable y el esquema Prisma son la fuente de verdad operativa. Si se
añade una entidad o endpoint que cambie persistencia, se actualizan ambos y se agrega
una nueva migración Prisma forward-only.

La recuperación de contraseña del prototipo es únicamente visual y no forma parte
del esquema ni del contrato API del MVP.
