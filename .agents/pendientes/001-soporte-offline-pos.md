# Requerimiento Pendiente: Optimización de Soporte Offline para POS

## Contexto
En tiendas físicas de calzado, la conexión a internet puede fluctuar. El Punto de Venta (POS) debe permitir registrar ventas en una base de datos SQLite local a través de los comandos de Tauri en Rust, y sincronizar automáticamente con el backend NestJS y PostgreSQL en cuanto se restablezca la conexión.

## Tareas
1. Implementar almacenamiento local en `src-tauri/src/comandos/almacenamiento_local.rs`.
2. En el Frontend, detectar el evento `navigator.onLine` y enviar las transacciones por IPC a Tauri si no hay conexión.
3. Cola de sincronización (`SyncQueue`) para enviar transacciones pendientes al endpoint `/api/v1/ventas/sincronizar`.
