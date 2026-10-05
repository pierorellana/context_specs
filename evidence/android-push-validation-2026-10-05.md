# Evidencia · Push Android BInova

Fecha: 2026-10-05

## Implementación verificada en código

- API: Firebase Admin SDK con cuenta de servicio por ruta configurada, entrega multicast, revocación de tokens inválidos y aislamiento de errores del proveedor.
- API: operaciones nuevas y creación de tarjeta virtual persisten el inbox dentro de la transacción y despachan después del commit.
- API: POST /v1/notifications/test protegido por autenticación y por PUSH_TEST_ENDPOINT_ENABLED.
- App: Firebase Core/Messaging, google-services.json del proyecto binova-92083 y firebase_options.dart Android.
- App: registro Android en /v1/devices, renovación de token y revocación al cerrar sesión.
- App: notificación local en primer plano; bandeja FCM y navegación desde tap en segundo plano/app terminada.
- Seguridad: el payload usa solo type, notificationId, resourceType y resourceId; no se registran tokens ni datos financieros.

## Validación automatizada

| Comprobación | Resultado |
|---|---|
| API npm test -- --runInBand --watchman=false | Aprobado según la evidencia actual |
| API npm run build | Aprobado |
| Flutter flutter test | Aprobado: suite completa con 16 pruebas |
| Flutter widgets/accessibility | Aprobado: 2 pruebas específicas |
| Flutter dart analyze | Aprobado sin errores; permanecen infos/deprecaciones preexistentes |
| Secret account JSON en git | Ignorado por firebase-adminsdk*.json; no se versiona |

## Validación manual Android

El usuario confirmó que las pruebas push Android funcionan correctamente. La validación cubrió notificaciones en primer plano, segundo plano y aplicación terminada. La captura compartida muestra notificaciones de BInova en la bandeja Android para operación completada y tarjeta virtual creada.

El recorrido esperado y validado fue:

1. Ejecutar el API con la base migrada, PUSH_ENABLED=true y el secreto Firebase montado.
2. Ejecutar la app Android con el API accesible desde el dispositivo.
3. Iniciar sesión y registrar el dispositivo Android en /v1/devices.
4. Ejecutar una operación o POST /v1/notifications/test.
5. Comprobar inbox, foreground, background y app terminada.
6. Tocar el mensaje y comprobar el destino allowlisted.

Esta evidencia es una confirmación manual del usuario, no una ejecución automatizada del agente. Aún queda conservar una captura o log de deep link si se requiere una auditoría formal y configurar secretos en cada ambiente desplegado.

iOS push, Crashlytics/Sentry, dashboards operativos y workflow CI continúan fuera de esta implementación.
