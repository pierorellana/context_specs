---
schema_version: 2
id: SPEC-003
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-005", "ADR-010"]
requirements: ["RF-03", "RF-04", "RF-15", "RN-03", "RN-04"]
prototype_role: primary
---

# SPEC-003 · Autenticación y sesiones

## 1. Propósito y alcance
Login, refresh, sign-out y ciclo de sesión.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Login demo por usuario/clave. Access token 15 min; refresh token 7 días configurable.
Refresh rotatorio. Sign-out invalida refresh. Flutter guarda refresh/access de forma segura.
Face ID solo desbloquea el uso local de una sesión todavía válida.
El prototipo puede mostrar la hoja visual de recuperación de contraseña, pero el MVP
no expone endpoint ni persiste un flujo de recuperación.

## 4. Errores y estados
Credenciales inválidas, sesión expirada, refresh revocado, sin red, rate limit.

## 5. Criterios de aceptación / Done
- Login 2xx crea sesión.
- 401 tras refresh fallido limpia sesión.
- Sign-out limpia local incluso si la revocación remota no responde.
- Ningún token aparece en logs.

## 6. Fuera de alcance
Recuperación de contraseña a nivel API, persistencia de solicitudes de recuperación,
envío de correo/SMS y reglas de bloqueo derivadas de ese flujo.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
