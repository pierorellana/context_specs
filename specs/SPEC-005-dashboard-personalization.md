---
schema_version: 2
id: SPEC-005
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-006"]
requirements: ["RF-05", "RF-19", "RN-05", "RN-17"]
prototype_role: primary
---

# SPEC-005 · Home y personalización dinámica

## 1. Propósito y alcance
Home con saldo, quick actions, productos, recientes y sección Para ti.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
GET `/v1/dashboard` devuelve `schemaVersion`, `segment`, `sections[]`.
Tipos permitidos: balance, quick_actions, products, recent_transactions, insight,
exchange_promo, service_status.
Flutter ignora tipos desconocidos y usa fallback.

## 4. Errores y estados
Config inválida usa layout local seguro. Fallo parcial de promo/FX no bloquea Home.

## 5. Criterios de aceptación / Done
- Reordenar una sección desde backend no requiere nueva build.
- Controles de seguridad no son ocultables por config.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
