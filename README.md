# BInova Specs v2.0

Paquete de especificaciones para la prueba técnica Senior Front-End (Flutter) de BInova.

## Propósito

Este repositorio documental aplica un enfoque **SDD - Spec-Driven Development**: primero se
declaran comportamiento, contratos, estados, límites, criterios de aceptación y decisiones;
después se implementan Flutter y NestJS y se conserva evidencia verificable.

## Fuentes de autoridad

1. Requerimientos de la prueba técnica.
2. `def/DEF-BInova.md` para el alcance funcional consolidado.
3. `specs/` para el comportamiento por capacidad.
4. `adr/` para decisiones técnicas y trade-offs.
5. `prototype/reference/` como oráculo visual de look & feel y motion.
6. `contracts/openapi.yaml` y las migraciones Prisma del API como contratos ejecutables.

El modelo ORM se mantiene en `database/prisma/schema.prisma` y debe permanecer alineado
con las migraciones SQL. Firebase/FCM se configura por ambiente en la fase de integración
push; sus credenciales no forman parte de este paquete documental.

Si dos fuentes chocan, no se corrige silenciosamente: se registra la decisión en ADR o en
`decisions/open-findings.md`.

## Flujo de trabajo

Spec -> diseño técnico -> implementación -> pruebas -> evidencia -> actualización documental.

## Repositorios actuales

- `binova_app`: Flutter / Dart — [repositorio](https://github.com/pierorellana/binova_app).
- `binova_api`: NestJS / TypeScript — [repositorio](https://github.com/pierorellana/api_binova).
- `context`: este contexto SDD — [repositorio](https://github.com/pierorellana/context_specs).

## Estado de implementación

- MVP funcional de App y API disponible en `main`.
- API con seed demo, PostgreSQL/Prisma, contrato `/v1`, tarjetas virtuales,
  operaciones, insights, FX demo, notificaciones y preferencias.
- App con Clean Architecture + Provider, UI alineada al prototipo, caché,
  estados degradados, biometría local y Developer Tools.
- Tests actuales: 8 Flutter y 8 API aprobados; build NestJS aprobado.
- Evidencia visual local disponible en `evidence/ui-validation/`.

## Pendientes de entrega

- Configuración real de Firebase/FCM y validación del deep link push.
- E2E automatizado crítico y smoke financiero reproducible.
- CI para análisis, tests, contrato OpenAPI, migraciones y secret scan.
- Build release/demo y checklist final de entrega.

Estos pendientes no cambian el alcance funcional del MVP; representan el cierre de
integración, calidad y entrega.

## Regla de alcance

El MVP demuestra una plataforma financiera digital modular; no pretende reproducir un core
bancario productivo ni certificar cumplimiento regulatorio.
