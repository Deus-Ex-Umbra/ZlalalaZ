# 004 — Corrección de Métricas del Panel Central

- **Estado:** Pendiente
- **Backlog:** NEG-001, NEG-002, NEG-003, NEG-007
- **Prioridad:** Alta

## Contexto
En `backend/src/modulos/panel-central/panel-central.servicio.ts`:
- `gananciaBrutaEstimadaBs = totalVentas − Σ(totalIngresado × precioCompra) − gastos`: resta el costo de todo lo ingresado (no de lo vendido) e ignora el stock inicial.
- `productoMayorIngreso` está en la interfaz pero nunca se calcula.
- No hay conteo de ventas por `Transferencia`.
- `DetalleVenta` no guarda el costo unitario, así que no se puede calcular el costo histórico de lo vendido.
- `GastoCajaChica.formaPago` es texto libre.

La hoja original también estaba mal (ganancia = ventas − gastos; 476 "productos distintos"). Fórmulas oficiales en `rules/03-dominio-negocio.md` §5.

## Tareas
1. Añadir `costoUnitario` (decimal) a `DetalleVenta`, llenado con `calzado.precioCompra` al vender.
2. Métricas: `ventasNetasBs`, `costoVendidoBs`, `gananciaBrutaBs`, `gananciaNetaBs`, `costoMercanciaIngresadaBs` (informativo).
3. Calcular `productoMayorIngreso` (Σ total de línea agrupado por código) y conteo por cada `MetodoPago`.
4. Filtro opcional por rango de fechas (`ERR-PAN-001` si inicio > fin).
5. Enum `FormaPagoGasto` en gastos con migración de datos existentes.

## Criterios de Aceptación
- Con los datos importados de la hoja, la ganancia bruta = ventas netas − Σ(cantidad × costo) verificable a mano en una muestra.
- Los cuatro métodos de pago aparecen en la respuesta aunque su conteo sea 0.
