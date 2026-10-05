# ADR-003 · Backend NestJS modular
**Estado:** aceptado

Cada dominio se expresa como módulo NestJS con controller, service/use-case, contracts y
repository/adapter. Los cross-cutting concerns viven en `common/` e `infrastructure/`.
