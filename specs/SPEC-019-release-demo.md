---
schema_version: 2
id: SPEC-019
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-012", "ADR-015"]
requirements: ["RF-17", "RNF-11"]
prototype_role: primary
---

# SPEC-019 · Release, demo y Developer Tools

## 1. Propósito y alcance
Define una demo reproducible y mecanismos de escenarios degradados.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Developer Tools solo en debug/demo y protegido por compile-time flag.
Modos: normal, slow, offline, server error, timeout.
No existe en release de producción.
Demo seed contiene usuarios/cuentas/movimientos controlados.

## 4. Errores y estados
Si el panel está deshabilitado, la app opera contra condiciones reales.

## 5. Criterios de aceptación / Done
- El evaluador puede demostrar offline/latencia/error sin manipular red física.
- Build productivo no expone controles demo.
- README documenta credenciales demo y pasos.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
