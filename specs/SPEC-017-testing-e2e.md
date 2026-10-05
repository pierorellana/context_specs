---
schema_version: 2
id: SPEC-017
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-011"]
requirements: ["RNF-08"]
prototype_role: primary
---

# SPEC-017 · Pruebas y evidencia

## 1. Propósito y alcance

Define cobertura mínima verificable para la prueba técnica y separa lo implementado de la automatización que aún falta para una entrega operativa.

## 2. Reglas

- Unit tests: use cases, mappers, cache policy y providers.
- Widget tests: login, tarjeta de cuenta, estados de transacciones, estados degradados y accesibilidad.
- Backend: services, controllers, repositories y pruebas de contrato.
- Contract: OpenAPI.
- E2E crítico: Login -> Home -> Cuenta -> Movimientos -> Detalle.
- Smoke financiero: Transfer -> Face ID -> Processing -> Result.
- Recuperación de conectividad: offline -> stale -> retry -> refresh.

## 3. Errores y estados

Una dependencia externa en CI puede usar adapter fake; la demo conserva integración real en ambiente demo. Las pruebas deben dejar evidencia de comando, dispositivo o ambiente, fecha y resultado.

## 4. Criterios de aceptación / Done

- Suite rápida ejecutable localmente.
- E2E crítico con instrucciones reproducibles.
- Evidencia de accesibilidad y objetivos táctiles.
- Contrato y migraciones verificables en CI cuando exista workflow.

## 5. Estado actual

La suite Flutter completa pasa con 16 pruebas. La prueba específica de widgets y accesibilidad pasa con 2 pruebas e incluye semántica, etiquetas y objetivos táctiles Android/iOS.

El integration_test del flujo crítico está implementado y fue aprobado en un iPhone físico: onboarding cuando aplica, login demo, Productos, Cuenta de Ahorros, Movimientos y detalle de transacción. La evidencia está en evidence/e2e-critical-flow-2026-10-05.md.

La suite API y el build de NestJS están aprobados según la evidencia actual. Aún faltan un workflow CI ejecutable, contract testing OpenAPI automatizado, PostgreSQL efímero en CI, el segundo smoke financiero y un E2E separado para recuperación de conectividad.

## 6. Fuera de alcance

Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes

Ninguna para v2.0 salvo las registradas en decisions/open-findings.md.
