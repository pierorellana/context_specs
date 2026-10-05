# Requerimientos compartidos

## Error codes base
`AUTH_INVALID_CREDENTIALS`, `SESSION_EXPIRED`, `REFRESH_REVOKED`,
`ACCOUNT_NOT_FOUND`, `TRANSACTION_NOT_FOUND`, `BENEFICIARY_NOT_FOUND`,
`OPERATION_NOT_FOUND`, `OPERATION_PENDING`, `OPERATION_REJECTED`,
`INSUFFICIENT_FUNDS`, `IDEMPOTENCY_CONFLICT`, `FX_UNAVAILABLE`,
`DEBT_NOT_FOUND`, `PROVIDER_UNAVAILABLE`, `CARD_NOT_ELIGIBLE`,
`CARD_ALREADY_FROZEN`, `CARD_ALREADY_ACTIVE`, `RATE_LIMITED`,
`VALIDATION_ERROR`, `NOT_FOUND`, `SERVICE_UNAVAILABLE`.

## Estados de UI estándar
`initial`, `loading`, `refreshing`, `loaded`, `empty`, `offline_stale`, `partial_unavailable`,
`submitting`, `pending`, `success`, `error`.

## Reglas de dinero
- Currency ISO-4217.
- Backend: Prisma Decimal.
- Transporte: string decimal, p.ej. `"150.00"`.
- Flutter: Value Object Money; nunca lógica con `double`.
