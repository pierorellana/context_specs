---
schema_version: 2
id: SPEC-008
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-003", "SPEC-006", "ADR-004"]
requirements: ["RF-08", "RN-02", "RN-08", "RN-09", "RN-10"]
prototype_role: primary
---

# SPEC-008 · Transferencias

## 1. Propósito y alcance
Transferencia demo end-to-end con beneficiario, monto, confirmación, Face ID y estado.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Pasos: target -> amount -> review -> step-up -> POST operation -> processing -> result.
POST `/v1/transfers` exige Idempotency-Key.
Timeout tras enviar consulta `/v1/operations/:id` o muestra pending; nunca asume fallo.
El backend valida saldo demo y límites configurados.

## 4. Errores y estados
Validation, insufficient funds, pending, rejected, timeout, network lost, duplicate idempotency key.

## 5. Criterios de aceptación / Done
- Success solo con estado backend succeeded.
- Pending explica que no se duplique la operación.
- Reintentar escritura reutiliza la misma idempotency key cuando corresponda.
- E2E de este flujo puede usarse como segundo smoke.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
