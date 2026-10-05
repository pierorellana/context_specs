# BInova - reglas para agentes/IA

- Leer primero `def/DEF-BInova.md`, la SPEC afectada y sus ADRs.
- No inventar reglas bancarias fuera de las SPEC.
- No colocar lógica de negocio dentro de widgets o ChangeNotifier.
- Flutter consume contratos; NestJS conserva autoridad sobre sesión, reglas y orquestación.
- Toda nueva ruta, estado de error o migración debe actualizar trazabilidad.
- Los datos sensibles nunca se registran en logs ni analytics.
- Las pantallas siguen el prototipo iOS como referencia visual, pero la SPEC gobierna comportamiento.
- Todo cambio debe incluir pruebas proporcionales y una nota de evidencia.
- Trabajar con ramas de vida corta y commits pequeños sobre `main`.
