# Findings y decisiones de alcance

- **F-001 — proveedor FX:** resuelto a nivel de arquitectura y código mediante
  `FxProvider`, adapter HTTP configurable, adapter demo determinista, timeout, caché
  fresh/stale y `FX_UNAVAILABLE`. La integración con un proveedor externo real sigue
  pendiente si la demo exige credenciales externas.
- **F-002 — duración de tokens:** resuelto; access/refresh TTL son configurables por
  ambiente y el seed/demo usa los valores documentados en SPEC-003.
- **F-003 — push real:** abierto por dependencia externa. El API y el inbox están
  preparados, pero faltan Firebase/FCM, archivos nativos, recepción push y deep link.
- **F-004 — tarjetas:** resuelto. El MVP incluye stack débito/crédito/virtual,
  creación virtual prioritaria, congelar/descongelar, límites y Wallet.
- **F-005 — recuperación de contraseña:** resuelto como experiencia visual del
  prototipo únicamente; no hay endpoint, persistencia ni regla backend.
- **F-006 — contrato y migraciones:** resuelto en implementación. OpenAPI cubre los
  endpoints MVP y Prisma mantiene cuatro migraciones ejecutables (`0001_init` a
  `0004_cards`); los SQL de `database/migrations/` son documentación de intención y
  trazabilidad, no sustituyen las migraciones del API.
- **F-007 — compartir cuenta:** resuelto; conserva datos enmascarados y no añade
  endpoint de revelación.
- **F-008 — CI y E2E:** abierto para el cierre de entrega. Faltan workflows de CI y
  automatización de los dos recorridos críticos definidos en SPEC-017.
