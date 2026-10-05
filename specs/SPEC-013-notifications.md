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

Registro FCM, inbox básico, lectura y navegación a recurso para Android.

## 2. UI y referencia de prototipo

El look and feel se deriva del prototipo BInova iOS. La implementación Flutter conserva jerarquía, copy, motion y estados relevantes sin trasladar CSS o HTML literalmente.

## 3. Reglas

POST /v1/devices registra token; GET /v1/devices lista dispositivos y DELETE /v1/devices/:id revoca uno. GET /v1/notifications obtiene el inbox; POST /v1/notifications/:id/read y POST /v1/notifications/read-all sincronizan la lectura de forma idempotente.

El payload push solo contiene type, notificationId, resourceType y resourceId. El router valida que el destino esté permitido.

El proveedor es Firebase Cloud Messaging. POST /v1/notifications/test es una ruta protegida de desarrollo, habilitada únicamente con PUSH_TEST_ENDPOINT_ENABLED=true.

La app muestra mensajes en primer plano mediante notificación local. En segundo plano y terminada, Android usa la bandeja FCM y resuelve taps mediante onMessageOpenedApp o getInitialMessage.

## 4. Errores y estados

Un token inválido se renueva o revoca sin bloquear la operación. Un deep link desconocido abre Home con un aviso no bloqueante. Si FCM falla después del commit, la notificación del inbox permanece disponible.

## 5. Criterios de aceptación / Done

- Push sin datos financieros sensibles.
- Tap de notificación abre el contexto correcto.
- Lectura sincronizada de forma idempotente.
- Fallas del proveedor no revierten operaciones financieras.
- Foreground, background y app terminada cubiertos en Android.

## 6. Estado actual

El API expone registro y revocación de dispositivos, inbox y envío mediante Firebase Admin. La app integra Firebase Core/Messaging, registra y renueva tokens Android, muestra notificación local en foreground y usa la bandeja FCM en background/terminated.

La validación manual Android fue reportada y confirmada por el usuario como funcional en foreground, background y app terminada. La evidencia visual de la bandeja de notificaciones está en evidence/android-push-validation-2026-10-05.md.

La configuración de secretos por ambiente desplegado, Crashlytics/Sentry y push iOS siguen fuera de esta iteración.

## 7. Fuera de alcance

Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 8. Decisiones pendientes

Ninguna para v2.0 salvo las registradas en decisions/open-findings.md.
