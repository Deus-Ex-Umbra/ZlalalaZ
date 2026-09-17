# Backlog del Proyecto: ZLaLaLaZ (Tienda de Calzado & POS)

## Instrucciones de Manejo del Backlog
- Debes guiarte por este backlog paso a paso para trabajar de forma autónoma.
- Cuando se te solicite avanzar, identifica la siguiente historia de usuario pendiente (`[ ]`) en el flujo lógico.
- Propón la arquitectura o crea directamente los archivos correspondientes según las reglas del proyecto.
- Nunca des por finalizada una tarea si no se han completado las validaciones de compilación y de i18n sin texto quemado.
- Actualiza manualmente el estado de los componentes (`[x]`) una vez completados y validados.

---

## Solicitudes y Fases del Proyecto

### Fase 0 — Infraestructura y Configuración Base
- [x] **INF-001**: Setup Inicial del Proyecto ZLaLaLaZ (Monorepo/Workspaces, `.gitignore`, `.env.example`, `package.json`).
- [x] **INF-002**: Copia e integración del motor portable PostgreSQL local (`pgsql/`).
- [x] **INF-003**: Configuración de Reglas de Agentes Antigravity (`AGENTS.md`, `GEMINI.md`, `profile.md`, `skills.md`, `workflows.md`).
- [x] **INF-004**: Registro Central de Errores (`backend/errores.md`).

### Fase 1 — Modelado de Datos y Backend Base (NestJS)
- [x] **BE-001**: Inicialización de arquitectura modular NestJS con TypeORM / PostgreSQL.
- [x] **BE-002**: Entidades y DTOs de Calzado y Variantes (Tallas 34 a 43, Colores, Marcas, Precios).
- [x] **BE-003**: Entidades y DTOs de Ingreso de Mercancía (Proveedores, Costos, Lotes).
- [x] **BE-004**: Entidades y DTOs de Ventas y Detalle de Venta (Clientes, Métodos de Pago: Efectivo/QR/Tarjeta, Descuentos).
- [x] **BE-005**: Entidades y DTOs de Gastos de Caja Chica (Empleados, Motivos, Autorizaciones).
- [x] **BE-006**: Datos semilla (`semillas.sql`) con los 476 registros de calzado de la hoja de cálculo.

### Fase 2 — Estrategia de Almacenamiento "Presupuesto Cero" (Cloudflare R2)
- [x] **ALM-001**: Módulo de almacenamiento agnóstico en NestJS con `@aws-sdk/client-s3` para Cloudflare R2 (10 GB gratis, 0$ egress).
- [x] **ALM-002**: Fallback automático a almacenamiento local y soporte para Supabase Storage vía `.env`.
- [x] **ALM-003**: Módulo de compresión en cliente WebP (`browser-image-compression`) en el frontend antes del upload.
- [x] **ALM-004**: Configuración de caché perimetral en Next.js `<Image>` para Vercel Edge CDN.

### Fase 3 — Catálogo e Inventario (Frontend & Backend)
- [x] **INV-001**: API de Catálogo con filtros por marca (Nike, Adidas, Puma, Vans), talla, color y rango de precio.
- [x] **INV-002**: Vista de Inventario en Frontend con ShadCN UI (Tarjetas de producto, tabla interactiva, badges de stock).
- [x] **INV-003**: Modal de creación y edición de calzado con subida de fotografía comprimida a WebP.
- [x] **INV-004**: Alertas visuales de stock bajo y stock agotado.

### Fase 4 — Punto de Venta POS (Ventas Rápidas)
- [x] **POS-001**: API de procesamiento de ventas con transacción atómica (actualización automática de stock).
- [x] **POS-002**: Interfaz de Punto de Venta en Frontend (Búsqueda rápida, selector táctil de tallas, carrito lateral).
- [x] **POS-003**: Modal de cobro con cálculo de cambio, descuento por cliente frecuente y formas de pago (Efectivo, QR, Tarjeta).
- [x] **POS-004**: Generación y visualización de ticket de venta imprimible.

### Fase 5 — Ingreso de Mercancía y Proveedores
- [x] **ING-001**: API de Ingreso de Mercancía (Suma automática a stock disponible).
- [x] **ING-002**: Vista de registro de compras a proveedores en Frontend (Distribuidora Calzado SRL).

### Fase 6 — Gastos de Caja Chica
- [x] **GAS-001**: API de Gastos de Empleados y Caja Chica con autorización de gerencia.
- [x] **GAS-002**: Vista de control de egresos y balance diario de caja en Frontend.

### Fase 7 — Panel Central y Analítica (Dashboard)
- [x] **PAN-001**: API de KPIs financieros (Total Ventas, Costos, Margen Bruto, Productos más vendidos).
- [x] **PAN-002**: Buscador consolidado instantáneo por ID de producto (recreando el buscador de la hoja de cálculo).
- [x] **PAN-003**: Dashboard con gráficos interactivos y métricas en vivo.

### Fase 8 — Tours Interactivos con `driver.js`
- [x] **TR-001**: Integración de `driver.js` en el Frontend.
- [x] **TR-002**: Tour guiado para Cajero / POS (aprende a vender en 3 pasos).
- [x] **TR-003**: Tour guiado para Inventario y subida de imágenes optimizadas.

### Fase 9 — Escritorio Nativo con Tauri v2 en Rust
- [x] **TAU-001**: Configuración de proyecto Tauri v2 (`Cargo.toml`, `tauri.conf.json`, `capabilities/`).
- [x] **TAU-002**: Módulo Rust `comandos/pos.rs` para transacciones locales.
- [x] **TAU-003**: Módulo Rust `comandos/impresion.rs` para tickets en impresoras térmicas.
- [x] **TAU-004**: Módulo Rust `comandos/almacenamiento_local.rs` para modo offline.

### Fase 10 — Interfaz Móvil y Adaptabilidad Completa
- [x] **MOB-001**: Barra de navegación inferior móvil (`BottomNavigationBar`) para pantallas táctiles.
- [x] **MOB-002**: Interfaz POS móvil optimizada para tabletas y teléfonos en mostrador (Mobile POS).
- [x] **MOB-003**: Preparación del manifiesto y esquema móvil de Tauri v2 para futura compilación en Android/iOS.
