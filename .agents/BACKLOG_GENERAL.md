# BACKLOG GENERAL DEL SISTEMA ZLaLaLaZ

Fuente del negocio: hoja `Inventario_Tienda_Calzado_ LA,LA,LA` (5 pestañas: Inventario, Ingreso Mercancia, Ventas, Gastos Extra, Panel Central).
Estado auditado contra el código el **2026-10-04**. Solo se marca `[x]` lo verificado en el repositorio.
Cada tarea abierta referencia su requerimiento en `pendientes/`.

---

## Fase 0 — Infraestructura y Configuración Base
- [x] **INF-001**: Monorepo con workspaces y submódulos `backend/` y `frontend/`, `.gitignore`, `.env.example`.
- [x] **INF-002**: Motor PostgreSQL portable local (`pgsql/`).
- [x] **INF-003**: Reglas y skills de Antigravity (`AGENTS.md`, `rules/`, `skills/`).
- [x] **INF-004**: Registro Central de Errores (`backend/errores.md`).
- [x] **INF-005**: Reestructuración de `.agents/` según la hoja de cálculo: regla de dominio, skill `consulta-hoja-calculo`, carpeta `pendientes/`, retiro de reglas/skills ajenas al stack.

## Fase 1 — Modelado de Datos y Backend Base (NestJS + TypeORM)
- [x] **BE-001**: Arquitectura modular NestJS con TypeORM / PostgreSQL.
- [x] **BE-002**: Entidad y DTOs de Calzado (código, nombre, categoría, talla, color, precios, stock).
- [x] **BE-003**: Entidad y DTOs de Ingreso de Mercancía.
- [x] **BE-004**: Entidades y DTOs de Venta y Detalle de Venta (Efectivo/QR/Tarjeta/Transferencia, descuentos).
- [x] **BE-005**: Entidad y DTOs de Gastos de Caja Chica.
- [x] **BE-006**: Autenticación JWT con roles `ADMINISTRACION` / `VENTAS` y usuarios semilla creados en `onModuleInit`.
- [x] **DAT-001**: Semillas completas en `semillas.sql` con los 149 productos, 20 ventas reales y 5 gastos de la hoja. → `pendientes/002-importacion-datos-hoja.md`
- [x] **DAT-002**: Importador idempotente desde la hoja (`npm run importar:hoja` vía endpoint `gviz` CSV) con reporte de inconsistencias en `reporte-importacion.md`. → `pendientes/002-importacion-datos-hoja.md`
- [x] **DAT-003**: Normalización del catálogo: limpiar nombres, separar marca/modelo, soportar accesorios sin talla (Mochilas) con `normalizacion-catalogo.ts`. → `pendientes/005-normalizacion-catalogo.md`
- [x] **DAT-004**: Eliminar los hashes bcrypt de ejemplo de `semillas.sql` (creados automáticamente por el servicio de autenticación). → `pendientes/002-importacion-datos-hoja.md`

## Fase 2 — Reglas de Negocio y Correcciones Backend
- [x] **NEG-001**: Corregir fórmula de ganancia: resta el costo de **lo vendido** (costo histórico guardado en cada línea) y separa ganancia bruta y ganancia neta. → `pendientes/004-correccion-metricas-panel.md`
- [x] **NEG-002**: Completar destacados del panel: cálculo de `productoMayorIngreso` y conteo de ventas por las 4 formas de pago (incluyendo `Transferencia`). → `pendientes/004-correccion-metricas-panel.md`
- [x] **NEG-003**: Guardar el costo unitario histórico en cada detalle de venta (`costo_unitario`). → `pendientes/004-correccion-metricas-panel.md`
- [x] **NEG-004**: Costo promedio ponderado en ingresos (`IngresosServicio`) y validación de precios de compra. → `pendientes/006-ingresos-costo-promedio.md`
- [x] **NEG-005**: Descuento con motivo obligatorio (`CLIENTE_FRECUENTE`, `PROMOCION`, `OTRO`), nota explicativa requerida para `OTRO` y módulo de Clientes (`/clientes`). → `pendientes/007-clientes-frecuentes-descuentos.md`
- [x] **NEG-006**: Correlativo de ticket con secuencia PostgreSQL (`secuencia_ticket`) atómica para evitar colisiones. → `pendientes/008-ticket-imprimible.md`
- [x] **NEG-007**: `formaPago` de gastos como enum (`Efectivo`, `Transferencia`) en entidad, DTO y controlador. → `pendientes/004-correccion-metricas-panel.md`

