# PLAN-001 · Implementación y cierre de entrega

## Estado general

Las fases funcionales del MVP están implementadas en `binova_app` y `binova_api`.
El trabajo restante es de integración externa, calidad automatizada y empaquetado de
entrega. `main` permanece como trunk y los cambios publicados se organizan en commits
convencionales pequeños.

## Fases completadas

- **Fase 0 — foundation:** repositorios separados, Flutter/NestJS/Prisma, contrato
  OpenAPI, seed demo, configuración local, design system y assets del prototipo.
- **Fase 1 — acceso:** splash, onboarding, login, sesiones, almacenamiento seguro y
  biometría local.
- **Fase 2 — lectura bancaria:** Home server-driven acotado, cuentas, productos,
  movimientos, caché y estados degradados.
- **Fase 3 — operaciones:** transferencias, pagos, recargas, idempotencia, estados y
  animaciones de operación.
- **Fase 4 — tarjetas:** stack de débito/crédito/virtual, creación virtual,
  congelar/descongelar, límites y handoff a Wallet.
- **Fase 5 — servicios complementarios:** insights, FX con adapter demo/cache,
  notificaciones contract-first, perfil y preferencias.

## Fase parcialmente completada — calidad y release

- Observabilidad backend estructurada: implementada.
- Developer Tools para normal/slow/offline/server error/timeout: implementado en debug
  y demo.
- Tests unitarios/widget y backend: implementados; 8 Flutter y 8 API aprobados.
- Evidencia visual en emulador Android: disponible.
- E2E automatizado y smoke financiero: instrucciones y flujo manual definidos, falta
  automatización reproducible.
- CI con análisis, tests, contrato, migraciones y secret scan: pendiente.
- Build release/demo: pendiente de generar como artefacto final.
- Firebase/FCM y deep links reales: pendiente de credenciales y archivos nativos.

## Próximo orden

1. Incorporar los archivos de Firebase/FCM y validar registro, push y deep link.
2. Automatizar el E2E crítico y el smoke financiero en el emulador.
3. Crear workflows de CI para App, API y validaciones documentales.
4. Ejecutar migraciones desde PostgreSQL limpio, validar OpenAPI y hacer secret scan.
5. Generar build demo/release, checklist y paquete final de entrega.
