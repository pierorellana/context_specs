# ADR-012 · Trunk Based Development y CI
**Estado:** aceptado

`main` es trunk. Ramas cortas, PR pequeña, commits convencionales.
CI: format/lint/analyze/tests/OpenAPI/migration checks/secret scan.

Estado actual: App, API y Context tienen repositorios separados y `main` actualizado
con commits convencionales. La automatización CI aún no está publicada; es el próximo
pendiente de entrega.
