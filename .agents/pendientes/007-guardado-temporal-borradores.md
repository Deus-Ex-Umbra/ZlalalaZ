# 007 — Guardar Datos de Forma Temporal (Borradores en Formularios y Carrito)

- **Fecha:** 2026-11-03
- **Estado:** Completado
- **Backlog:** `TMP-001`
- **Prioridad:** Media

## Contexto por Página
- **Transversal (`/pos`, `/inventario`, `/ingresos`, `/gastos`):**
  - Actualmente todos los formularios y el carrito de venta mantienen su estado únicamente en memoria de React (`useState`). Si el usuario recarga el navegador, cierra un modal por error o cambia de ruta mientras está registrando una compra, un calzado nuevo, un gasto o armando una venta, pierde todos los datos digitados.

## Tareas
1. [x] Crear un hook reutilizable `useBorradorTemporal<T>(clave: string, valorInicial: T)` en `frontend/src/hooks/use-borrador-temporal.ts` sincronizado con `localStorage` bajo prefijo `lalala_borrador_` y seguro ante SSR.
2. [x] Crear componente de retroalimentación visual `IndicadorBorradorTemporal` en `frontend/src/componentes/ui/indicador-borrador-temporal.tsx` con soporte i18n (`Comun.json`), botón de limpieza inmediata y badge informativo.
3. [x] Integrar el guardado temporal en:
   - **Ventas Realizadas (`/pos`):** Carrito actual (`carrito`), cliente (`nombreCliente`, `clienteSeleccionado`), método de pago (`metodoPago`), banco (`bancoSeleccionado`), descuentos (`descuentoGeneral`, `motivoDescuento`) y notas (`notasVenta`). Borrador en `lalala_borrador_pos_orden`. Limpieza automática al confirmar cobro o al vaciar orden.
   - **Inventario (`/inventario`):** Formulario de creación de nuevo calzado (`nombreProducto`, `marca`, `categoria`, `talla`, `color`, `precioCompra`, `precioVenta`, `stockInicial`, `alertaStockMinimo`, `extras`). Borrador en `lalala_borrador_nuevo_calzado`. Limpieza automática al guardar exitosamente.
   - **Ingresos / Compras (`/ingresos`):** Formulario de registro de nueva compra (`fechaIngreso`, `codigoProducto`, `talla`, `cantidad`, `proveedor`, `precioCompraUnitario`, `precioVentaUnitario`, `notas`, `modoActualizacionPrecio`). Borrador en `lalala_borrador_nuevo_ingreso`. Limpieza automática al registrar compra.
   - **Gastos de Caja Chica (`/gastos`):** Formulario de registro de nuevo gasto (`fechaGasto`, `nombreEmpleado`, `conceptoMotivo`, `monto`, `formaPago`, `banco`, `autorizadoPor`, `notas`). Borrador en `lalala_borrador_nuevo_gasto`. Limpieza automática al registrar gasto.
4. [x] Botón "Limpiar borrador" disponible en el encabezado del carrito POS y en los modales de creación.
5. [x] Verificación de compilación limpia: `npm run build` en `backend/` y `frontend/` con 0 errores.

## Criterios de Aceptación
- [x] Si se recarga la página o se cierra un modal sin guardar en Inventario, Compras, Gastos o Ventas, los datos ingresados se conservan temporalmente y se restauran al volver a abrir.
- [x] Al confirmar y guardar la operación con éxito, el borrador temporal se limpia automáticamente.
