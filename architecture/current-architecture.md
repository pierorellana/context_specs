# Arquitectura objetivo BInova

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
    beneficiaries/
    transfers/
    payments/
    cards/
    insights/
    exchange/
    notifications/
    profile/
    degraded_states/
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
    users/
    profile/
    dashboard/
    accounts/
    transactions/
    beneficiaries/
    transfers/
    payments/
    cards/
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
  infrastructure/
    database/
    external-services/
    cache/
```

NestJS expone REST versionado `/v1`. PostgreSQL + Prisma es la persistencia del MVP.

## Flujo

Flutter Page -> Provider/ViewModel -> Use Case -> Repository contract
-> Repository implementation -> Remote/Local datasource
-> NestJS Controller -> Application Service -> Repository/Adapter -> PostgreSQL/Third party
