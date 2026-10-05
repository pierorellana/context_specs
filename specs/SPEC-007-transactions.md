---
schema_version: 2
id: SPEC-007
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-006", "SPEC-002"]
requirements: ["RF-07", "RN-01", "RN-06"]
prototype_role: primary
---

# SPEC-007 · Movimientos

## 1. Propósito y alcance
Listado paginado, filtro básico y detalle de transacción.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
GET `/accounts/:id/transactions?cursor=`.
Filtro por periodo/categoría es query del backend.
Detalle contiene merchant/description, amount, date, category, status, reference.
Ingresos y egresos se diferencian sin depender solo de color.

## 4. Errores y estados
Empty, offline_stale, load more error, transaction not found.

## 5. Criterios de aceptación / Done
- Paginación no duplica elementos.
- Detalle abre desde Home o cuenta y vuelve al origen lógico.
- Widget tests cubren estados principales.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
