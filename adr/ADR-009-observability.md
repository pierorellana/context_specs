# ADR-009 · Observabilidad
**Estado:** aceptado

Crash reporting + analytics + performance quedan definidos por ambiente; el API ya
emite logs estructurados `api_request` y `dependency_call` con redacción de PII y
secretos. Correlation id conecta mobile/API/adapters.

Estado actual: observabilidad backend implementada; Firebase Crashlytics/Analytics/
Performance y dashboards de ambiente aún requieren configuración externa.
