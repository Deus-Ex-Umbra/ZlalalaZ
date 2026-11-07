# 006 — Agrandar POS, Cambiar POS por Ventas Realizadas y Añadir Banco

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `VEN-001`, `VEN-002`, `VEN-003`
- **Prioridad:** Alta

## Diseño Aprobado (`/lluvia-ideas`)
- **Renombrar en menú a "Ventas Realizadas" con vista dual (Opción A aprobada):**
  - Se elimina la sigla `"POS"` en menú lateral, barra superior y traducciones, reemplazándola por **"Ventas Realizadas"**.
  - Dentro de `/pos` se ofrece un conmutador prominente entre:
    1. **Mostrador de Venta (Agrandado):** Tarjetas más grandes, fotos de mayor altura (`h-28`/`h-32`), textos legibles (`text-sm`/`text-base`), tira interactiva de tallas y botones táctiles $\ge 44\text{px}$.
    2. **Historial de Ventas Realizadas:** Tabla completa y filtrable de todas las ventas realizadas (por rango de fechas, método de pago, banco, vendedor y búsqueda por ticket/cliente/producto), con resumen de totales y botón para ver detalle y **reimprimir ticket**.
- **Añadir Banco:** Al cobrar con `QR`, `Transferencia` o `Tarjeta` en Ventas, o al pagar por `Transferencia` en Gastos, se muestra un selector de **Banco** (Banco Unión, BNB, BCP, Mercantil Santa Cruz, Banco FIE, Banco Bisa, Banco Sol) con botón rápido **"Añadir banco"** para registrar nuevas entidades bancarias.

## Tareas
1. **`backend/src/modulos/ventas/` y `backend/src/modulos/gastos/`**:
   - Añadir campo `banco` (`varchar(100)`, nullable) en `Venta` (`venta.entidad.ts`, `crear-venta.dto.ts`) y en `GastoCajaChica` (`gasto-caja-chica.entidad.ts`, `crear-gasto.dto.ts`).
   - Crear catálogo persistente o endpoint de bancos (`GET /api/v1/ventas/bancos`, `POST /api/v1/ventas/bancos`) con los bancos principales de Bolivia pre-cargados.
   - Mejorar `GET /api/v1/ventas` para soportar filtros (`fechaInicio`, `fechaFin`, `formaPago`, `banco`, `busqueda`) y devolver el listado enriquecido con detalles.
2. **`frontend/src/componentes/navegacion/menu-lateral.tsx`, `barra-superior.tsx` y `locales/{es,en,de}/*.json`**:
   - Cambiar `"POS"` / `"Punto de Venta (POS)"` por **"Ventas Realizadas"**.
3. **`frontend/src/app/pos/page.tsx` y `frontend/src/app/gastos/page.tsx`**:
   - Agrandar el diseño de las tarjetas, imágenes, fuentes y botones del mostrador de venta.
   - Construir la vista/pestaña de **Ventas Realizadas** con filtros, métricas, desglose de rebajas/promociones y reimpresión de ticket.
   - Integrar el selector de **Banco** y el modal rápido **"Añadir banco"** en cobros bancarios/QR y en gastos por transferencia.

## Criterios de Aceptación
- El menú muestra **"Ventas Realizadas"** en lugar de `"POS"`.
- El mostrador de venta tiene tarjetas, fotos y botones significativamente más grandes.
- El historial de **Ventas Realizadas** permite consultar, filtrar y reimprimir tickets de ventas pasadas.
- Los cobros por QR/Transferencia/Tarjeta y gastos por Transferencia permiten elegir un banco o añadir uno nuevo.
