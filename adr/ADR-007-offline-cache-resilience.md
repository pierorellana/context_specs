# ADR-007 · Caché y resiliencia
**Estado:** aceptado

Stale-while-revalidate para lecturas; timestamp visible; retry exponencial selectivo.
Una caché puede pintar, no autorizar. Timeout no equivale a fallo definitivo de escritura.