## Fase 3 — Almacenamiento "Presupuesto Cero" (Cloudflare R2)
- [x] **ALM-001**: Servicio de almacenamiento con `@aws-sdk/client-s3` para Cloudflare R2 ($0 egress).
- [x] **ALM-002**: Fallback automático a almacenamiento local (`uploads/`) si faltan credenciales R2.
- [ ] **ALM-002b**: Fallback a Supabase Storage (opcional para infraestructura secundaria).
- [x] **ALM-003**: Compresión WebP en cliente (`frontend/src/lib/optimizacion-imagenes.ts`).
- [x] **ALM-004**: `remotePatterns` de `<Image>` en `next.config.mjs`.
- [x] **ALM-005**: Aproximador dinámico de espacio en la nube (MB) según cantidad de fotos y nivel de compresión WebP (0 al 5) con `WidgetAlmacenamiento` y endpoint `GET /almacenamiento/uso`. → `pendientes/009-aproximador-espacio-nube.md`

## Fase 4 — Frontend: Integración con la API
- [x] **FE-000**: Maquetas UI de Inventario, POS, Ingresos, Gastos y Panel Central con ShadCN UI.
- [x] **FE-001**: Cliente API tipado con JWT y manejo de errores estándar + interfaces completas en `tipos/`. → `pendientes/003-integracion-frontend-api.md`
- [x] **FE-002**: Inventario conectado (listado, filtros por stock y tallas, modal de alta/edición con compresión WebP, modal de nube y alertas de stock). → `pendientes/003-integracion-frontend-api.md`
- [x] **FE-003**: POS conectado (búsqueda por código/nombre, selector táctil de tallas, carrito, cobro, cambio, descuento con motivo obligatorio, autocompletado de clientes frecuentes). → `pendientes/003-integracion-frontend-api.md`
- [x] **FE-004**: Ingresos y Gastos conectados con tablas ordenables, paginadas, métricas en vivo y modal de registro validado. → `pendientes/003-integracion-frontend-api.md`
- [x] **FE-005**: Panel Central conectado (fórmulas oficiales de ganancia bruta/neta, filtros por fecha, destacados y buscador instantáneo de fichas). → `pendientes/003-integracion-frontend-api.md`
- [x] **FE-006**: Cero `any` y cero constantes de datos quemados en todo `frontend/src`. → `pendientes/003-integracion-frontend-api.md`

## Fase 5 — Punto de Venta: Ticket
- [x] **POS-004**: Ticket imprimible desde el navegador (`window.print()`, soporte 58 mm y 80 mm para impresoras térmicas con componente `TicketVenta`). → `pendientes/008-ticket-imprimible.md`

## Fase 6 — Tours Interactivos con `driver.js`
- [x] **TR-001**: Componente `tour-interactivo.tsx` con `driver.js`.
- [x] **TR-002**: Tours interactivos guiados en español para bienvenida, POS, Inventario y Gastos.

## Fase 7 — Móvil (Web Responsive + PWA)
- [x] **MOB-001**: Auditoría responsive (<768px) en todas las pantallas con barra de navegación inferior móvil y botones táctiles.
- [x] **MOB-002**: PWA instalable (manifest web nativo en `app/manifest.ts`, iconos, Service Worker en `sw.js` y componente `RegistradorServiceWorker`). → `pendientes/001-pwa-soporte-offline-pos.md`
- [x] **MOB-003**: Ventas sin conexión con cola local en IndexedDB (`cola-ventas-offline.ts`), sincronización automática al recuperar la red y endpoint por lotes `POST /api/v1/ventas/sincronizar`. → `pendientes/001-pwa-soporte-offline-pos.md`
