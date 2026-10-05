# ADR-005 · Sesión y biometría
**Estado:** aceptado

Access token corto + refresh token rotatorio. Secure storage. Face ID para reingreso/step-up.
La biometría no crea una sesión de backend ni autoriza por sí sola una operación.

La implementación Flutter encapsula `local_auth` detrás de `BiometricAuthenticator`.
La disponibilidad se detecta durante bootstrap; la autenticación usa biometría local y
no expone tokens ni datos financieros al plugin.
