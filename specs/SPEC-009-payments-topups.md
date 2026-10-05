---
schema_version: 2
id: SPEC-009
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-008"]
requirements: ["RF-09", "RN-02", "RN-08", "RN-09"]
prototype_role: primary
---

# SPEC-009 · Pagos y recargas

## 1. Propósito y alcance
Reutiliza el patrón de operación financiera para pagos de servicio y recargas.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Pago consulta deuda antes de confirmar. Recarga selecciona línea/monto.
Ambas operaciones usan idempotency key y estados processing/pending/succeeded/failed.
Los copies cambian por operación, no el contrato de estado.
La consulta de pago usa `GET /v1/payments/debt` y la confirmación usa
`POST /v1/payments`; la recarga usa `POST /v1/topups`.

## 4. Errores y estados
Proveedor pendiente/no disponible, deuda no encontrada, monto inválido, timeout.

## 5. Criterios de aceptación / Done
- La UX mantiene una acción financiera por contexto.
- No se confirma pago/recarga por animación local.
- Pending y retry son claros.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
