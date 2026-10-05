---
schema_version: 2
id: SPEC-010
profile: binova
document_status: approved
primary_surface: app
surfaces: [app, api]
depends_on: ["SPEC-003", "ADR-015"]
requirements: ["RF-10", "RN-12", "RN-18"]
prototype_role: primary
---

# SPEC-010 · Tarjetas, gestión y creación de tarjeta virtual

## 1. Propósito y alcance
Lista el stack inicial de tarjetas y permite gestionar tarjetas existentes. La creación
de tarjeta virtual es el flujo prioritario y conserva el motion dinámico de
construcción/apilado del prototipo.

## 2. UI / referencia de prototipo
El look & feel se deriva del prototipo BInova iOS. La implementación Flutter debe conservar
jerarquía, copy, motion y estados relevantes sin trasladar CSS/HTML literalmente.

## 3. Reglas
La pantalla de tarjetas incluye, dentro del MVP, las tarjetas débito, crédito y virtual
del stack demo, cuando existan. Crear tarjeta: intro -> Face ID -> request -> build
animation -> dock/stack -> result.
La animación representa progreso visual, pero el estado real proviene del API.
POST `/v1/cards/virtual` devuelve tarjeta enmascarada; no expone CVV persistente en logs.
La pantalla final permite detalle, congelar/descongelar, consultar límites y enviar la
tarjeta a Apple Wallet. Congelar/descongelar es una capacidad incluida del MVP, no un
requisito bloqueante para la primera entrega del flujo de creación.

Endpoints de gestión:
- `GET /v1/cards`
- `GET /v1/cards/{id}`
- `POST /v1/cards/{id}/freeze`
- `POST /v1/cards/{id}/unfreeze`
- `GET/PATCH /v1/cards/{id}/limits`
- `POST /v1/cards/{id}/wallet-provisioning`

## 4. Errores y estados
Biometría fallida, creación pending, rejected, network loss, tarjeta ya congelada,
tarjeta ya activa y tarjeta no elegible. La animación se detiene y muestra estado real.

## 5. Criterios de aceptación / Done
- Las tarjetas se apilan de forma fluida en el prototipo/Flutter.
- El stack inicial puede mostrar débito, crédito y virtual según el catálogo demo.
- Congelar/descongelar actualiza el estado desde backend; no se simula éxito local.
- Límites y Wallet tienen un contrato explícito y estados de error/pending.
- Reduce Motion reemplaza 3D por fade/translate.
- Nunca se muestra PAN/CVV completo en evidencia o logs.

## 6. Fuera de alcance
Capacidades productivas no requeridas por el MVP y reglas no declaradas en el DEF.

## 7. Decisiones pendientes
Ninguna para v2.0 salvo las registradas en `context/decisions/open-findings.md`.
