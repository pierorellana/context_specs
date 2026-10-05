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
Define cobertura mínima verificable para la prueba técnica.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Unit tests: use cases, mappers, cache policy, providers.
Widget tests: login, account card, transactions states, degraded states.
Backend: services/controllers/repositories + DB ephemeral.
Contract: OpenAPI.
E2E crítico: Login -> Home -> Cuenta -> Movimientos -> Detalle.
Smoke financiero: Transfer -> Face ID -> Processing -> Result.

## 4. Errores y estados
Una dependencia externa en CI puede usar adapter fake; la demo conserva integración real en ambiente demo.

## 5. Criterios de aceptación / Done
- CI ejecuta toda la suite rápida.
- E2E tiene instrucciones reproducibles.
- Evidencia incluye comandos, resultado y fecha.

## 6. Estado actual

Hay 8 tests Flutter aprobados y 8 tests API aprobados; el API también compila. La
validación visual se ejecutó en el emulador Android y está almacenada en
`evidence/ui-validation/`. Aún faltan `integration_test/`, contract testing OpenAPI,
PostgreSQL efímero en CI y automatización de los dos recorridos críticos.

## 7. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 8. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
