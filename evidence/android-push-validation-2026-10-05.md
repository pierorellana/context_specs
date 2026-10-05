# Evidencia · Push Android BInova

**Fecha:** 2026-10-05

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
| API npm test -- --runInBand --watchman=false | Aprobado: 10 suites, 22 tests |
| API npm run build | Aprobado |
| Flutter flutter test --no-pub | Aprobado: 14 tests |
| Flutter dart analyze --suppress-analytics | Aprobado sin errores; permanecen infos/deprecaciones preexistentes |
| Secret account JSON en git | Ignorado por *firebase-adminsdk*.json; no se versiona |

## Validación manual pendiente

No se ejecutó desde este workspace una prueba de entrega FCM contra un dispositivo Android
o emulador con Google Play Services. Para cerrar la evidencia se requiere:

1. Ejecutar el API con base de datos migrada, PUSH_ENABLED=true y el secreto Firebase montado.
2. Ejecutar la app Android con el API accesible desde el dispositivo.
3. Iniciar sesión y comprobar que GET /v1/devices contiene un registro Android activo.
4. Invocar POST /v1/notifications/test y comprobar inbox, foreground, background y app terminada.
5. Tocar el mensaje y comprobar el destino allowlisted; repetir con un recurso desconocido.
6. Confirmar en logs que no aparecen token FCM, clave privada ni datos financieros.

iOS, Crashlytics/Sentry, dashboards operativos y el workflow CI continúan fuera de esta
implementación y deben tratarse como pendientes separados.
