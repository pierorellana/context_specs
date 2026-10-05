---
schema_version: 2
id: SPEC-011
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-007"]
requirements: ["RF-11", "RN-13"]
prototype_role: primary
---

# SPEC-011 · Financial Insights

## 1. Propósito y alcance
Resumen mensual y categorización informativa sobre movimientos demo.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
GET `/v1/insights/monthly`.
Backend agrega categorías y comparación mensual.
Flutter solo formatea y grafica.
No se generan recomendaciones de inversión/crédito.

## 4. Errores y estados
Sin suficientes movimientos -> empty insight. Error de insights no bloquea Productos.

## 5. Criterios de aceptación / Done
- Total de categorías coincide con total analizado.
- Gráfico accesible con resumen textual.
- Se distingue información de asesoría financiera.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
