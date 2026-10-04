# 006 — Ingresos: Costo Promedio y Proveedores

- **Estado:** Pendiente
- **Backlog:** NEG-004
- **Prioridad:** Media

## Contexto
`ingresos.servicio.ts` sobrescribe `calzado.precioCompra` con el precio del último ingreso; la regla de backend pedía costo promedio. El proveedor es texto libre con valor por defecto `Distribuidora Calzado SRL`.

## Tareas
1. Costo promedio ponderado: `nuevoCosto = (stockActual × costoActual + cantidad × costoIngreso) / (stockActual + cantidad)`.
2. Entidad `Proveedor` (nombre, contacto, notas) y relación desde `IngresoMercancia`; selector con alta rápida en el frontend.
3. Validar `precioCompraUnitario > 0` (`ERR-CALZ-004`) y cantidad entera > 0 (`ERR-ING-002`).
4. Permitir ingresar varias tallas de un mismo modelo en un solo registro (la hoja tenía columna "Tallas").

## Criterios de Aceptación
- Ingresar 2 pares a Bs 160 sobre 2 pares a Bs 150 deja el costo en Bs 155.
- No se puede registrar un ingreso con precio 0.
