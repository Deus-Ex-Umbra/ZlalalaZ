# BACKLOG GENERAL DEL SISTEMA LaLaLa (Ciclo de Requerimientos 2026-11-03)

- **Fecha de creación del backlog:** `2026-11-03`
- **Fuente de requerimientos:** Notas de levantamiento por WhatsApp (25 puntos) + Audio del cliente sobre liquidaciones/rebajas temporales por rango de fechas.
- **Estado:** Backlogs anteriores removidos. Todas las tareas de este nuevo ciclo parten en estado `[ ]` tras auditar el código actual de `frontend/src/` y `backend/src/`.

---

## Contexto Actual del Software por Página (Auditoría 2026-11-03)

### 1. Navegación Global y Autenticación (`menu-lateral.tsx`, `barra-superior.tsx`, `/inicio-sesion`, `/administracion`)
- **Estado en código:**
  - `autenticacion-contexto.tsx` mantiene un usuario administrador por defecto en desarrollo (`USUARIO_ADMIN_DEFAULT`) y el botón de cerrar sesión está oculto dentro de un menú desplegable (`DropdownMenu`), impidiendo un cierre de sesión directo y estricto.
  - La página `/administracion` (CRUD de usuarios con roles `ADMINISTRADOR` y `VENDEDOR`) ya existe en código, pero **no figura en el menú lateral** (`menu-lateral.tsx`).
  - La ruta `/pos` se muestra como `"POS"` / `"Punto de Venta (POS)"` y no existe una vista o pestaña dedicada a consultar el historial de **Ventas Realizadas**.

### 2. Página de Inventario (`/inventario` → `frontend/src/app/inventario/page.tsx` y `backend/src/modulos/calzados/`)
- **Estado en código:**
  - **Códigos:** Usa códigos antiguos `P001`..`P149` y placeholder `"Ej: DEP-01"`; no tiene autogenerador ni validación para el formato con guion `P-1` hasta `P-100000`.
  - **Etiquetas de precio:** Muestra `"Precio de Venta (Bs)"` y `"P. Venta"` en lugar de `"Precio"`.
  - **Umbrales de stock:** `lib/inventario.ts` y `calzado.entidad.ts` tienen `alertaStockMinimo = 2` fijo (crítico $\le 2$). No aplica la regla solicitada: **Crítico = 1** (`stockActual === 1`), **Bajo = 2**, **En stock óptimo $\ge 3$**.
  - **Tallas y Tamaños:** Cada fila muestra una sola talla estática (`TALLAS_ESTANDAR = 34..43`). No pinta las tallas inexistentes/agotadas de un modelo, no tiene efecto `hover` por talla con detalle de stock, ni soporta selector de **Tamaños** para accesorios o escalas especiales.
  - **Colores y Extras:** El campo `color` es un `input` de texto simple sin selector de variaciones de colores, sin preset de **Colores de Brasil** (Verde/Amarillo/Azul/Blanco), y la entidad `Calzado` carece de campo para **extras del zapato** (cordones, caja, llavero, plantillas).
  - **Catálogo en PDF:** No existe botón ni generador de catálogo en PDF para clientes.

### 3. Página de Ingresos / Compras (`/ingresos` → `frontend/src/app/ingresos/page.tsx` y `backend/src/modulos/ingresos/`)
- **Estado en código:**
  - **Edición de compras:** Solo existen `GET /ingresos` y `POST /ingresos`. No hay botón de editar ni endpoint `PUT/PATCH /ingresos/:id` que recalcule el stock y el costo promedio ponderado.
  - **Proveedores:** El campo `proveedor` es un texto libre con valor por defecto `"Distribuidora Calzado SRL"`, sin catálogo ni opción de **Añadir proveedor**.
  - **Reingreso con nuevos precios:** Cuando el mismo producto ingresa nuevamente con otro precio de compra o venta, `IngresosServicio` sobreescribe `precioVenta` sin mostrar **advertencia de precio nuevo** ni consultar si se desea **actualizar el precio de los productos no vendidos aún** (`stockActual > 0`).

