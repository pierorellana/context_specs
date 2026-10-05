# ADR-008 · Push y deep links
**Estado:** aceptado

FCM registra dispositivo. Payload mínimo y deep link validado contra allowlist.
La navegación se resuelve por router; no se ejecutan URLs arbitrarias.

Estado de implementación: contrato de dispositivos, inbox y lectura están en el API;
la integración SDK/credenciales, recepción push y validación en dispositivo quedan
pendientes hasta recibir Firebase.
