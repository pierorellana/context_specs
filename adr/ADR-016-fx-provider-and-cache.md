# ADR-016 · Proveedor FX, credenciales y fallback

**Estado:** aceptado

## Contexto

BInova debe demostrar una consulta real de tipos de cambio sin exponer credenciales
en Flutter ni bloquear el resto de la aplicación cuando el proveedor externo falle.

## Decisión

NestJS expone el puerto `FxProvider` y un adapter reemplazable. La implementación
concreta se selecciona mediante configuración por ambiente:

- `FX_PROVIDER_BASE_URL`
- `FX_PROVIDER_NAME`
- `FX_PROVIDER_API_KEY` cuando aplique
- `FX_PROVIDER_TIMEOUT_MS`, default demo `2000`
- `FX_CACHE_TTL_SECONDS`, default demo `60`
- `FX_STALE_MAX_AGE_SECONDS`, default demo `900`

Las credenciales se leen desde variables protegidas o secret manager. Nunca llegan a
Flutter, al OpenAPI público, al repositorio ni a logs.

El adapter normaliza la respuesta a `base`, `quote`, `rate`, `asOf`, `source` y
`stale`. NestJS mantiene cache del payload normalizado por par de monedas. Un fallo
transitorio devuelve cache stale dentro de la ventana permitida; si no existe un
valor válido, responde `FX_UNAVAILABLE`/503. La aplicación móvil solo debe interpretar
el contrato BInova.

## Alternativas descartadas

- Llamar al proveedor directamente desde Flutter: expone credenciales y acopla la app.
- Tasas hardcodeadas como comportamiento final: no demuestra la integración externa.
- Bloquear Home por fallo FX: contradice RN-07.

## Verificación

El API actual usa el adapter demo determinista cuando `FX_PROVIDER_BASE_URL` está vacío
y conserva la ruta para un adapter HTTP real con timeout, fallback y métricas. CI aún
debe formalizar el fake determinista; el smoke con proveedor externo real queda sujeto
a credenciales y configuración del ambiente demo.
