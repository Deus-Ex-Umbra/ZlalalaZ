# 002 — Inventario: Códigos P-1 a Infinito, Etiqueta "Precio", Umbrales de Stock (1 y 3), Tallas y Tamaños

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `INV-001`, `INV-002`, `INV-003`, `INV-004`, `INV-005`
- **Prioridad:** Alta

## Diseño Aprobado e Implementado
- **Unificación de códigos a `P-1`..`P-N` al infinito (sin límite superior):**
  - Función utilitaria `normalizarCodigoProducto(codigo)` en `backend/src/comun/utilidades/normalizacion-catalogo.ts` (normaliza `P001`, `p1`, `P-001` a `P-1`, etc.).
  - Migración automática en base de datos (`OnModuleInit`) de códigos legados `P001`..`P999` a `P-1`..`P-999` actualizando `calzados`, `ingresos_mercancia` y `detalles_venta`.
  - Endpoint `@Get("siguiente-codigo")` en `calzados.controlador.ts` (declarado antes de `:id`) y `CalzadosServicio.obtenerSiguienteCodigo()` que escanea códigos correlativos sin límite superior (`P-1`, `P-150` hasta `P-N`).
  - Búsqueda tolerante en `calzados.servicio.ts` (`obtenerPorCodigo` y `buscarPorCodigo`) y `panel-central.servicio.ts` (`consultarFichaProducto`).
  - Formulario de inventario prellena automáticamente el siguiente código sugerido.
  - Semillas `semillas.sql` e `importar-hoja.ts` actualizados al formato oficial `P-1`..`P-149`.
- **Reemplazar "Precio Venta" por "Precio" (`INV-002`):**
  - Reemplazadas todas las etiquetas y textos visibles en `inventario/page.tsx`, `ingresos/page.tsx`, `pos/page.tsx`, `panel-central/page.tsx` y `modal-busqueda-rapida.tsx`.
  - Archivos i18n (`es`, `en`, `de`) actualizados (`Inventario.json`, `Ingresos.json`, `Pos/PuntoVenta.json`, `PanelCentral.json`).
- **Umbrales de stock (`INV-003`):**
  - `alertaStockMinimo` por defecto a `1` en entidad `Calzado`.
  - `stockActual <= 1` para stock crítico en `obtenerStockCritico()`.
  - En `lib/inventario.ts` y vistas:
    - `< 0` = inconsistente
    - `0` = agotado
    - `1` = crítico (rojo/ámbar intenso)
    - `2` = stock bajo (ámbar)
    - `>= 3` = disponible / en stock óptimo (esmeralda).
- **Tira interactiva de tallas y escala de tamaños (`INV-004` e `INV-005`):**
  - Componente reutilizable `frontend/src/componentes/inventario/tira-tallas-modelo.tsx` con soporte para escala de calzado (`34`–`43`) y escala de tamaños (`S`, `M`, `L`, `XL`, `Pequeño`, `Mediano`, `Grande`, `Único`).
  - Tallas inexistentes o sin stock pintadas con estilo atenuado, tachado (`line-through`) y borde punteado (`border-dashed`).
  - Micro-interacción hover (`scale-110 -translate-y-0.5`) con tooltip detallado que muestra código (`P-N`), stock exacto (`N pares`) y precio en Bs.
  - Integrado en columna Tallas de Inventario, tarjetas/filas de POS y ficha de consulta en Panel Central.
  - Modal de nuevo calzado/ingresos permite seleccionar tanto tallas numéricas como tamaños.

## Criterios de Aceptación Verificados
- [x] Todos los códigos siguen el formato `P-1`..`P-N` (al infinito sin límite superior) y el formulario de nuevo calzado sugiere automáticamente el siguiente correlativo `P-150`.
- [x] Todas las vistas muestran `"Precio"` en lugar de `"Precio Venta"`.
- [x] El stock se marca **Crítico en 1** y **En Stock óptimo desde 3**.
- [x] La tira de tallas pinta claramente las tallas que no existen y muestra información detallada al hacer `hover`.
- [x] Builds de frontend (`npm run build`) y backend (`npm run build`) completados con 0 errores.
