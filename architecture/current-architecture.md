# Arquitectura actual BInova

## Mobile

Flutter organizado por `core/` y `features/`.

```text
lib/
  app/
    bootstrap/
    routing/
    theme/
  core/
    config/
    network/
    errors/
    security/
    storage/
    observability/
    design_system/
    accessibility/
  features/
    auth/
    onboarding/
    dashboard/
    accounts/
    transactions/
    cards/
    home/
    operations/
    insights/
    exchange/
    notifications/
    profile/
    developer_tools/
```

Cada feature mantiene `data/`, `domain/` y `presentation/`.

Dependencias permitidas:

`presentation -> domain <- data`

`presentation` usa Provider/ViewModel; `domain` no depende de Flutter; `data` implementa
repositorios y mapea DTO/cache hacia entidades.

## API

```text
src/
  modules/
    auth/
    profile/
    dashboard/
    accounts/
    transactions/
    cards/
    operations/
    insights/
    exchange/
    notifications/
    devices/
  common/
    auth/
    filters/
    interceptors/
    errors/
    observability/
  prisma/
  config/
```

NestJS expone REST versionado `/v1`. PostgreSQL + Prisma es la persistencia del MVP.

## Flujo

Flutter Page -> Provider/ViewModel -> Use Case -> Repository contract
-> Repository implementation -> Remote/Local datasource
-> NestJS Controller -> Application Service -> Repository/Adapter -> PostgreSQL/Third party
