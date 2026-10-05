---
schema_version: 2
id: SPEC-016
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-009", "ADR-010"]
requirements: ["RF-18", "RNF-12"]
prototype_role: primary
---

# SPEC-016 · Observabilidad y experiencia

## 1. Propósito y alcance

Define señales para detectar problemas técnicos y de UX sin bloquear operaciones financieras.

## 2. Reglas

La app registra eventos de login, navegación, operaciones, offline, uso de caché, reintentos y respuestas API con método, ruta, status, duración y traceId. Los logs móviles se sanitizan antes de enviarse a dart:developer.

El backend registra request latency, error rate, dependency latency, idempotency conflict y api_request estructurado. PII, saldos, tokens, credenciales, claves y números sensibles se excluyen.

Las respuestas API conservan un envelope con data, message, statusCode y meta. La correlación se propaga mediante X-Correlation-Id y traceId.

## 3. Errores y estados

Si la telemetría falla, nunca bloquea una operación bancaria. Los errores de red, timeout, 5xx y respuestas stale deben conservar un estado de UX accionable.

## 4. Criterios de aceptación / Done

- Correlation id permite enlazar una llamada mobile con backend.
- Logs no exponen secretos ni datos financieros.
- Existe una lista de métricas y alertas recomendadas.
- El API emite eventos estructurados por solicitud y dependencia.

## 5. Estado actual

La observabilidad estructurada del API está implementada con redacción de headers, bodies, saldos, tokens, credenciales y claves de idempotencia. La app registra respuestas sanitizadas y errores de red con traceId.

La evidencia de logs y contrato está en evidence/response-logging-validation-2026-10-05.md. Las pruebas automatizadas de API, envelope y build están registradas en evidence/technical-test-gap-report-2026-10-05.md.

Firebase Crashlytics/Sentry, métricas persistidas, dashboards y alertas operativas todavía no están configurados. Son pendientes de entrega/operación y no bloquean el MVP local.

## 6. Fuera de alcance

Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes

Ninguna para v2.0 salvo las registradas en decisions/open-findings.md.
