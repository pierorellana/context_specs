# Matriz de trazabilidad BInova

| SPEC | Capacidad | Requisitos | Documento | Estado actual |
|---|---|---|---|---|
| SPEC-000 | Modo de trabajo SDD | RNF-11, RNF-13, RNF-15 | SPEC-000-working-mode.md | Implementado |
| SPEC-001 | Modelo de dominio | RN-01, RN-09, RN-10, RN-11 | SPEC-001-domain-model.md | Implementado |
| SPEC-002 | Contrato REST BInova | RF-03, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10, RF-11, RF-12, RF-13, RF-14, RF-19 | SPEC-002-api-contract.md | Implementado; CI de contrato pendiente |
| SPEC-003 | Autenticación y sesiones | RF-03, RF-04, RF-15, RN-03, RN-04 | SPEC-003-authentication-sessions.md | Implementado |
| SPEC-004 | Splash, onboarding y Face ID | RF-01, RF-02, RF-04, RNF-09, RNF-10 | SPEC-004-bootstrap-onboarding-biometry.md | Implementado; hardware real pendiente |
| SPEC-005 | Home y personalización dinámica | RF-05, RF-19, RN-05, RN-17 | SPEC-005-dashboard-personalization.md | Implementado |
| SPEC-006 | Cuentas y productos | RF-06, RN-01, RN-06, RN-11 | SPEC-006-accounts-products.md | Implementado |
| SPEC-007 | Movimientos | RF-07, RN-01, RN-06 | SPEC-007-transactions.md | Implementado |
| SPEC-008 | Transferencias | RF-08, RN-02, RN-08, RN-09, RN-10 | SPEC-008-transfers.md | Implementado; smoke financiero pendiente |
| SPEC-009 | Pagos y recargas | RF-09, RN-02, RN-08, RN-09 | SPEC-009-payments-topups.md | Implementado; smoke específico pendiente |
| SPEC-010 | Tarjetas, gestión y creación de tarjeta virtual | RF-10, RN-12, RN-18 | SPEC-010-cards.md | Implementado; smoke biométrico pendiente |
| SPEC-011 | Financial Insights | RF-11, RN-13 | SPEC-011-financial-insights.md | Implementado |
| SPEC-012 | Conversor de monedas | RF-12, RN-07 | SPEC-012-exchange-rates.md | Demo implementada; FX real pendiente |
| SPEC-013 | Notificaciones y deep links | RF-13, RF-14, RN-14 | SPEC-013-notifications.md | Android FCM implementado y validado manualmente |
| SPEC-014 | Perfil, seguridad y preferencias | RF-15, RN-03, RN-04 | SPEC-014-profile-security.md | Implementado |
| SPEC-015 | Conectividad degradada y estados | RF-16, RF-20, RN-06, RN-07, RN-08, RN-09 | SPEC-015-degraded-connectivity.md | Implementado en debug/demo; E2E de recuperación pendiente |
| SPEC-016 | Observabilidad y experiencia | RF-18, RNF-12 | SPEC-016-observability.md | API y logs móviles sanitizados implementados; telemetría externa pendiente |
| SPEC-017 | Pruebas y evidencia | RNF-08 | SPEC-017-testing-e2e.md | E2E crítico y accesibilidad aprobados; CI y recorridos adicionales pendientes |
| SPEC-018 | Uso de IA y automatización | RNF-13 | SPEC-018-ai-usage.md | Evidencia documentada; revisión final pendiente |
| SPEC-019 | Release, demo y Developer Tools | RF-17, RNF-11 | SPEC-019-release-demo.md | Demo local implementada; release/CI pendiente |

## Cobertura de la prueba

- Onboarding y autenticación: SPEC-003, SPEC-004.
- Cuentas, saldos y movimientos: SPEC-006, SPEC-007.
- Personalización dinámica: SPEC-005.
- Servicio externo: SPEC-012.
- Push: SPEC-013.
- Observabilidad: SPEC-016.
- Conectividad degradada: SPEC-015.
- Unit, widget, accesibilidad y E2E: SPEC-017.
- IA: SPEC-018.
- Trunk Based Development: SPEC-000, SPEC-019 y ADR-012.
