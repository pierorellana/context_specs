# Evidencia E2E del flujo crítico móvil

Fecha: 2026-10-05
Dispositivo: iPhone Pierre (`00008140-001461680A7B801C`)
Sistema: iOS 27.0.1
API: `https://9hqbzkgw-3000.use.devtunnels.ms/v1`

## Comando ejecutado

```bash
./.fvm/flutter_sdk/bin/flutter test integration_test/critical_flow_test.dart \
  -d 00008140-001461680A7B801C \
  --dart-define=API_BASE_URL=https://9hqbzkgw-3000.use.devtunnels.ms/v1 \
  --dart-define=ENVIRONMENT=local
```

## Resultado

```text
00:21 +1: All tests passed!
```

El flujo validado fue:

1. Completar onboarding cuando aplica.
2. Iniciar sesión con el usuario demo.
3. Abrir Productos.
4. Abrir la cuenta de ahorros.
5. Consultar Movimientos.
6. Abrir el detalle de una transacción.

La prueba también solicitó la captura `critical-flow-transaction-detail` mediante `takeScreenshot`.

Como verificación complementaria, el túnel respondió correctamente para login, cuentas, detalle de cuenta y movimientos. Las notificaciones push Android no se repitieron porque ya fueron validadas funcionalmente por el usuario.
