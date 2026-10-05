---
schema_version: 2
id: SPEC-018
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-013"]
requirements: ["RNF-13"]
prototype_role: primary
---

# SPEC-018 · Uso de IA y automatización

## 1. Propósito y alcance
Documenta el uso de IA solicitado por la prueba.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Registrar: tarea, herramienta, prompt/resumen, archivos afectados, validación humana, beneficio y riesgo.
IA puede generar scaffolding/tests/docs; el desarrollador debe poder explicar el resultado.
No ingresar secretos ni PII en prompts.

## 4. Errores y estados
Salida de IA no validada no se considera evidencia.

## 5. Criterios de aceptación / Done
- `evidence/ai-usage-log.md` contiene registros reales.
- Se describen impacto en productividad, calidad, documentación y pruebas.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
