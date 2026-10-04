# Reglas de Dominio del Negocio (derivadas de la hoja de cálculo)

Fuente: Google Sheet `Inventario_Tienda_Calzado_ LA,LA,LA` (ver skill `consulta-hoja-calculo`). Moneda: **Bolivianos (Bs)**.

## 1. Inventario (pestaña "Inventario" → módulo `calzados`)
| Columna hoja | Campo sistema | Notas |
| :--- | :--- | :--- |
| ID Producto | `codigoProducto` | Formato `P###`. Cada ID es un SKU único = modelo + edición + talla + color. |
| Nombre del Producto | `nombreProducto` | Marca + modelo (ej. `Nike Air Force One`, `Adidas Samba`). |
| Categoría | `categoria` | En la práctica es la **edición/colorway** (`Lifestyle`, `Drake`, `Panda`, `Messi`, `Low 84`). |
| Talla / Variante | `talla` | Rango 34–43. **Vacía en accesorios** (ej. `Mochilas Pequeñas`). |
| Color | `color` | Combinaciones con `/` (`Negro/Blanco`). |
| Precio de Compra / Venta | `precioCompra` / `precioVenta` | Decimales en Bs. |
| Stock Inicial, Total Ingresado, Total Vendido | `stockInicial`, `totalIngresado`, `totalVendido` | |
| Stock Actual | `stockActual` | `stockInicial + totalIngresado − totalVendido`. |
| Foto | `fotoUrl` | WebP en Cloudflare R2. |

- Hay **149 productos reales** (P001–P149). Las filas P150–P476 de la hoja son plantillas vacías y NO deben importarse.
- El stock **nunca** puede ser negativo: una venta sin stock suficiente se rechaza con `ERR-CALZ-003`.

## 2. Ingreso de Mercancía (pestaña "Ingreso Mercancia" → módulo `ingresos`)
- Campos: fecha, ID producto, cantidad (pares/unidades), proveedor, precio de compra unitario, precio de venta unitario, talla.
- Un ingreso solo puede referenciar un ID existente (`ERR-ING-003`); jamás registrar con precio 0 ni con nombre "ID no existe".
- Suma `cantidad` a `totalIngresado` y `stockActual` en la misma transacción.

## 3. Ventas (pestaña "Ventas" → módulo `ventas`)
- Campos: fecha, ID producto, nombre del cliente, cantidad, precio unitario, forma de pago, descuento (Bs), notas, talla.
- Formas de pago: `Efectivo`, `QR`, `Tarjeta`, `Transferencia`.
- **Total de línea = cantidad × precio unitario − descuento.** (La hoja original NO restaba el descuento; es un error que no se replica.)
- El descuento debe ir acompañado de una nota con el motivo (en la hoja: "cliente frecuente", "cliente consecuente", "cliente antiguo").
- El descuento no puede superar el subtotal (`ERR-VENT-005`).

## 4. Gastos de Caja Chica (pestaña "Gastos Extra" → módulo `gastos`)
- Campos: fecha, nombre del empleado, concepto/motivo, monto, forma de pago (`Efectivo`, `Transferencia`), autorizado por, notas.
- Monto > 0, empleado y autorizador obligatorios (`ERR-GAST-001..003`).

## 5. Panel Central (pestaña "Panel Central" → módulo `panel-central`)
- **Buscador por ID:** nombre, categoría, talla, color, precios, stock actual, total ingresado, total vendido, ingresos generados, costo total comprado, utilidad estimada, última fecha de venta y foto.
- **Indicadores:** total de ventas (Bs), costo de mercancía ingresada, total gastos de caja chica, ganancia, N° de productos distintos, unidades en stock / vendidas / ingresadas, N° de transacciones de venta, N° de registros de gastos.
- **Destacados:** producto más vendido (unid.), producto con mayor ingreso (Bs), producto con menor stock, conteo de ventas por **cada** forma de pago.

### Fórmulas oficiales (corrigen errores de la hoja)
- **Ventas netas** = Σ total de línea (con descuento aplicado).
- **Costo de lo vendido** = Σ (cantidad vendida × precio de compra vigente al momento de la venta).
- **Ganancia bruta** = ventas netas − costo de lo vendido.
- **Ganancia neta** = ganancia bruta − gastos de caja chica.
- **N° de productos distintos** = productos activos con datos (no filas vacías).

> La hoja calculaba "Ganancia Bruta" como ventas − gastos (ignorando el costo), contaba 476 productos (incluyendo filas vacías) y etiquetaba costos con `$`. No replicar.
