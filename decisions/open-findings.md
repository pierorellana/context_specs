# Findings y decisiones de alcance

- F-001: proveedor FX definitivo. Estado: resuelto a nivel arquitectónico mediante `FxProvider`, configuración por ambiente, timeout, cache y fallback definidos en `ADR-016-fx-provider-and-cache.md`. El proveedor concreto y sus credenciales se cargan antes del smoke demo.
- F-002: duración exacta de access/refresh token para demo. Estado: parametrizable; valores base documentados en SPEC-003 y configurables por ambiente.
- F-003: push real. Estado: diferido a la fase final; se usará Firebase/FCM y el propietario entregará las credenciales y archivos de configuración por ambiente.
- F-004: alcance de tarjetas. Estado: resuelto; el MVP incluye stack de débito/crédito/virtual, creación de virtual, congelar/descongelar, consulta/actualización de límites y handoff a Apple Wallet. La creación de virtual sigue siendo el flujo prioritario.
- F-005: recuperación de contraseña. Estado: resuelto como experiencia visual del prototipo únicamente; no existe endpoint, persistencia ni regla backend para recuperación en el MVP.
- F-006: contrato OpenAPI y esquema SQL incompletos. Estado: resuelto en esta actualización con envelopes, errores, endpoints de lectura/escritura, migración de sesiones/beneficiarios y soporte de tarjetas/Wallet.
- F-007: compartir cuenta versus enmascaramiento. Estado: resuelto; la acción `Compartir datos` del prototipo conserva valores enmascarados en el MVP y no se añade un endpoint de revelación.
