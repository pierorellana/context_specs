# BInova Specs v2.0

Paquete de especificaciones para la prueba técnica Senior Front-End (Flutter) de BInova.

## Propósito

Este repositorio documental aplica un enfoque **SDD - Spec-Driven Development**: primero se
declaran comportamiento, contratos, estados, límites, criterios de aceptación y decisiones;
después se implementan Flutter y NestJS y se conserva evidencia verificable.

## Fuentes de autoridad

1. Requerimientos de la prueba técnica.
2. `context/def/DEF-BInova.md` para el alcance funcional consolidado.
3. `context/specs/` para el comportamiento por capacidad.
4. `context/adr/` para decisiones técnicas y trade-offs.
5. Prototipo BInova iOS como oráculo visual de look & feel y motion.
6. OpenAPI y migraciones como contratos ejecutables.

El modelo ORM se mantiene en `database/prisma/schema.prisma` y debe permanecer alineado
con las migraciones SQL. Firebase/FCM se configura por ambiente en la fase de integración
push; sus credenciales no forman parte de este paquete documental.

Si dos fuentes chocan, no se corrige silenciosamente: se registra la decisión en ADR o en
`context/decisions/open-findings.md`.

## Flujo de trabajo

Spec -> diseño técnico -> implementación -> pruebas -> evidencia -> actualización documental.

## Repositorios previstos

- `binova-mobile`: Flutter / Dart.
- `binova-api`: NestJS / TypeScript.
- `binova-specs`: este contexto SDD.

## Regla de alcance

El MVP demuestra una plataforma financiera digital modular; no pretende reproducir un core
bancario productivo ni certificar cumplimiento regulatorio.
