---
schema_version: 2
id: SPEC-014
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-003", "ADR-015"]
requirements: ["RF-15", "RN-03", "RN-04"]
prototype_role: primary
---

# SPEC-014 · Perfil, seguridad y preferencias

## 1. Propósito y alcance
Perfil, biometría, dispositivos, notificaciones, preferencias y cierre de sesión.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Settings iOS-like. Face ID toggle requiere capacidad local.
Preferencias sincronizadas usan `GET/PATCH /v1/profile/preferences`.
Lista de dispositivos demo proviene de `GET /v1/devices`; el registro usa
`POST /v1/devices` y el revoke usa `DELETE /v1/devices/:id`.
Cerrar sesión solicita confirmación y limpia estado seguro.

## 4. Errores y estados
Sin biometría -> control deshabilitado con explicación. Error remoto no impide limpieza local al cerrar sesión.

## 5. Criterios de aceptación / Done
- No se muestran secretos.
- Preferencias no afectan seguridad obligatoria.
- Device revoke actualiza UI tras confirmación backend.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `decisions/open-findings.md`.
