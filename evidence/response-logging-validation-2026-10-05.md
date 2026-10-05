# Evidencia de envelope y logs sanitizados

**Fecha:** 2026-10-05  
**Alcance:** `binova_app`, `api_binova`, OpenAPI y limpieza de `binova_app/lib`

## Cambios verificados

- El API responde éxitos con `data`, `message`, `statusCode` y `meta`.
- El API responde errores con `data: null`, `message`, `statusCode`, `code`, `details` y `meta`.
- `/v1/health` también usa el envelope común.
- `X-Correlation-Id` se conserva en `meta.traceId` y en el header de respuesta.
- Flutter parsea el nuevo envelope y registra solo método, ruta, status, duración, mensaje, código y correlación.
- El API serializa eventos `api_request` y `dependency_call` con una allowlist de campos.
- La prueba móvil confirma que `data`, balances y tokens no aparecen en el evento de log.
- No quedan comentarios `//`, `/* ... */` o `///` bajo `binova_app/lib`.

## Comandos y resultados

| Comando | Resultado |
|---|---|
| `npm test -- --runInBand` en `api_binova` | PASS: 7 suites, 12 tests |
| `npm run build` en `api_binova` | PASS |
| `DATABASE_URL=postgresql://postgres:postgres@localhost:5432/binova npx prisma validate` | PASS; schema válido |
| `flutter pub get` en `binova_app` | PASS; dependencias descargadas |
| `flutter test --no-pub` en `binova_app` | PASS: 9 tests |
| `dart analyze` directo con Dart 3.11 | Sin errores; 28 infos preexistentes deprecaciones |
| `ruby -e "require 'yaml'; YAML.load_file('contracts/openapi.yaml')"` | PASS; YAML válido |
| `rg` de comentarios bajo `binova_app/lib` | PASS; sin resultados |
| `git diff --check` de los commits de código | PASS |

El comando estándar `flutter analyze` no pudo ejecutarse al final porque el wrapper intentó escribir `bin/cache/engine.stamp` en un SDK FVM fuera del workspace y el entorno lo bloqueó. El análisis directo del Dart SDK sí terminó y no reportó errores de compilación o tipos.

No se pudo completar el smoke HTTP contra `/v1/health`: el API compiló y registró rutas, pero el arranque terminó porque PostgreSQL no estaba disponible en `localhost:5432`. La forma de respuesta del endpoint quedó cubierta por `health.module.spec.ts`.

`npm ci` reportó 34 vulnerabilidades de dependencias transitivas (2 moderadas y 32 altas); no se actualizó el árbol de dependencias porque no formaba parte del alcance solicitado.

## Commits de implementación

- API envelope: `9efc1ac`
- API logging y redacción: `beb3a75`
- Health envelope: `d258155`
- Flutter parsing y logs: `9afcfbb`
- Limpieza de comentarios: `2c627a5`
- Manejo explícito de errores de notificaciones: `178f0a4`
- OpenAPI/SPEC/traceability: `79682f1`
