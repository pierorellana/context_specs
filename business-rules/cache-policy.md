# Política de caché

- Accounts/transactions/dashboard pueden cachearse.
- Session secrets usan secure storage, no cache general.
- Cache entry: payload + fetchedAt + schemaVersion.
- `fresh`: < 60 s para demo.
- `stale`: se puede pintar con etiqueta/timestamp.
- Una operación financiera siempre consulta backend antes de confirmarse.
