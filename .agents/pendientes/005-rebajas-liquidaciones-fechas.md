# 005 — Rebajas, Liquidaciones por Rango de Fechas y Justificación Automática (Audio del Cliente)

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `REB-001`, `REB-002`
- **Prioridad:** Alta

## Diseño Aprobado (`/lluvia-ideas`)
- **Programación de Liquidaciones y Rebajas por Fechas:** En `/inventario` (y desde `/pos`) se puede programar una rebaja temporal sobre un calzado o sobre todas las tallas de un modelo (ej. *Nike Air Force One* de `Bs 350` a `Bs 299`), eligiendo el atajo **"Solo por hoy y mañana"** o un rango de fechas (`promocionFechaInicio` a `promocionFechaFin`) y el motivo (`LIQUIDACION`, `CAMBIO_MERCADERIA`, `ACTUALIZACION`, `PROMOCION`).
- **Alerta "Estás rebajando mucho" + Justificación Automática (Opción A aprobada):**
  - En el mostrador de venta, cuando el descuento supera el **15% del precio**, **Bs 30** o se acerca/baja del **costo de compra**, se activa el aviso **"Estás rebajando mucho"**.
  - Si el producto tiene una **liquidación/promoción activa en la fecha actual**, el sistema aplica automáticamente el precio de liquidación (ej. `Bs 299`) y justifica de forma automática la alerta mostrando y guardando en la venta: *"En promoción/liquidación del [Fecha Inicio] al [Fecha Fin] — Motivo: [Liquidación / Cambio de mercadería] (De Bs 350 a Bs 299)"*.
  - Si no tenía promoción previa programada, la alerta exige seleccionar el motivo de la rebaja antes de confirmar el cobro.

## Tareas
1. **`backend/src/modulos/calzados/`**:
   - Agregar campos en `Calzado`: `precioPromocion` (`decimal(10,2)`, nullable), `promocionFechaInicio` (`date`, nullable), `promocionFechaFin` (`date`, nullable), `promocionMotivo` (`varchar(100)`, nullable).
   - Crear endpoint `PUT /api/v1/calzados/promocion-modelo` para registrar una rebaja/liquidación en un SKU o en todas las tallas de un mismo modelo.
2. **`frontend/src/app/inventario/page.tsx`**:
   - Añadir botón/modal **"Registrar Rebaja / Liquidación"** con opción rápida **"Solo por hoy y mañana"**, selector de fechas y motivo (`Liquidación`, `Cambio de mercadería`, `Actualización`), mostrando badge de oferta activa en la tabla.
3. **`frontend/src/app/pos/page.tsx` y `backend/src/modulos/ventas/ventas.servicio.ts`**:
   - Detectar si el calzado tiene una promoción vigente en la fecha actual (`hoy >= promocionFechaInicio && hoy <= promocionFechaFin`), aplicando el descuento automáticamente y prellenando la justificación.
   - Mostrar el aviso **"Estás rebajando mucho"** cuando la rebaja supere el umbral (>15%, >Bs 30 o bajo costo), exhibiendo la justificación automática de la promoción por fecha o solicitando el motivo obligatorio.

## Criterios de Aceptación
- [x] Se puede poner cualquier modelo (ej. *Air Force One*) en liquidación de 350 a 299 Bs por "hoy y mañana", fin de semana, 7 días o entre dos fechas.
- [x] Al vender con rebaja alta aparece el aviso **"Estás rebajando mucho"** y, si está en fecha de promoción, queda justificado automáticamente con el motivo y las fechas de liquidación.
- [x] Si no tiene promoción previa programada, exige motivo obligatorio (`Liquidación`, `Cambio de mercadería`, `Actualización`, `Cliente frecuente`, `Otro`) y justificación.
- [x] Visualización con precio tachado, precio destacado y badges de liquidación en Inventario, POS y Catálogo en PDF.
