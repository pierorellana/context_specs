---
schema_version: 2
id: SPEC-004
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-005", "ADR-015"]
requirements: ["RF-01", "RF-02", "RF-04", "RNF-09", "RNF-10"]
prototype_role: primary
---

# SPEC-004 · Splash, onboarding y Face ID

## 1. Propósito y alcance
Resuelve el arranque iOS-first y el reingreso biométrico.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Primera vez -> Onboarding -> Login.
Sin sesión -> Login.
Sesión válida -> Face ID -> Home.
Face ID estados: idle, scanning, success, error; success transiciona a Home.

## 4. Errores y estados
Biometría no disponible, cancelada o fallida ofrece reintentar o usar login.

## 5. Criterios de aceptación / Done
- Splash no supera ~2.5 s salvo bootstrap real.
- Reduce Motion usa fade.
- Ruta de arranque es determinista.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
