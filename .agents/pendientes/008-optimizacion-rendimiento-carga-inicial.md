# 008 — Optimización de Rendimiento en Carga Inicial (1 a 3 Segundos)

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `REN-001`
- **Prioridad:** Crítica

## Contexto y Diagnóstico de Causas Raíz

El usuario reportó una demora de **1 a 3 segundos** en la primera entrada a la página. Tras una auditoría exhaustiva de Frontend y Backend mediante subagentes especializados, se identificaron las causas raíz exactas:

### 1. Frontend — Inflado Masivo del Bundle Raíz (`layout.js` = 12.19 MB en dev) y Dashboard (`page.js` = 9.12 MB)
- **Motor 3D WebGL (`three`) empaquetado síncronamente en el Layout Raíz:**
  - `EfectosAmbientalesSistema` (`efectos-ambientales-sistema.tsx`) importaba estáticamente `obtenerColorHexPorVariante` desde `@/lib/motor-calzado-three` (que importa `import * as THREE from "three"` en la línea 1) y `FondoCalzadoLiquido` (`fondo-calzado-liquido.tsx`), a pesar de que `mostrarSimulacionLiquida` está desactivado (`false`) por defecto en las vistas operativas.
  - `ContenedorPrincipal` (`contenedor-principal.tsx`) importaba síncronamente `VistaInicioSesion`, y `MenuLateral` (`menu-lateral.tsx`) importaba síncronamente `ModalInicioSesion`, arrastrando Three.js, shaders GLSL y geometrías 3D a todas las rutas de la aplicación (`/`, `/pos`, `/inventario`, etc.).
- **Gráficos `recharts` síncronos en el Dashboard (`app/page.tsx`):**
  - `PaginaPrincipal` importaba `BarChart`, `Bar`, `XAxis`, `YAxis`, `CartesianGrid`, `ResponsiveContainer`, `Cell`, `PieChart` y `Pie` de `recharts` de forma síncrona, bloqueando la hidratación inicial de las tarjetas de KPIs y accesos rápidos entre 500 y 800 ms.
- **Modales globales, `driver.js` y `browser-image-compression` en el chunk inicial:**
  - `BarraSuperior` importaba y montaba `ModalBusquedaRapida` de forma estática aunque estuviera cerrado.
  - `tour-interactivo.tsx` re-exportaba estáticamente `tour-dashboard.ts`, `tour-pos.ts` y `tour-inventario.ts`, incluyendo `driver.js` y `driver.css` en el bundle de arranque.
  - `app/inventario/page.tsx` y `lib/optimizacion-imagenes.ts` importaban `browser-image-compression` a nivel superior en vez de cargarlo bajo demanda al seleccionar fotografías.
- **Doble renderizado en `ProveedorAutenticacion` (`autenticacion-contexto.tsx`) y filtro GPU costoso en `HaloAmbientalCursor`:**
  - `ProveedorAutenticacion` inicializaba `usuario` y `token` síncronamente desde `localStorage` en `useState`, pero el `useEffect` de montaje volvía a ejecutar `setToken` y `setUsuario(JSON.parse(...))`, forzando un re-renderizado completo de toda la aplicación tras la hidratación.
  - `HaloAmbientalCursor` aplicaba `blur-[110px]` sobre un contenedor móvil de `480x480px` en cada evento `mousemove`, obligando al compositor gráfico a recalcular matrices de desenfoque gaussiano sobre 25 capas `backdrop-blur`.

### 2. Backend — 9 Consultas SQL Secuenciales en `/panel-central/metricas` y Falta de Índices
- **Ejecución secuencial en `PanelCentralServicio.obtenerMetricas` (`panel-central.servicio.ts`):**
  - El endpoint `GET /api/v1/panel-central/metricas` ejecutaba **9 consultas SQL independientes de forma estrictamente secuencial (`await` tras `await`)**: ventas netas, costo de lo vendido, gastos de caja chica, ventas por método de pago, resumen de inventario, producto más vendido, producto de mayor ingreso, producto con menor stock y top 5 más vendidos.
- **Consultas secuenciales en `consultarFichaProducto` y doble consulta en `/autenticacion/refrescar`:**
  - `consultarFichaProducto` ejecutaba secuencialmente la consulta de último detalle de venta y la de variantes por talla.
  - `POST /autenticacion/refrescar` consultaba dos veces la tabla `usuarios` por el mismo ID (primero en `EstrategiaJwt.validate` y luego en `AutenticacionServicio.refrescarSesion`).
- **Índices faltantes en entidades TypeORM:**
  - Columnas críticas de filtrado y ordenamiento (`activo`, `stockActual`, `totalVendido` en `Calzado`; `fechaVenta`, `formaPago`, `creadoEn` en `Venta`; `ventaId`, `calzadoId`, `codigoProducto` en `DetalleVenta`; `fechaGasto` en `GastoCajaChica`) carecían de `@Index()`.

## Tareas Ejecutadas
1. **Desacoplamiento de Three.js del Layout Raíz:**
   - Extracción de las utilidades 2D y de paleta (`obtenerColorHexPorVariante`, `CATALOGO_EDITORIAL_CALZADO`, `dibujarSiluetaCalzadoEnCanvas`) a `frontend/src/lib/paleta-tema-calzado.ts` sin dependencia de `three`.
   - Carga diferida (`next/dynamic` con `ssr: false`) de `FondoCalzadoLiquido`, `VistaInicioSesion`, `ModalInicioSesion` y `ModalBusquedaRapida`.
2. **Carga Diferida de Recharts, Tours y Compresor de Imágenes:**
   - Extracción de los gráficos del Dashboard a `frontend/src/componentes/panel-central/graficos-panel-operativo.tsx` cargados dinámicamente con `next/dynamic` (`ssr: false`) y esqueletos ligeros.
   - Conversión de `tour-interactivo.tsx` y `browser-image-compression` a importaciones dinámicas (`await import(...)`) bajo demanda.
3. **Optimización de Hidratación y GPU en Frontend:**
   - Eliminación del re-renderizado redundante en `ProveedorAutenticacion` (`autenticacion-contexto.tsx`).
   - Reemplazo del filtro `blur-[110px]` en `HaloAmbientalCursor` por un gradiente radial precalculado libre de convolución en tiempo real.
4. **Paralelización con `Promise.all` e Índices en Backend:**
   - Paralelización de las 9 consultas independientes en `PanelCentralServicio.obtenerMetricas` y de las consultas secundarias en `consultarFichaProducto` mediante `Promise.all`.
   - Eliminación de la doble consulta en `POST /autenticacion/refrescar` y adición de índices `@Index()` en `Calzado`, `Venta`, `DetalleVenta` y `GastoCajaChica`.

## Criterios de Aceptación
- El layout principal (`ContenedorPrincipal`, `BarraSuperior`, `MenuLateral`, `EfectosAmbientalesSistema`) no incluye `three`, `recharts` ni `driver.js` en el bundle síncrono inicial.
- El Dashboard (`/`), Inventario (`/inventario`) y POS (`/pos`) hidratan y muestran la interfaz principal de forma instantánea sin bloqueo del hilo principal.
- `GET /api/v1/panel-central/metricas` resuelve sus consultas a PostgreSQL en paralelo con `Promise.all`.
- Compilación limpia (`0` errores de TypeScript y build exitoso en `frontend/` y `backend/`).
