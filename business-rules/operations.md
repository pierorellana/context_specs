# Lógica de negocio - operaciones

## Máquina de estados
`created -> processing -> succeeded`
`created -> processing -> pending -> succeeded|failed`
`created -> processing -> failed`

Nunca: `pending -> processing` por inferencia de cliente.

## Idempotencia
- Cliente genera una key por intención de usuario.
- Backend guarda hash del request.
- Misma key + mismo hash devuelve la operación existente.
- Misma key + hash diferente => `IDEMPOTENCY_CONFLICT`.

## Timeout
Si el cliente pierde la respuesta después del submit:
1. conserva operationId si lo recibió;
2. consulta status;
3. si no conoce operationId, reintenta con la misma idempotency key;
4. nunca crea una segunda intención automáticamente.
