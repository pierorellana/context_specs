# Reglas de dependencias

- `domain` Flutter no importa `flutter`, Dio, Drift ni Provider.
- `presentation` no importa implementaciones concretas de datasource.
- Un feature no importa otro feature para reutilizar widgets o servicios; lo reutilizable sube a `core`.
- `ChangeNotifier` no ejecuta HTTP ni transforma DTOs.
- El API no permite que controllers accedan directamente a Prisma; pasan por application/domain service.
- Adapters externos viven detrás de interfaces.
- `local_auth` solo se consume desde `core/security`; features dependen de
  `BiometricAuthenticator`, nunca del plugin.
- Contratos compartidos se publican vía OpenAPI; no se comparten clases TS con Dart.
