# E2E crítico

## Estado

Implementado y aprobado en un dispositivo físico iOS el 2026-10-05.

## Flujo automatizado actual

1. Arrancar API con seed o usar el ambiente accesible configurado.
2. Abrir app sin sesión.
3. Completar onboarding cuando aplica.
4. Iniciar sesión con usuario demo.
5. Abrir Productos.
6. Abrir Cuenta de Ahorros.
7. Abrir Movimientos.
8. Abrir un movimiento.
9. Verificar la navegación y solicitar captura del detalle.

Comando reproducible desde binova_app:

    fvm flutter test integration_test/critical_flow_test.dart -d DEVICE_ID --dart-define=API_BASE_URL=API_URL --dart-define=ENVIRONMENT=local

La prueba actual se ejecutó contra el túnel de desarrollo y terminó con All tests passed!. La evidencia completa, dispositivo y API están en evidence/e2e-critical-flow-2026-10-05.md.

## Flujos todavía separados

El modo offline, stale, timestamp, retry y refresh después de reconectar están cubiertos por la implementación y Developer Tools, pero aún requieren un E2E automatizado propio.

El smoke financiero Transfer -> Face ID -> Processing -> Result también queda como recorrido adicional de entrega.
