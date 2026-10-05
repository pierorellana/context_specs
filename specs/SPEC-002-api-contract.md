---
schema_version: 2
id: SPEC-002
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-004", "ADR-010"]
requirements: ["RF-03", "RF-05", "RF-06", "RF-07", "RF-08", "RF-09", "RF-10", "RF-11", "RF-12", "RF-13", "RF-14", "RF-19"]
prototype_role: primary
---

# SPEC-002 · Contrato REST BInova

## 1. Propósito y alcance
Define endpoints, envelope, paginación, errores, correlación e idempotencia.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Base `/v1`. Access token Bearer.
Lecturas paginadas usan `cursor`.
Escrituras financieras exigen `Idempotency-Key`.
Éxito: `{data, meta}`. Error: `{error:{code,message,details}, traceId}`.
Las solicitudes propagan `X-Correlation-Id`; el API genera uno cuando no llega.
El refresh recibe el refresh token en el body y rota el token anterior.
OpenAPI es la fuente ejecutable de campos, estados, parámetros y códigos para mobile.

El contrato cubre también las consultas y acciones necesarias para el MVP: deuda de
servicio (`/payments/debt`), beneficiarios, lectura de notificaciones, preferencias,
listado/revocación de dispositivos, creación y gestión de tarjetas, límites y
provisión a Apple Wallet.

## 4. Errores y estados
401 renueva sesión una vez; 409 idempotency conflict; 429 rate limit; 503 dependencia no disponible.

## 5. Criterios de aceptación / Done
- OpenAPI es el contrato publicado en `contracts/openapi.yaml`; la validación automática
  en CI queda pendiente de incorporar al workflow.
- Mobile puede implementar todos los repositorios sin inferir campos.
- Errores se resuelven por `code`.
- Todas las respuestas exitosas del contrato tienen `data` y `meta`, incluidos los
  cambios de preferencias, lectura de notificaciones y acciones de dispositivos.

## 6. Estado actual

El API implementa salud, autenticación/refresh, dashboard, cuentas, movimientos,
operaciones, tarjetas, insights, FX, notificaciones, dispositivos y perfil. El contrato
está versionado y la validación runtime se cubre con tests de servicio; falta añadir
lint/contract testing OpenAPI al CI.

## 7. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 8. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
