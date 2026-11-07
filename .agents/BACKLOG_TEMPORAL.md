# BACKLOG TEMPORAL (Iteración 2026-11-03)

- **Fecha de inicio de iteración:** `2026-11-03`
- **Objetivo de la iteración:** Implementar el nuevo lote de requerimientos del cliente (25 ítems de WhatsApp + requerimiento de audio sobre liquidaciones por fechas), comenzando por la Fase 1 (Sesión, Usuarios y Empleados) y Fase 2 (Inventario: Códigos `P-1` a infinito, Umbrales de Stock 1 y 3, Tallas y Etiqueta "Precio").

## Completadas en la Iteración Actual
- [x] **Fase 9 (`BRA-001`, `UI-001`, `UI-002`, `REN-002`, `TAB-001`)**: Identidad oficial de Brasil y logo **"la la la — Calzados Brasileños"**, eliminación total de halos de luz, limpieza de redundancias en `BarraSuperior`/`MenuLateral`/vistas, caché en memoria `cache-datos.ts`, `TiraTallasModelo` ultraligero, paginación rápida y layout estandarizado con `Tabs` en todas las páginas. → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
- [x] **REN-001**: **Optimización de rendimiento en la primera entrada a la página (1 a 3s)** — Code-splitting de Three.js, Recharts, `driver.js`, `browser-image-compression` y modales globales en Frontend + `Promise.all` en las 9 consultas de `/panel-central/metricas` e índices `@Index()` en Backend. → `pendientes/008-optimizacion-rendimiento-carga-inicial.md`
- [x] **USU-001**: Botón directo de **Cierre de sesión** y redirección estricta a `/inicio-sesion`. → `pendientes/001-sesion-usuarios-empleados.md`
- [x] **USU-002**: Acceso en menú lateral a **Añadir usuarios** (`/administracion`) y gestión de cuentas. → `pendientes/001-sesion-usuarios-empleados.md`
- [x] **USU-003**: **Editar empleado** en Administración y en Gastos de Caja Chica + selector de empleados. → `pendientes/001-sesion-usuarios-empleados.md`
- [x] **INV-001 / INV-002**: Códigos con formato **`P-1` al infinito (sin límite)**, sugerencia automática del siguiente correlativo (`P-150`, etc.) y reemplazo global de **"Precio Venta" por "Precio"**. → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **INV-003 / INV-004 / INV-005**: Stock **Crítico a partir de 1**, óptimo **a partir de 3 en stock**, componente `TiraTallasModelo` con **pintar si no existe esa talla**, **efecto hover por talla con micro-interacción y popover** y soporte de **Tamaños** (`S-XL/Único`). → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **Fase 3 (`CAT-001`, `CAT-002`, `CAT-003`, `CAT-004`)**: Selector interactivo de **Variación de colores**, preset **Colores de Brasil**, **Extras al zapato** en Inventario y mostrador de Ventas, y exportación de **Catálogo comercial en PDF** (por modelo con stock, sin costos visibles). → `pendientes/003-colores-brasil-extras-catalogo-pdf.md`
- [x] **Fase 4 (`COM-001` a `COM-004`)**: Editar compras (`PUT /ingresos/:id` con recálculo transaccional), Añadir proveedor (catálogo persistente y creación rápida), Registrar mismo producto con otros precios (advertencia con precio nuevo) y Actualizar precios de productos no vendidos aún (unidades de talla o modelo completo vs. nuevo código `P-N`). → `pendientes/004-compras-proveedores-actualizacion-precios.md`
- [x] **Fase 5 (`REB-001`, `REB-002`)**: Registrar rebajas y liquidaciones por fechas (ej. *Air Force One* de 350 a 299 Bs con atajos *"Solo por hoy y mañana"*, 7 días, fin de semana o rango personalizado) con badge en tabla/catálogo y alerta *"Estás rebajando mucho"* con justificación automática en POS y cobro. → `pendientes/005-rebajas-liquidaciones-fechas.md`
- [x] **Fase 6 (`VEN-001`, `VEN-002`, `VEN-003`)**: Agrandar mostrador de venta (tarjetas, fotos `h-32`, fuentes, botones $\ge 44\text{px}$), Cambiar POS por "Ventas Realizadas" (menú, cabecera y vista dual Mostrador / Historial filtrable con reimpresión de tickets) y Añadir banco en cobros de ventas y gastos de transferencia. → `pendientes/006-pos-ventas-realizadas-bancos.md`
- [x] **Fase 7 (`TMP-001`)**: Guardar datos de forma temporal en formularios y carrito. → `pendientes/007-guardado-temporal-borradores.md`

## En curso / Planificada (Iteración Actual)
- Ninguna en este momento (Fases 1 a 7 completadas y verificadas con éxito).

## En cola (Siguientes Bloques de la Iteración 2026-11-03)
- Ninguna pendiente en esta iteración.
