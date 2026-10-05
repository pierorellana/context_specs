# ADR-011 · Estrategia de pruebas
**Estado:** aceptado

Pirámide: unit > widget/component > backend integration/contract > E2E crítico.
El flujo E2E principal es Login -> Home -> Cuenta -> Movimientos -> Detalle.
Un segundo smoke cubre Transferencia -> Face ID -> Processing -> Resultado.
