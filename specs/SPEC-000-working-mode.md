---
schema_version: 2
id: SPEC-000
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-013", "ADR-012"]
requirements: ["RNF-11", "RNF-13", "RNF-15"]
prototype_role: primary
---

# SPEC-000 · Modo de trabajo SDD

## 1. Propósito y alcance
Define cómo se convierten requerimientos y prototipo en cambios implementables y verificables.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
1. La SPEC afectada se actualiza antes del código.
2. La implementación no puede inventar comportamiento ausente.
3. Look proviene del prototipo; reglas provienen de DEF/SPEC.
4. Cada cierre conserva evidencia de pruebas y decisiones.

## 4. Errores y estados
Un conflicto entre prototipo y SPEC bloquea implementación hasta registrar resolución.

## 5. Criterios de aceptación / Done
- Existe trazabilidad DEF -> SPEC -> prueba.
- Todo PR referencia una SPEC.
- No quedan cambios funcionales sin documentación.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
