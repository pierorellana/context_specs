# ADR-008 · Push y deep links
**Estado:** aceptado

FCM registra el dispositivo Android. El API persiste el inbox antes de intentar el envío
Firebase Admin y el payload mínimo se valida contra una allowlist de destinos.
La navegación se resuelve por router/coordinador; no se ejecutan URLs arbitrarias.

Estado de implementación: contrato de dispositivos, inbox, envío Firebase Admin y la
configuración Flutter Android están implementados. La app muestra foreground mediante
notificación local y background/terminated mediante FCM y taps controlados. La validación
en dispositivo/emulador, secretos por ambiente y la configuración iOS quedan pendientes
o fuera de alcance para esta iteración.
