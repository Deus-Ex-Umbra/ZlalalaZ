---
name: consulta-hoja-calculo
description: Lee la hoja de cálculo original de la tienda (Google Sheets "Inventario_Tienda_Calzado_ LA,LA,LA") para verificar datos, preparar semillas o validar importaciones.
---

# Consulta de la Hoja de Cálculo Original

La hoja no permite `export?format=csv` (responde 401), pero **sí** responde al endpoint de visualización `gviz`, que devuelve CSV por pestaña.

## Identificadores
- ID del documento: `1iNZzgtX59DzaCJ1fvvDzIYnBu_xVrx7mC-AcKCe35OQ`
- URL base: `https://docs.google.com/spreadsheets/d/1iNZzgtX59DzaCJ1fvvDzIYnBu_xVrx7mC-AcKCe35OQ/gviz/tq?tqx=out:csv&gid=<GID>`

| Pestaña | GID | Módulo |
| :--- | :--- | :--- |
| Inventario | `906814319` | `calzados` |
| Ingreso Mercancia | `1286982929` | `ingresos` |
| Ventas | `185648359` | `ventas` |
| Gastos Extra | `257809406` | `gastos` |
| Panel Central | `2141361538` | `panel-central` |

## Procedimiento
1. Usa `read_url_content` con la URL base y el GID de la pestaña.
2. El resultado se guarda en un archivo; léelo con `view_file`. La primera fila contiene los encabezados (la primera celda incluye el título de la pestaña, ej. `REGISTRO DE VENTAS Fecha de Venta`).
3. Ignora filas vacías: Inventario trae plantillas `P150`–`P476` sin datos y Ventas/Ingresos traen filas con `Bs0,00` o `-`.
4. Formatos: montos `Bs1.234,00` (punto de miles, coma decimal); fechas `dd/MM/yyyy` con algunas inconsistentes (`7/7/26`, `6/06/2026`).

## Advertencias de Calidad de Datos (verificado 2026-10-03)
- Nombres inconsistentes: `NIke`, espacios finales (`Nike Air Force One `, `Vans `, `Nike Zoom X `), `Adidas Zoom X` probablemente debe ser `Nike Zoom X`.
- Stock negativo: `P060` y `P068` con `-1` (se vendió más de lo que había).
- Ingreso `02/05/2026` con `P001` marcado "ID no existe" y precios `Bs0,00`.
- Productos sin talla: `P078`–`P081` (Mochilas Pequeñas).
- Fórmulas erróneas del Panel: ver `rules/03-dominio-negocio.md`.

## Uso
- Nunca escribir en la hoja; es solo lectura y referencia histórica.
- Para importación masiva al sistema, usar el importador del backend (ver `pendientes/002-importacion-datos-hoja.md`), no copiar valores a mano.