### 4. Página de Punto de Venta y Ventas Realizadas (`/pos` → `frontend/src/app/pos/page.tsx` y `backend/src/modulos/ventas/`)
- **Estado en código:**
  - **Dimensiones del POS:** Las tarjetas del catálogo tienen imágenes pequeñas (`h-16`), textos `text-[10px]`/`text-xs` y botones de `h-6 w-6`. Requiere agrandarse para operación cómoda en mostrador.
  - **Ventas Realizadas:** `servicios/ventas.ts` define `obtenerVentas()`, pero ninguna pantalla la consume y `GET /ventas` en el backend no filtra por fechas, método de pago ni vendedor.
  - **Bancos:** Los métodos de pago son `Efectivo`, `QR`, `Tarjeta` y `Transferencia`, pero no permiten elegir ni añadir el **Banco** receptor.
  - **Rebajas y Liquidaciones por Fechas (Audio del cliente):** No existe programación de precios de liquidación por rango de fechas (ej. *Air Force One de 350 a 299 Bs solo por hoy y mañana o de fecha A a fecha B*), ni alerta de `"Estás rebajando mucho"` vinculada automáticamente a la justificación de promoción vigente.

### 5. Página de Gastos de Caja Chica (`/gastos` → `frontend/src/app/gastos/page.tsx` y `backend/src/modulos/gastos/`)
- **Estado en código:**
  - `nombreEmpleado` es un campo de texto libre y no existe opción para editar un gasto o cambiar el empleado asignado, ni selector de banco cuando el gasto se paga por `Transferencia`.

### 6. Página de Panel Central / Consulta Kardex (`/panel-central` → `frontend/src/app/panel-central/page.tsx`)
- **Estado en código:**
  - Carga por defecto el código `"P001"` (sin guion), etiqueta `"Precio de Venta"` / `"Precio Venta"` en vez de `"Precio"`, y muestra badges de otras tallas sin pintar las tallas inexistentes del rango ni efecto `hover` enriquecido.

### 7. Persistencia Temporal en Formularios (Transversal en `pos`, `inventario`, `ingresos`, `gastos`)
- **Estado en código:**
  - Ningún modal ni carrito guarda borradores temporales en `localStorage`; al recargar la página o cerrar accidentalmente un modal se pierden los datos ingresados.

---

## Fases y Tareas del Nuevo Backlog (2026-11-03)

### Fase 1 — Navegación, Sesión, Usuarios y Empleados
- [x] **USU-001**: Botón directo y visible de **Cierre de sesión** en barra lateral/superior y eliminación del fallback automático en `autenticacion-contexto.tsx` para redirigir limpiamente a `/inicio-sesion`. → `pendientes/001-sesion-usuarios-empleados.md`
- [x] **USU-002**: Incorporar acceso directo a **Añadir usuarios** (`/administracion`) en el menú lateral para administradores y flujo completo de alta de cuentas. → `pendientes/001-sesion-usuarios-empleados.md`
- [x] **USU-003**: **Editar empleado** en Administración de Usuarios y en Gastos de Caja Chica (`PUT /gastos/:id`, selector de empleados registrados y trazabilidad de vendedor en ventas). → `pendientes/001-sesion-usuarios-empleados.md`

### Fase 2 — Inventario: Códigos `P-1..P-N` (al infinito), Umbrales de Stock, Tallas y Etiquetas
- [x] **INV-001**: Formato de **Código con `P-1` al infinito (sin límite)** (autogeneración del siguiente correlativo `P-N`, normalización tolerante en buscadores y migración/compatibilidad de códigos). → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **INV-002**: **Reemplazar "Precio Venta" por "Precio"** en todas las tablas, formularios, fichas y archivos de traducción (`Inventario.json`, `Ingresos.json`, `PuntoVenta.json`, `PanelCentral.json`). → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **INV-003**: Nuevos umbrales de inventario: **Crítico a partir de 1** (`stockActual === 1`) y **Disponible/Óptimo a partir de 3 en stock** (`stockActual >= 3`, dejando `2` como stock bajo/aviso y `0` como agotado). → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **INV-004**: **Pintar si no existe esa talla** y **Efecto hover por talla** en la grilla/badges de tallas por modelo en Inventario, POS y Panel Central (mostrando stock y precio en el hover con micro-interacción y tooltip, y pintando tachadas/atenuadas las tallas inexistentes). → `pendientes/002-inventario-codigos-stock-tallas.md`
- [x] **INV-005**: Soporte de **Tamaños** adicionales (`S`, `M`, `L`, `XL`, `Pequeño`, `Mediano`, `Grande`, `Único`) además de las tallas numéricas 34–43. → `pendientes/002-inventario-codigos-stock-tallas.md`

