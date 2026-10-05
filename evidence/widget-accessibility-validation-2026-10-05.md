# Evidencia de pruebas de widgets y accesibilidad

Fecha: 2026-10-05
Proyecto: `binova_app`

## Pruebas ejecutadas

```bash
./.fvm/flutter_sdk/bin/flutter test test/widgets_accessibility_test.dart
./.fvm/flutter_sdk/bin/flutter test
```

Resultado de la prueba específica:

```text
00:00 +2: All tests passed!
```

Resultado de la suite completa:

```text
00:02 +16: All tests passed!
```

## Cobertura

- Tarjeta de saldo: muestra el saldo, alterna entre visible/oculto y expone etiquetas semánticas.
- Encabezado principal: expone las acciones etiquetadas de perfil y notificaciones, y ejecuta sus callbacks.
- Accesibilidad: se validaron etiquetas de objetivos táctiles y los tamaños mínimos de Android (`48 × 48`) e iOS (`44 × 44`).

## Ajustes realizados

- El avatar principal y el botón de notificaciones ahora tienen un área táctil mínima de `48 × 48`.
- El control de mostrar/ocultar saldo conserva su diseño visual, pero cuenta con un área táctil accesible de `48 × 48`.
