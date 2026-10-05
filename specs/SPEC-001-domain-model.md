---
schema_version: 2
id: SPEC-001
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-003", "ADR-014"]
requirements: ["RN-01", "RN-09", "RN-10", "RN-11"]
prototype_role: primary
---

# SPEC-001 · Modelo de dominio

## 1. Propósito y alcance
Define entidades y value objects compartidos conceptualmente entre mobile y API.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Entidades: User, Session, Account, Card, Transaction, Beneficiary, FinancialOperation,
DashboardConfig, Insight, ExchangeRate, Notification, DeviceRegistration.
Money = amount decimal string + currency.
FinancialOperation usa status `processing|pending|succeeded|failed`.

## 4. Errores y estados
Entidades inválidas se rechazan antes de persistir; el API devuelve `VALIDATION_ERROR`.

## 5. Criterios de aceptación / Done
- El modelo soporta todos los módulos del MVP.
- No se usa float/double para reglas monetarias.
- IDs son UUID salvo catálogos explícitos.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
