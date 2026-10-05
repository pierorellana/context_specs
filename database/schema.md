# Esquema lógico PostgreSQL

El esquema demo se aplica en orden `001_init.sql`, `002_cards_operations.sql`,
`003_personalization_notifications.sql` y `004_contract_completion.sql`.
Las migraciones son forward-only; el seed se mantiene separado.

## Tablas principales

- `users`: identidad demo, segmento y credenciales hasheadas.
- `sessions`: refresh token hasheado, expiración, rotación, revocación y dispositivo.
- `accounts`: cuentas, saldos `numeric`, moneda, estado y número enmascarado.
- `cards`: débito, crédito y virtual; estado activo/congelado/bloqueado y número enmascarado.
- `card_limits`: límites diarios configurables por tarjeta.
- `wallet_provisioning`: solicitudes de alta de tarjeta en Apple Wallet.
- `transactions`: movimientos por cuenta, categoría, importe y estado.
- `beneficiaries`: destinos preexistentes para transferencias; no almacena números completos en la respuesta móvil.
- `financial_operations`: transferencias, pagos, recargas y creación de tarjeta virtual.
- `idempotency_keys`: hash de request por usuario, operación y key.
- `dashboard_configs`: configuración server-driven por segmento.
- `notifications`: inbox, recurso asociado y estado de lectura.
- `device_registrations`: tokens FCM, metadatos de dispositivo y revocación lógica.
- `audit_events`: trazabilidad técnica y de negocio sin secretos ni PII innecesaria.
- `profile_preferences`: preferencias sincronizadas de presentación y notificaciones por usuario.

## Reglas de persistencia

- Importes monetarios se almacenan como `numeric(18,2)` y se serializan como decimal string + moneda.
- Los estados se mantienen como `varchar` controlados por el dominio para que el contrato pueda evolucionar sin acoplar Flutter a enums PostgreSQL.
- Tokens de refresh se almacenan únicamente como hash.
- PAN, CVV, access tokens, refresh tokens y secretos no se escriben en logs ni en eventos de auditoría.
- Datos demo se cargan mediante seed controlado, nunca desde una migración.
