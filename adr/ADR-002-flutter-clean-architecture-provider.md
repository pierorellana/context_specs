# ADR-002 · Clean Architecture + Provider
**Estado:** aceptado

Provider/ChangeNotifier se usa en `presentation`; los ViewModels dependen de casos de uso.
No hay HTTP, DTOs ni reglas financieras en ChangeNotifier.

Se descartan Riverpod/BLoC por decisión explícita del proyecto: Provider cubre el alcance y
la experiencia del desarrollador sin cambiar la separación arquitectónica.
