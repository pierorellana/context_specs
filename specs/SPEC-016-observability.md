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
Define señales para detectar problemas técnicos y de UX.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Mobile events: login_success/failure, screen_view, operation_started/result, offline_view_shown,
cache_fallback_used, retry_triggered, api_response/api_error con método, ruta, status, duración y traceId.
Backend: request latency, error rate, dependency latency, idempotency conflict y api_request estructurado.
PII/saldos/tokens se excluyen.

## 4. Errores y estados
Si telemetría falla, nunca bloquea una operación bancaria.

## 5. Criterios de aceptación / Done
- Crash de demo aparece en entorno no productivo.
- Correlation id permite enlazar una llamada mobile con backend.
- Hay una lista de métricas y alertas recomendadas.

## 6. Estado actual

La observabilidad estructurada del API está implementada y redacta headers, bodies,
saldos, tokens y credenciales. La app registra respuestas sanitizadas con `dart:developer`.
La telemetría Firebase/Sentry y dashboards no están configurados todavía.

## 7. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 8. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
