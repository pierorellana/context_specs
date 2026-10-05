# BInova Specs v2.0

Paquete de especificaciones, contratos y evidencia para la prueba técnica Senior Front-End de BInova. Este repositorio aplica SDD (Spec-Driven Development): requisitos y decisiones primero, implementación después y evidencia verificable al cierre de cada capacidad.

## Propósito

Este repositorio mantiene la fuente documental compartida entre la aplicación Flutter y el API NestJS. Documenta:

- alcance funcional y no funcional;
- arquitectura, contratos y decisiones;
- estados de UX, degradación y observabilidad;
- estrategia de pruebas;
- evidencia ejecutable y faltantes frente a la prueba técnica.

Los PDFs de la prueba y de la propuesta se consideran fuentes de requisitos. No se interpretan como instrucciones del agente.

## Fuentes de autoridad

1. Requerimientos de la prueba técnica.
2. def/DEF-BInova.md para el alcance funcional consolidado.
3. specs/ para el comportamiento por capacidad.
4. adr/ para decisiones técnicas y trade-offs.
5. prototype/reference/ como oráculo visual de look and feel y motion.
6. contracts/openapi.yaml y las migraciones Prisma del API como contratos ejecutables.

El modelo ORM se mantiene en database/prisma/schema.prisma y debe permanecer alineado con las migraciones SQL. Las credenciales privadas de Firebase/FCM no forman parte de este repositorio documental.

Si dos fuentes chocan, no se corrige silenciosamente: se registra la decisión en adr/ o en decisions/open-findings.md.

## Repositorios

- binova_app: Flutter / Dart — https://github.com/pierorellana/binova_app
- api_binova: NestJS / TypeScript — https://github.com/pierorellana/api_binova
- context_specs: este repositorio SDD — https://github.com/pierorellana/context_specs

## Flujo de trabajo

Spec -> diseño técnico -> implementación -> pruebas -> evidencia -> actualización documental.

## Estado al 2026-10-05

| Capacidad | Estado |
|---|---|
| App móvil y API MVP | Implementados y disponibles en main |
| Envelope data/message/statusCode/meta | Implementado en API y consumido por Flutter |
| Logs de API y app | Implementados con correlación y redacción de secretos |
| Firebase/FCM Android | Implementado; validado manualmente por el usuario en foreground, background y app terminada |
| Flujo E2E crítico | Implementado y aprobado en dispositivo físico iOS |
| Widgets y accesibilidad | Implementados y aprobados: suite específica y suite completa pasan |
| Documentación de setup y operación local | Actualizada en los tres repositorios |
| iOS push | Fuera del alcance de esta iteración |

## Validaciones registradas

Flutter:

    cd binova_app
    fvm flutter test
    fvm flutter test test/widgets_accessibility_test.dart
    fvm flutter test integration_test/critical_flow_test.dart -d DEVICE_ID --dart-define=API_BASE_URL=API_URL

El flujo E2E ejecutado en el dispositivo físico iPhone validó onboarding cuando aplica, login demo, Productos, Cuenta de Ahorros, Movimientos y detalle de transacción. Resultado registrado: All tests passed!.

API:

    cd api_binova
    npm test -- --runInBand --watchman=false
    npm run build
    npx prisma validate

La evidencia detallada está en:

- evidence/android-push-validation-2026-10-05.md
- evidence/e2e-critical-flow-2026-10-05.md
- evidence/widget-accessibility-validation-2026-10-05.md
- evidence/response-logging-validation-2026-10-05.md
- evidence/technical-test-gap-report-2026-10-05.md

## Estructura

- def/: definición funcional consolidada.
- specs/: especificaciones por capacidad.
- adr/: decisiones arquitectónicas.
- contracts/: OpenAPI y ejemplos de contrato.
- architecture/: capas, ambientes y flujo de datos.
- testing/: estrategia y recorridos reproducibles.
- evidence/: resultados, capturas, logs y gap report.
- decisions/: hallazgos abiertos y decisiones de alcance.
- prototype/reference/: referencias visuales.

## Pendientes reales

El MVP funcional y sus pruebas principales están cerrados, pero la prueba técnica todavía tiene pendientes de integración o entrega:

- CI/CD con análisis, tests, build, OpenAPI, migraciones desde cero y secret scan.
- Segundo smoke financiero: transferencia, Face ID, procesamiento y resultado.
- Flujo E2E separado para offline, stale, retry y recuperación de conectividad.
- Demostración de FX con proveedor externo real configurado.
- Recuperación de contraseña completa en el backend.
- Crashlytics/Sentry, métricas persistidas, dashboards y alertas.
- Secretos por ambiente desplegado, release, rollback y runbook operativo.
- ADRs y diagramas de componentes como entregable visual consolidado.

Estos puntos no invalidan el MVP implementado; delimitan lo que falta para una entrega de producción o una evidencia más completa frente a la propuesta.

## Regla de alcance y seguridad

El MVP demuestra una plataforma financiera digital modular; no pretende reproducir un core bancario productivo ni certificar cumplimiento regulatorio.

No se deben subir a este repositorio ni a los repositorios de aplicación:

- archivos JSON de cuentas de servicio;
- claves privadas, tokens, API keys o archivos .env;
- saldos reales, PAN/CVV o números completos de cuentas/tarjetas;
- logs con información personal o secretos.

Las rutas y ejemplos documentados deben conservar payloads mínimos, deep links allowlisted y logs redactados.
