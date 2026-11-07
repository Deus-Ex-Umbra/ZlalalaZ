# 003 — Variación de Colores, Colores de Brasil, Extras al Zapato y Catálogo en PDF

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `CAT-001`, `CAT-002`, `CAT-003`, `CAT-004`
- **Prioridad:** Media

## Diseño Aprobado e Implementado
- **Variación de colores + Colores de Brasil (`CAT-001` y `CAT-002`):**
  - Componente `frontend/src/componentes/inventario/selector-colores-calzado.tsx`:
    - Selector interactivo multi-color con muestras cromáticas circulares de 13 colores frecuentes de la tienda (`Negro`, `Blanco`, `Azul`, `Rojo`, `Verde`, `Amarillo`, `Gris`, `Beige`, `Café`, `Rosado`, `Celeste`, `Dorado`, `Plateado`) que alternan su inclusión en combinaciones separadas por `/` (ej. `Negro/Blanco`, `Verde/Amarillo/Azul/Blanco`).
    - Input de texto editable con sincronización bidireccional y vista previa cromática integrada.
    - Presets destacados de **"Colores de Brasil"** (cuarteto canarinho: Verde `#009739`, Amarillo `#FEDD00`, Azul `#012169`, Blanco `#FFFFFF`; dúo verde/amarillo; trío amarillo/azul/verde) aplicables con 1 clic.
    - Componente `MuestraColor` que renderiza círculos cromáticos con superposición sutil en la tabla de Inventario, tarjetas de catálogo en POS, carrito y catálogo en PDF.
- **Extras al zapato en Inventario y Ventas (`CAT-003`):**
  - **Backend (`backend/src/modulos/calzados/`):**
    - Columna opcional `extras` (`varchar(255)`, nullable) añadida en `Calzado` (`calzado.entidad.ts`), `CrearCalzadoDto` y `ActualizarCalzadoDto`.
    - `CalzadosServicio` guarda y actualiza `extras` limpios, y asegura la existencia de la columna mediante migración preventiva en `onModuleInit()`.
  - **Frontend (`frontend/src/tipos/calzado.ts` y componentes):**
    - Componente `frontend/src/componentes/inventario/selector-extras-calzado.tsx` con chips rápidos predefinidos (`Cordones extra`, `Plantillas`, `Caja especial`, `Llavero`, `Bolsa ecológica`, `Medias`, `Protector gamuza`) + input para extras personalizados.
    - Componente `BadgesExtrasCalzado` para renderizar badges en la tabla de Inventario, en las tarjetas del catálogo del POS y en el catálogo PDF.
    - En Punto de Venta (`/pos`): visualización de extras por calzado en tarjetas de catálogo y en carrito de compras, con selector de extras rápidos en mostrador (con o sin cargo en Bs) sumándose al subtotal y registrándose en el desglose de notas de venta.
- **Catálogo en PDF comercial (`CAT-004`):**
  - Componente `frontend/src/componentes/inventario/modal-catalogo-pdf.tsx` integrado en `/inventario` mediante el botón **"Catálogo en PDF"** (icono `FileDown`).
  - Agrupa calzados con `stockActual > 0` por **Modelo** (`nombreProducto` + `categoria`), mostrando:
    - Cabecera corporativa: **"LA, LA, LA — Catálogo de Calzado & Moda"** con fecha de emisión en formato boliviano.
    - Ficha de modelo con foto en miniatura, código representativo (`P-N`), nombre y categoría, muestras cromáticas de colores disponibles, tira de tallas con existencias disponibles, badges de extras incluidos y **Precio (Bs)** comercial.
    - **Protección estricta de datos de negocio:** El precio de compra, costos y márgenes internos quedan **100% ocultos** y nunca se exponen al cliente.
    - Estilos de impresión `@media print` para generar un documento limpio A4/Carta mediante `window.print()`.

## Criterios de Aceptación Verificados
- [x] El alta/edición de calzado cuenta con selector interactivo de variaciones de color y botón rápido **Colores de Brasil** (`CAT-001`, `CAT-002`).
- [x] Los zapatos tienen campo y selector de **extras** en Inventario y son visualizables y seleccionables en mostrador en Ventas (`CAT-003`).
- [x] El botón **Catálogo en PDF** genera la vista comercial por modelo sin exponer precios de compra (`CAT-004`).
- [x] Claves de traducción incorporadas en español, inglés y alemán en `Inventario.json` y `PuntoVenta.json`.
- [x] Compilaciones exitosas con 0 errores: `npm run build` en backend y `npm run build` en frontend.
