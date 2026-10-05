# DEF · BInova - Documento de Especificación Funcional

**Proyecto:** BInova - Plataforma Financiera Digital  
**Versión:** 2.0  
**Fecha:** Octubre 2026  
**Frontend:** Flutter + Provider  
**Backend:** NestJS + PostgreSQL + Prisma  
**Método:** SDD + Trunk Based Development  
**Canal prioritario:** iOS / iPhone-first

## 01. Objetivo

Definir el comportamiento verificable del MVP BInova para cubrir la prueba técnica:
onboarding/autenticación, cuentas/saldos/movimientos, personalización dinámica, integración
con un tercero, notificaciones push, resiliencia, observabilidad, pruebas y uso documentado
de IA.

## 02. Actores

| ID | Actor | Responsabilidad |
|---|---|---|
| ACT-01 | Cliente BInova | Consulta productos, movimientos, opera servicios y configura preferencias. |
| ACT-02 | BInova Mobile | Presenta experiencia, conserva caché segura y orquesta casos de uso locales. |
| ACT-03 | BInova API | Autoridad de sesión, contratos, datos, personalización, auditoría y adapters. |
| ACT-04 | Proveedor FX | Fuente externa real de tasas de cambio. |
| ACT-05 | Firebase | Push, Crashlytics/Analytics/Performance según ambiente. |
| ACT-06 | Operador técnico | Observa métricas, errores y salud del servicio. |

## 03. Módulos del MVP

- Acceso y sesión.
- Bootstrap, splash, onboarding y Face ID.
- Home dinámico/personalizado.
- Productos: cuentas y tarjetas.
- Movimientos.
- Transferencias.
- Pagos y recargas.
- Tarjetas: stack débito/crédito/virtual, creación de tarjeta virtual, congelar/descongelar,
  límites y handoff a Apple Wallet.
- Financial Insights.
- Conversor de monedas.
- Notificaciones y deep links.
- Perfil, seguridad y preferencias.
- Estados degradados: loading, offline, timeout, pending, error, retry.
- Observabilidad y panel de escenarios de demostración.

## 04. Reglas de negocio

| ID | Regla |
|---|---|
| RN-01 | El backend es autoridad de sesión, saldos, productos, movimientos y estados de operación. |
| RN-02 | La app no fabrica éxitos locales para transferencias, pagos, recargas ni creación de tarjeta. |
| RN-03 | Face ID protege reingreso local y step-up de operaciones sensibles, pero no sustituye la autenticación del backend. |
| RN-04 | Tokens y datos de sesión sensibles se almacenan solo en almacenamiento seguro. |
| RN-05 | El Home usa Server-Driven UI acotado: el backend ordena/activa componentes predefinidos; nunca envía código ejecutable. |
| RN-06 | Datos de caché pueden pintar la UI, pero se muestran con frescura y no autorizan decisiones sensibles. |
| RN-07 | Un fallo del servicio FX no bloquea cuentas, movimientos ni navegación esencial. |
| RN-08 | Reintentos automáticos solo aplican a lecturas idempotentes y errores transitorios; escrituras requieren idempotency key o acción explícita del usuario. |
| RN-09 | Transferencias, pagos y recargas tienen estados terminales `succeeded`, `failed` o `pending`; nunca se deduce éxito por timeout. |
| RN-10 | Montos usan `Decimal` en backend y entero de unidades menores o tipo decimal controlado en Flutter; no se usa `double` para reglas financieras. |
| RN-11 | Números de cuenta/tarjeta se enmascaran; nunca se exponen PAN completo, CVV, tokens ni secretos en logs. |
| RN-12 | La creación de tarjeta virtual exige step-up biométrico cuando la sesión/configuración lo indique. |
| RN-13 | La sección Insights es informativa; no ejecuta recomendaciones financieras ni decisiones crediticias. |
| RN-14 | Notificaciones navegan por deep link únicamente a destinos permitidos y validados. |
| RN-15 | Todo error visible se resuelve por código estable; mensajes técnicos internos no llegan al usuario. |
| RN-16 | La app sigue siendo útil con red deficiente: skeleton, caché, retry, estado parcial y recuperación explícita. |
| RN-17 | La personalización nunca oculta controles de seguridad ni obligaciones de confirmación de operaciones. |
| RN-18 | Las animaciones no son requisito para comprender estados y respetan Reduce Motion. |

