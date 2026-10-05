# Matriz de trazabilidad BInova

| SPEC | Capacidad | Requisitos | Documento |
|---|---|---|---|
| SPEC-000 | Modo de trabajo SDD | RNF-11, RNF-13, RNF-15 | `SPEC-000-working-mode.md` |
| SPEC-001 | Modelo de dominio | RN-01, RN-09, RN-10, RN-11 | `SPEC-001-domain-model.md` |
| SPEC-002 | Contrato REST BInova | RF-03, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10, RF-11, RF-12, RF-13, RF-14, RF-19 | `SPEC-002-api-contract.md` |
| SPEC-003 | Autenticación y sesiones | RF-03, RF-04, RF-15, RN-03, RN-04 | `SPEC-003-authentication-sessions.md` |
| SPEC-004 | Splash, onboarding y Face ID | RF-01, RF-02, RF-04, RNF-09, RNF-10 | `SPEC-004-bootstrap-onboarding-biometry.md` |
| SPEC-005 | Home y personalización dinámica | RF-05, RF-19, RN-05, RN-17 | `SPEC-005-dashboard-personalization.md` |
| SPEC-006 | Cuentas y productos | RF-06, RN-01, RN-06, RN-11 | `SPEC-006-accounts-products.md` |
| SPEC-007 | Movimientos | RF-07, RN-01, RN-06 | `SPEC-007-transactions.md` |
| SPEC-008 | Transferencias | RF-08, RN-02, RN-08, RN-09, RN-10 | `SPEC-008-transfers.md` |
| SPEC-009 | Pagos y recargas | RF-09, RN-02, RN-08, RN-09 | `SPEC-009-payments-topups.md` |
| SPEC-010 | Tarjetas, gestión y creación de tarjeta virtual | RF-10, RN-12, RN-18 | `SPEC-010-cards.md` |
| SPEC-011 | Financial Insights | RF-11, RN-13 | `SPEC-011-financial-insights.md` |
| SPEC-012 | Conversor de monedas | RF-12, RN-07 | `SPEC-012-exchange-rates.md` |
| SPEC-013 | Notificaciones y deep links | RF-13, RF-14, RN-14 | `SPEC-013-notifications.md` |
| SPEC-014 | Perfil, seguridad y preferencias | RF-15, RN-03, RN-04 | `SPEC-014-profile-security.md` |
| SPEC-015 | Conectividad degradada y estados | RF-16, RF-20, RN-06, RN-07, RN-08, RN-09 | `SPEC-015-degraded-connectivity.md` |
| SPEC-016 | Observabilidad y experiencia | RF-18, RNF-12 | `SPEC-016-observability.md` |
| SPEC-017 | Pruebas y evidencia | RNF-08 | `SPEC-017-testing-e2e.md` |
| SPEC-018 | Uso de IA y automatización | RNF-13 | `SPEC-018-ai-usage.md` |
| SPEC-019 | Release, demo y Developer Tools | RF-17, RNF-11 | `SPEC-019-release-demo.md` |

## Cobertura de la prueba
- Onboarding/autenticación: SPEC-003, 004.
- Cuentas/saldos/movimientos: SPEC-006, 007.
- Personalización dinámica: SPEC-005.
- Servicio externo: SPEC-012.
- Push: SPEC-013.
- Observabilidad: SPEC-016.
- Conectividad degradada: SPEC-015.
- Unit/widget/E2E: SPEC-017.
- IA: SPEC-018.
- Trunk Based Development: SPEC-000, 019 + ADR-012.