### Fase 3 — Inventario: Variación de Colores, Colores de Brasil, Extras y Catálogo en PDF
- [x] **CAT-001**: **Añadir variación de colores** mediante selector visual multi-color y combinaciones con `/` al crear o editar calzados. → `pendientes/003-colores-brasil-extras-catalogo-pdf.md`
- [x] **CAT-002**: Preset rápido de **Colores de Brasil** (Verde, Amarillo, Azul, Blanco) y paletas frecuentes en el selector de colores de calzado. → `pendientes/003-colores-brasil-extras-catalogo-pdf.md`
- [x] **CAT-003**: **Añadir extras al zapato** (campo `extras` en entidad `Calzado`, DTOs, modal de inventario y vista en POS para cordones extra, caja, plantillas, accesorios). → `pendientes/003-colores-brasil-extras-catalogo-pdf.md`
- [x] **CAT-004**: Generador y exportación de **Catálogo en PDF** desde `/inventario` con fotos, códigos, colores, tallas disponibles y Precio en Bs (sin mostrar costo de compra). → `pendientes/003-colores-brasil-extras-catalogo-pdf.md`

### Fase 4 — Compras / Ingresos: Edición, Proveedores y Gestión de Precios Nuevos
- [x] **COM-001**: **Editar compras** en `/ingresos` (`PUT /api/v1/ingresos/:id` con reversión y recálculo transaccional de `stockActual`, `totalIngresado` y costo promedio ponderado + modal de edición en frontend). → `pendientes/004-compras-proveedores-actualizacion-precios.md`
- [x] **COM-002**: **Añadir proveedor** (entidad/módulo `proveedores` en backend y selector con creación rápida de proveedor en el modal de Ingresos/Compras). → `pendientes/004-compras-proveedores-actualizacion-precios.md`
- [x] **COM-003**: **Registrar nuevamente el mismo producto pero en otros precios** y mostrar **Advertencia con precio nuevo** cuando el precio de compra o precio de venta del nuevo ingreso difiera del actual. → `pendientes/004-compras-proveedores-actualizacion-precios.md`
- [x] **COM-004**: Opción explícita para **Actualizar precios de productos no vendidos aún a nuevo precio** al confirmar un ingreso con cambio de precio (aplicando el nuevo precio al stock remanente del producto/modelo). → `pendientes/004-compras-proveedores-actualizacion-precios.md`

### Fase 5 — Rebajas, Liquidaciones por Fechas y Justificación Automática (Audio del Cliente)
- [x] **REB-001**: **Registrar rebajas y liquidaciones por rango de fechas** en productos/modelos (ej. de 350 Bs a 299 Bs con opción *"Solo por hoy y mañana"* o desde `fechaInicio` hasta `fechaFin` y motivo: Liquidación, Cambio de mercadería, Actualización). → `pendientes/005-rebajas-liquidaciones-fechas.md`
- [x] **REB-002**: Alerta **"Estás rebajando mucho"** en ventas cuando el descuento supere el umbral permitido o se acerque al costo, con **autocompletado y justificación automática** cuando el calzado tenga una promoción/liquidación activa en la fecha de venta. → `pendientes/005-rebajas-liquidaciones-fechas.md`

