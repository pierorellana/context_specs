---
schema_version: 2
id: SPEC-013
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-008"]
requirements: ["RF-13", "RF-14", "RN-14"]
prototype_role: primary
---

# SPEC-013 · Notificaciones y deep links

## 1. Propósito y alcance
Registro FCM, inbox básico, lectura y navegación a recurso.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
POST `/v1/devices` registra token; GET `/v1/devices` lista dispositivos y
DELETE `/v1/devices/:id` revoca uno. GET `/v1/notifications` obtiene el inbox;
POST `/v1/notifications/:id/read` y POST `/v1/notifications/read-all` sincronizan
la lectura de forma idempotente.
Payload push: type, notificationId, resourceType, resourceId.
Router valida destino permitido.

El proveedor de push es Firebase Cloud Messaging. La configuración de credenciales y
archivos nativos se incorpora en la fase final; el contrato API y fixtures no dependen
de que Firebase esté configurado localmente.

## 4. Errores y estados
Token inválido se renueva. Deep link desconocido abre Home + aviso no bloqueante.

## 5. Criterios de aceptación / Done
- Push no contiene datos financieros sensibles.
- Tocar una notificación abre el contexto correcto.
- Lectura se sincroniza idempotentemente.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
