# 002 — Importación de Datos desde la Hoja de Cálculo

- **Estado:** Pendiente
- **Backlog:** DAT-001, DAT-002, DAT-004
- **Prioridad:** Alta

## Contexto
`backend/src/datos/semillas.sql` contiene solo ~59 de los 149 productos reales, ninguna venta ni ingreso, e incluye hashes bcrypt de ejemplo inválidos. La hoja es legible vía el endpoint `gviz` (skill `consulta-hoja-calculo`).

## Tareas
1. Script `backend/src/datos/importar-hoja.ts` (ejecutable con `npm run importar:hoja --prefix backend`) que descargue las pestañas Inventario, Ventas, Ingreso Mercancia y Gastos Extra por GID.
2. Parseo de montos `Bs1.234,00` → `1234.00` y fechas `dd/MM/yyyy` (tolerar `7/7/26`, `6/06/2026`).
3. Descartar filas vacías (P150–P476, filas `Bs0,00`/`-`).
4. Inserción idempotente (`ON CONFLICT` / upsert por `codigoProducto`; ventas y gastos por hash de fila) dentro de una transacción.
5. Reporte de inconsistencias en consola y en `backend/src/datos/reporte-importacion.md`: stock negativo (P060, P068), ingreso con "ID no existe", nombres con espacios/mayúsculas erróneas.
6. Regenerar `semillas.sql` con el resultado completo y quitar el bloque de usuarios con hashes falsos.

## Criterios de Aceptación
- Tras importar: 149 calzados, 21 ventas (con sus detalles), 5 gastos (total Bs 86,00).
- Ejecutar el importador dos veces no duplica registros.
- Las inconsistencias quedan listadas, no se ocultan ni se "corrigen" en silencio.
