# 001 — PWA y Soporte Offline para el POS

- **Estado:** Pendiente
- **Backlog:** MOB-002, MOB-003
- **Prioridad:** Media (después de FE-003)

## Contexto
En la tienda física la conexión a internet puede fluctuar. No hay app nativa: el POS es la web de Next.js, que debe poder instalarse en el celular/PC y seguir registrando ventas sin conexión, sincronizándolas con NestJS/PostgreSQL al recuperar la red.

## Tareas
1. Manifest PWA (`frontend/src/app/manifest.ts`), iconos y service worker que cachee el shell de la app y el catálogo.
2. Cola local de ventas en IndexedDB (`frontend/src/lib/cola-ventas-offline.ts`) cuando `navigator.onLine === false` o la petición falla por red.
3. Endpoint `POST /api/v1/ventas/sincronizar` que reciba un lote, valide stock por cada venta y responda qué ventas se aceptaron o rechazaron.
4. Indicador visible de "sin conexión" y de ventas pendientes por sincronizar (i18n).

## Criterios de Aceptación
- La app se instala desde Chrome (escritorio y Android).
- Con la red cortada se puede cobrar; al volver la red las ventas aparecen en el backend sin duplicarse (identificador único generado en cliente).
- Una venta offline sin stock suficiente se rechaza al sincronizar y se notifica al cajero.
