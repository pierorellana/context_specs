# Registro de uso de IA

| Fecha | Tarea | Herramienta | Resultado | Validación humana | Impacto |
|---|---|---|---|---|---|
| pendiente | Scaffolding de SPECs | ChatGPT/Claude | borrador | revisión técnica | por medir |
| pendiente | Generación de tests | por definir | tests | ejecución CI + revisión | por medir |
| pendiente | Documentación ADR | por definir | ADR | revisión del autor | por medir |
| 2026-10-04 | Implementación Flutter fase lectura, tarjetas, insights, inbox y contratos de operaciones | Codex + Dart analyzer | Clean Architecture + Provider, HTTP/cache y estados degradados | `dart analyze` sin issues; `flutter test` pendiente por bloqueo del runner local | implementación inicial, sin afirmar cobertura hasta ejecutar tests |
| 2026-10-04 | Biometría local, refresh de sesión, Reduce Motion y pruebas de acceso | Codex + Flutter test | `local_auth 2.3.0`, secure refresh/retry, permisos nativos y tests de sesión | `dart analyze` sin issues, 5 tests Flutter passed, APK debug construido | Face ID/biometría listo para dispositivo compatible; FCM sigue diferido |
| 2026-10-04 | Foundation API NestJS: configuración, Prisma, envelope/error/correlation, auth rotatoria, cuentas y movimientos | Codex + NestJS/Prisma | Proyecto `binova_api`, migración inicial y seed demo | `npm run build`, `npm test` (1 passed), `prisma validate`; PostgreSQL real pendiente por no requerirse Docker en esta sesión | Primera vertical backend compilable; módulos financieros restantes continúan por SPEC |
| 2026-10-04 | API dashboard, perfil/preferencias, dispositivos e inbox de notificaciones | Codex + NestJS/Prisma | Migración forward-only `0002_dashboard_profile_notifications` y módulos contract-first | `npm run prisma:generate`, `npm run build`, `npm test` (1 passed), `prisma validate` | Firebase/FCM permanece diferido; registro de token queda preparado sin credenciales externas |
| 2026-10-04 | API operaciones financieras demo: beneficiarios, transferencias, pagos, recargas, deuda, estados e idempotencia | Codex + NestJS/Prisma | Migración forward-only `0003_operations`, hash de request y conflicto por reutilización de key | `npm run prisma:generate`, `npm run build`, `npm test` (1 passed), `prisma validate` | Proveedores externos permanecen simulados/controlados por el dominio demo; no se afirma integración productiva |

Completar con evidencia real durante el desarrollo. No declarar ahorros estimados como hechos sin medición.
