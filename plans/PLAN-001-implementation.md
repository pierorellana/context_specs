# PLAN-001 · Implementación

## Fase 0 - foundation
Repos, CI, flavors, env, Prisma, OpenAPI, seed, design system.

## Fase 1 - acceso
Splash, onboarding, login, session coordinator, Face ID.

## Fase 2 - lectura bancaria
Dashboard, accounts, transactions, cache/offline.

## Fase 3 - operaciones
Transfer, pay, topup, operation status, idempotency, state animations.

## Fase 4 - tarjetas
Cards list, initial debit/credit/virtual stack, virtual card creation and stacking
motion, freeze/unfreeze, limits and Apple Wallet handoff.

## Fase 5 - servicios complementarios
Insights, FX con adapter/cache/fallback, notifications contract-first y profile.
La configuración real de Firebase/FCM se incorpora al cierre cuando estén disponibles
los archivos y credenciales por ambiente.

## Fase 6 - calidad
Observability, E2E, degraded scenarios, docs, demo script.
