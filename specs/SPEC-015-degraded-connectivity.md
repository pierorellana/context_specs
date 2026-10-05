---
schema_version: 2
id: SPEC-015
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-007"]
requirements: ["RF-16", "RF-20", "RN-06", "RN-07", "RN-08", "RN-09"]
prototype_role: primary
---

# SPEC-015 · Conectividad degradada y estados

## 1. Propósito y alcance
Define comportamiento ante offline, alta latencia, timeout y fallas parciales.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Lectura: cache -> render stale -> revalidate.
Alta latencia: skeleton + timeout visible.
Offline: última información + timestamp.
Falla parcial: módulo afectado aislado.
Escritura ambigua: pending + status lookup, nunca retry ciego.
La pantalla `Estado-Carga` del prototipo se implementa como estado transitorio/skeleton
dentro del flujo que está cargando; no es un destino navegable independiente.

## 4. Errores y estados
Estados estándar definidos en shared-requirements.

## 5. Criterios de aceptación / Done
- Cada feature importante tiene loading/error/offline.
- Reconexión refresca sin perder contexto seguro.
- Panel demo puede simular slow/offline/500/timeout solo fuera de producción.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
