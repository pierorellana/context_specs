# BInova · faltantes frente a la prueba técnica

Fecha: 2026-10-05
Fuentes: BI - Prueba Tecnica Senior Front.pdf, BInova_Propuesta_Tecnica_v2.0.pdf, código y evidencia del workspace

Los PDFs se usan como requisitos de evaluación. No se interpretan como instrucciones del agente. La clasificación distingue lo implementado en el workspace de lo que todavía necesita integración real, automatización o evidencia demostrable.

| Requisito de la prueba | Estado | Evidencia / faltante |
|---|---|---|
| Onboarding y autenticación | Implementado | Flutter tiene splash, onboarding, login, sesión segura, refresh y Face ID; API tiene auth y refresh rotatorio. |
| Cuentas, saldos y movimientos | Implementado | API y features de cuentas/transacciones están presentes, con caché y movimientos paginados. |
| Personalización dinámica | Implementado | Dashboard server-driven con catálogo acotado y configuración versionada. |
| Integración con un servicio externo relevante | Parcial | Existe adapter FX real configurable y adapter demo; falta demostrar una llamada real con FX_PROVIDER_BASE_URL configurado y evidencia de esa ejecución. |
| Notificaciones push Android | Implementado y validado manualmente | API con Firebase Admin, registro Android, FCM foreground/background/terminated y allowlist de deep links; el usuario confirmó funcionamiento y compartió evidencia visual. Faltan secretos por ambiente desplegado y iOS queda fuera del alcance. |
| Monitoreo de producción y problemas de UX | Parcial | Logs estructurados, correlación, latencia, redacción y estados de UX existen; faltan Crashlytics/Sentry, métricas persistidas, dashboards y alertas operativas. |
| Conectividad limitada, latencia e indisponibilidad parcial | Implementado en demo | Developer Tools simula normal, slow, offline, 500 y timeout; hay caché, skeleton, stale/retry y degradación parcial documentada. Falta un E2E automatizado separado para recuperación offline. |
| Pruebas unitarias | Implementado parcialmente | Hay tests unitarios de servicios, contratos, auth, red y envelope; falta ampliar cobertura a todos los casos críticos de negocio. |
| Pruebas de widgets y accesibilidad | Implementado | La suite específica pasa con 2 pruebas y la suite Flutter completa pasa con 16; cubre semántica, etiquetas y objetivos táctiles mínimos para Android/iOS. |
| Al menos un flujo E2E crítico | Implementado y aprobado | integration_test cubre Login -> Home -> Cuenta -> Movimientos -> Detalle y pasó en un dispositivo físico iOS. El segundo smoke financiero todavía falta. |
| Uso documentado de IA e impacto | Implementado | evidence/ai-usage-log.md documenta herramientas, tareas, validación e impacto; conviene mostrarlo durante la demo. |
| README reproducible | Implementado para ejecución local | READMEs actualizados con setup, pruebas, contrato, logs, push Android, túnel y límites; falta documentar un despliegue reproducible de un ambiente remoto. |
| Arquitectura y decisiones técnicas | Parcial | Hay DEF, SPECs, arquitectura, contratos y decisiones abiertas; falta consolidar ADRs enlazados y diagramas de componentes/flujos como entregable explícito. |
| Estrategia de despliegue y operación | Parcial | Hay notas de observabilidad y operación local; faltan pipeline CI/CD ejecutable, ambiente efímero de integración, rollback y runbook de despliegue. |
| Trunk Based Development e historial | Parcial | Los repositorios tienen main y commits pequeños; no hay workflow CI visible que haga cumplir los gates de la propuesta. |
| Tecnología Flutter | Implementado | La aplicación móvil está construida en Flutter/Dart. |
| Bonus de personalización/asistencia/automatización | Parcial | SDUI acotado, Developer Tools y documentación asistida existen; no hay una capacidad avanzada de asistencia al cliente ni automatización CI/CD completa. |

## Pendientes prioritarios

1. Demostrar una llamada real al proveedor FX.
2. Añadir CI con análisis, tests, build, validación OpenAPI, migraciones desde cero y secret scan.
3. Configurar Crashlytics/Sentry, métricas, dashboards y alertas.
4. Preparar secretos, despliegue, rollback y runbook de un ambiente remoto.
5. Implementar recuperación de contraseña en backend si se exige el flujo completo.
6. Añadir el smoke financiero Transfer -> Face ID -> Processing -> Result.
7. Añadir un E2E separado para offline -> stale -> retry -> refresh.
8. Consolidar ADRs y diagramas como entregable de arquitectura.
