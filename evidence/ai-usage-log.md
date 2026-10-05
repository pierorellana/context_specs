# Registro de uso de IA

| Fecha | Tarea | Herramienta | Resultado | Validación humana | Impacto |
|---|---|---|---|---|---|
| 2026-10-04 | Scaffolding de SPECs, ADRs y plan | ChatGPT/Claude + revisión técnica | Contexto SDD inicial | Revisión del autor y actualización documental posterior | No sustituye validación de código |
| 2026-10-04 | Implementación Flutter completa | Codex + Dart analyzer + Flutter test | Clean Architecture + Provider, contratos REST, caché, biometría y UI del prototipo | Suite Flutter, análisis, APK debug y flujos visuales en emulador | Base funcional móvil y evidencia reproducible |
| 2026-10-04 | Implementación API completa | Codex + NestJS/Prisma/Jest | Auth, cuentas, operaciones, tarjetas, insights, FX demo, notificaciones y observabilidad | Suite API, build y migraciones Prisma aplicadas localmente | Contrato y servicios listos para integración |
| 2026-10-05 | Logging, envelope y documentación | Codex + revisión técnica | Logs sanitizados, envelope data/message/statusCode/meta y READMEs sincronizados | Evidencia de respuesta, correlación y diff documental | Trazabilidad operativa y onboarding técnico |
| 2026-10-05 | Notificaciones push Android | Codex + revisión humana en dispositivo | FCM foreground/background/terminated, inbox y navegación allowlisted | Usuario confirmó funcionamiento y compartió captura de la bandeja Android | Cierre de validación del requisito push Android |
| 2026-10-05 | E2E, widgets y accesibilidad | Codex + Flutter test en dispositivos | integration_test crítico, semántica y objetivos táctiles accesibles | E2E físico aprobado; suite específica 2/2 y suite completa 16/16 | Evidencia de calidad móvil para la prueba |
| 2026-10-05 | Reestructuración y publicación | Codex + Git | Repos separados binova_app, api_binova y context_specs | Tres ramas main actualizadas con commits convencionales | Entrega documental y técnica sincronizada |

No declarar ahorros estimados como hechos sin medición. Las tareas restantes deben cerrar con evidencia de CI, FX real, release y operación.
