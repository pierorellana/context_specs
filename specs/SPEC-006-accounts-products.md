---
schema_version: 2
id: SPEC-006
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-002", "ADR-007"]
requirements: ["RF-06", "RN-01", "RN-06", "RN-11"]
prototype_role: primary
---

# SPEC-006 · Cuentas y productos

## 1. Propósito y alcance
Lista productos, detalle, saldos y datos enmascarados.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Cuenta y tarjeta muestran nombre, maskedNumber, balance/available, currency, status.
Datos cacheados muestran `lastUpdatedAt`.
Detalle permite navegar a movimientos y transferencias.
La acción visual de compartir datos comparte únicamente la representación enmascarada
en el MVP; no existe un endpoint para revelar o distribuir el número completo.

## 4. Errores y estados
Empty, loading, offline_stale, not found, partial unavailable.

## 5. Criterios de aceptación / Done
- Nunca se muestra número completo. Compartir/copy conserva el enmascaramiento.
- Detalle conserva contexto al volver.
- Offline usa último snapshot con timestamp.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