### Fase 6 — Punto de Venta (Agrandar POS), Ventas Realizadas y Bancos
- [x] **VEN-001**: **Agrandar POS** en `/pos` (tarjetas de producto más grandes, imágenes de mayor altura, tipografías legibles en mostrador, botones táctiles $\ge 44\text{px}$ y mejor distribución de columnas). → `pendientes/006-pos-ventas-realizadas-bancos.md`
- [x] **VEN-002**: **Cambiar "POS" por "Ventas Realizadas"** en la navegación/vistas y habilitar el listado completo de **Ventas Realizadas** conectado a `GET /ventas` con filtros por fecha, método de pago, banco, vendedor y reimpresión de ticket. → `pendientes/006-pos-ventas-realizadas-bancos.md`
- [x] **VEN-003**: **Añadir banco** (catálogo/selector de bancos con opción de agregar nuevos bancos al cobrar con QR/Transferencia/Tarjeta en POS y en Gastos por transferencia). → `pendientes/006-pos-ventas-realizadas-bancos.md`

### Fase 7 — Guardado Temporal de Datos (Borradores en Formularios y Carrito)
- [x] **TMP-001**: **Guardar datos de forma temporal** en `localStorage` para el carrito y cliente del POS, formulario de alta/edición de Inventario, registro de Compras/Ingresos y registro de Gastos, evitando pérdida de datos por recarga o cierre accidental. → `pendientes/007-guardado-temporal-borradores.md`

### Fase 8 — Optimización de Rendimiento y Carga Inicial (1 a 3 Segundos)
- [x] **REN-001**: **Optimización de rendimiento en la primera entrada a la página** (desacoplamiento de `three` del layout raíz y `EfectosAmbientalesSistema`, carga diferida con `next/dynamic` de gráficos `recharts`, `VistaInicioSesion`, `ModalInicioSesion`, `ModalBusquedaRapida`, `driver.js` y `browser-image-compression`, eliminación de doble hidratación en `ProveedorAutenticacion`, optimización GPU de `HaloAmbientalCursor`, paralelización de las 9 consultas SQL de `GET /panel-central/metricas` con `Promise.all`, eliminación de doble consulta en `/autenticacion/refrescar` e índices `@Index()` en entidades TypeORM). → `pendientes/008-optimizacion-rendimiento-carga-inicial.md`

### Fase 9 — Identidad Brasil, Eliminación de Halos y Redundancias, Caché/Paginación y Layout con Tabs
- [x] **BRA-001**: **Identidad oficial de Brasil y logotipo "la la la — CALZADOS BRASILEÑOS"** (gama de colores Verde Bandeira `#009739`, Amarillo Oro `#FEDD00` y Azul Celestial `#012169` predeterminada en `globals.css` y `tema-contexto.tsx`, vector oficial en `LogoDeusUmbrae` y `LogoInstitucional`, e imagen `/logo-lalala-brasil.jpg`). → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
- [x] **UI-001**: **Eliminación total de halos de luz** (`HaloAmbientalCursor`, `DestellosEsquinasSistema`, `EfectosAmbientalesSistema` en layout operativo, y gradientes spotlight en `TarjetaFoco` y `BotonHalo`). → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
- [x] **UI-002**: **Limpieza y eliminación de redundancias en `BarraSuperior`, `MenuLateral` y páginas** (eliminación de botones "Cerrar sesión" cuadruplicados, tarjeta de perfil duplicada en Sidebar, títulos repetidos y las 3 barras de navegación repetidas en `/`). → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
- [x] **REN-002**: **Caché en memoria (`cache-datos.ts`), navegación nativa sin `e.preventDefault()`, reemplazo de 500 Tooltips de Radix en `TiraTallasModelo` y paginación rápida (`12` filas)** en `/inventario`, `VistaVentasRealizadas`, `/ingresos`, `/gastos`, `/panel-central` y `/administracion`. → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
- [x] **TAB-001**: **Estandarización de layout basado en `Tabs` de ShadCN UI** en las 8 páginas del sistema (`/`, `/pos`, `/inventario`, `/ingresos`, `/gastos`, `/panel-central`, `/administracion`, `/configuraciones`) con carga diferida por pestaña. → `pendientes/009-identidad-brasil-rendimiento-tabs-layout.md`
