---
schema_version: 2
id: SPEC-012
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["ADR-003", "ADR-007"]
requirements: ["RF-12", "RN-07"]
prototype_role: primary
---

# SPEC-012 · Conversor de monedas

## 1. Propósito y alcance
Integración real de un tercero para tasas de cambio.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
Flutter llama `/v1/exchange-rates`.
NestJS llama proveedor FX con timeout y cache.
Respuesta incluye base, quote, rate, asOf, source y stale.
La conversión es informativa.

La integración se implementa detrás de un puerto `FxProvider` en NestJS. El proveedor
concreto se selecciona por ambiente y nunca se conoce desde Flutter. La configuración
mínima es:

- `FX_PROVIDER_BASE_URL`: URL base del proveedor externo.
- `FX_PROVIDER_NAME`: nombre que se devuelve en `source`.
- `FX_PROVIDER_API_KEY`: opcional; solo backend/secret manager cuando el proveedor lo requiere.
- `FX_PROVIDER_TIMEOUT_MS`: timeout explícito, default demo 2000 ms.
- `FX_CACHE_TTL_SECONDS`: ventana fresh, default demo 60 s.
- `FX_STALE_MAX_AGE_SECONDS`: máximo de fallback stale, default demo 900 s.

El adapter normaliza la respuesta externa a `ExchangeRate`. El cache guarda el payload
normalizado, `fetchedAt`, `schemaVersion` y el par base/quote. Ante timeout o error
transitorio se puede devolver el último valor dentro de la ventana stale con
`stale=true`; fuera de esa ventana se devuelve `FX_UNAVAILABLE` con HTTP 503. No se
reintenta indefinidamente ni se bloquean cuentas, movimientos u operaciones internas.

## 4. Errores y estados
`FX_UNAVAILABLE` muestra reintentar y no bloquea resto del app. Puede servir cache con stale=true.

## 5. Criterios de aceptación / Done
- No hay API key en Flutter.
- Se puede reemplazar proveedor sin modificar mobile.
- Demo local muestra una llamada mediante el adapter demo determinista.
- CI debe usar un adapter fake determinista; el smoke demo con proveedor externo real
  queda pendiente de configuración.
- Las credenciales provienen de variables/secret manager por ambiente y no se versionan.

## 6. Estado actual

La app y el API consumen el contrato de tasas; el ambiente local usa el adapter demo.
No se han configurado credenciales de un proveedor externo en este workspace.

## 7. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 8. Decisiones pendientes
La estrategia de adapter, credenciales, timeout y cache queda resuelta en
`ADR-016-fx-provider-and-cache.md`. Solo queda configurar el proveedor concreto y sus
credenciales en el ambiente demo antes del smoke real.
