# 005 — Normalización del Catálogo

- **Estado:** Pendiente (requiere decisión de diseño con `lluvia-ideas`)
- **Backlog:** DAT-003
- **Prioridad:** Media

## Contexto
En la hoja cada fila es un SKU (modelo + edición + talla + color). Problemas detectados:
- Nombres inconsistentes: `NIke Air Force One`, `Nike Air Force One ` (espacio final), `Vans `, `Nike Zoom X `, `Adidas Zoom X` (probablemente Nike), `Adidas` sin modelo (P051–P055), `Rosada/Celeste`.
- La columna "Categoría" en realidad es la edición/colorway (`Drake`, `Panda`, `Messi`).
- Accesorios sin talla (`Mochilas Pequeñas`, P078–P081), pero `Calzado.talla` es obligatorio.
- No existe campo `marca`, necesario para filtrar (Nike, Adidas, Puma, Vans, Jordan).

## Opciones a Decidir
- **A. Fila plana mejorada:** mantener `calzados` como SKU, agregar `marca`, `tipoProducto` (`CALZADO`/`ACCESORIO`) y `talla` opcional.
- **B. Producto + Variante:** tabla `productos` (marca, modelo, edición, color, precios, foto) y `variantes` (talla, código `P###`, stock). Menos duplicación, migración más grande.

## Tareas (tras decidir)
1. Migración TypeORM y ajuste de DTOs/servicios.
2. Reglas de limpieza en el importador (pendiente 002): `trim`, capitalización, extracción de marca.
3. Filtros por marca en catálogo y POS.

## Criterios de Aceptación
- Las mochilas se registran y venden sin talla.
- No existen dos productos que difieran solo por mayúsculas o espacios en el nombre.