## 05. Requerimientos funcionales

| ID | Requerimiento |
|---|---|
| RF-01 | Mostrar Splash y resolver ruta por primera vez/sesión existente/sesión ausente. |
| RF-02 | Mostrar onboarding iOS-first y permitir omitirlo. |
| RF-03 | Autenticar cliente y emitir access/refresh tokens. |
| RF-04 | Permitir reingreso mediante Face ID cuando exista sesión válida. |
| RF-05 | Mostrar Home personalizado con saldo, accesos rápidos, productos y sección "Para ti". |
| RF-06 | Consultar cuentas, tarjetas y detalle de producto. |
| RF-07 | Consultar movimientos paginados, filtros y detalle. |
| RF-08 | Ejecutar transferencia con confirmación, biometría, processing y resultado. |
| RF-09 | Ejecutar pago de servicio y recarga con estados equivalentes. |
| RF-10 | Listar y gestionar el stack de tarjetas demo; crear tarjeta virtual con animación de construcción/apilado, congelar/descongelar, consultar/actualizar límites y enviar a Apple Wallet con confirmación backend. |
| RF-11 | Mostrar Financial Insights calculados por backend sobre movimientos demo. |
| RF-12 | Consumir tipo de cambio real mediante adapter NestJS. |
| RF-13 | Registrar dispositivo y recibir push con deep link seguro. |
| RF-14 | Mostrar centro de notificaciones y marcar lectura. |
| RF-15 | Gestionar perfil, seguridad, biometría, preferencias y cierre de sesión. |
| RF-16 | Mostrar loading, offline, timeout, partial unavailable, pending, success y error. |
| RF-17 | Permitir simular escenarios de red en modo demo/desarrollo sin afectar producción. |
| RF-18 | Registrar telemetría operativa y UX sin PII sensible. |
| RF-19 | Exponer configuración dinámica de dashboard versionada. |
| RF-20 | Permitir recuperación después de reconexión/reintento conservando contexto cuando sea seguro. |

## 06. Requerimientos no funcionales

| ID | Requerimiento |
|---|---|
| RNF-01 | Arquitectura Clean Architecture + feature-first en Flutter. |
| RNF-02 | Provider/ChangeNotifier se limita a estado de presentación y coordinación de casos de uso. |
| RNF-03 | NestJS modular con límites por dominio, ValidationPipe, guards, filters e interceptors. |
| RNF-04 | PostgreSQL con Prisma y migraciones versionadas, reversibles cuando sea viable. |
| RNF-05 | HTTPS, secure storage y protección de secretos por ambiente. |
| RNF-06 | p95 objetivo < 800 ms para lecturas internas del demo sin proveedor externo; operaciones externas se observan por separado. |
| RNF-07 | Timeouts explícitos, retry selectivo, circuit/fallback en integraciones externas. |
| RNF-08 | Unit, widget, backend integration, contract y al menos un E2E crítico. |
| RNF-09 | Accesibilidad: contraste, 44x44pt, Dynamic Type conceptual, VoiceOver labels y Reduce Motion. |
| RNF-10 | iPhone-first, viewport de referencia 390x844 y navegación/gestos coherentes con iOS. |
| RNF-11 | Trunk Based Development, ramas cortas, commits atómicos y CI obligatoria. |
| RNF-12 | Observabilidad con logs estructurados, crash reporting, analytics y performance. |
| RNF-13 | Documentar uso de IA, validación humana e impacto. |
| RNF-14 | No mostrar scrollbars web ni overflows; scroll natural móvil. |
| RNF-15 | El prototipo es oráculo visual, no fuente de reglas financieras. |

## 07. Criterios globales de aceptación

1. Todos los requerimientos mínimos de la prueba tienen SPEC, implementación prevista y evidencia.
2. El flujo `Login -> Home -> Cuenta -> Movimientos -> Detalle` es reproducible E2E.
3. Una operación financiera demuestra `processing -> success/pending/error`.
4. El modo offline demuestra caché, timestamp, retry y recuperación.
5. FX proviene de una interacción externa real a través de NestJS.
6. Push o su configuración real queda demostrable con FCM y deep link.
7. El Home cambia por configuración remota sin reconstruir el binario.
8. Provider no contiene HTTP ni reglas financieras.
9. La documentación de ADRs, migraciones, riesgos, despliegue e IA está actualizada.
10. El historial Git demuestra Trunk Based Development.
