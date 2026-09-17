# Habilidades, Arquitectura y Mejores Prácticas (ZLaLaLaZ)

## 1. Frontend (Next.js App Router + TypeScript + Tailwind CSS + ShadCN UI)

1. **Estructura Base de Carpetas (Estricto):** Todo el código reside en `frontend/src/`:
   - `app/` (Rutas del App Router de Next.js en kebab-case o carpetas de ruta)
   - `componentes/` (UI y módulos de negocio en español)
     - `componentes/ui/` (Componentes base de ShadCN UI)
     - `componentes/pos/` (Componentes del Punto de Venta: carrito, teclado numérico, tallas)
     - `componentes/inventario/` (Catálogo, tarjetas de calzado, selector de variantes)
     - `componentes/tours/` (Configuración y guías interactivas de `driver.js`)
     - `componentes/navegacion/` (Barra superior para escritorio y barra inferior para móvil)
   - `contextos/` (React Contexts globales: carrito, autenticación, modo offline)
   - `hooks/` (Custom hooks en español: `useCarrito()`, `useTours()`)
   - `lib/` (Utilidades de compresión de imágenes, clientes API y formatos)
   - `locales/` (Archivos JSON de traducción por vista: `es/`, `en/`, `de/`)
   - `tipos/` (Interfaces y modelos de datos en TypeScript)

2. **Estrategia "Presupuesto Cero" de Gestión de Imágenes:**
   - **Compresión Pre-Upload en Cliente:** NUNCA enviar imágenes pesadas directamente. Utilizar `browser-image-compression` para redimensionar (máx 1200px), comprimir (calidad 0.8) y transformar a formato `.webp` en el navegador antes del envío.
   - **Renderizado y Caching Perimetral (Vercel Edge):** Usar siempre el componente `<Image>` de Next.js configurado con los dominios permitidos (Cloudflare R2 y Supabase) en `next.config.mjs` para que la red de Vercel descargue la imagen una sola vez y la distribuya optimizada desde su CDN gratuita.

3. **Tours Interactivos con `driver.js`:**
   - Crear guías paso a paso configuradas con `driver.js` para capacitar rápidamente a nuevos cajeros y encargados de tienda:
     - Tour del POS (selección de calzado, talla, descuento, cobro rápido).
     - Tour de Inventario (búsqueda, ajuste de stock, subida de foto con compresión).
     - Tour de Caja Chica (registro de egresos de empleados y arqueo).

4. **Diseño Adaptable y Preparación para Móvil:**
   - El POS y catálogo deben ser completamente responsive.
   - En pantallas móviles (<768px), la interfaz debe mostrar una barra de navegación inferior tipo app (`BottomNavigationBar`), cajón deslizable para el carrito (`Drawer`) y botones grandes táctiles para selección de tallas (34-43).

---

## 2. Backend (NestJS + TypeORM/Prisma + PostgreSQL + Cloudflare R2)

1. **Arquitectura Modular en Español:**
   - `src/modulos/calzados/`: Gestión de catálogo, modelos (Nike, Adidas, Puma), variantes por talla y color, y control de stock.
   - `src/modulos/ingresos/`: Recepción de mercancía de proveedores y actualización de costo promedio.
   - `src/modulos/ventas/`: Punto de venta, registro de transacciones, cálculo de descuentos por cliente y formas de pago (Efectivo, QR, Tarjeta, Transferencia).
   - `src/modulos/gastos/`: Control de gastos de caja chica de empleados con firmas/autorizaciones.
   - `src/modulos/panel-central/`: KPIs en tiempo real (ganancia bruta, stock crítico, rotación) y buscador global instantáneo.
   - `src/modulos/almacenamiento/`: Servicio unificado para Cloudflare R2 (S3 protocol) con fallback a Supabase y local.

2. **Almacenamiento S3 / Cloudflare R2:**
   - Uso de `@aws-sdk/client-s3` configurado con el endpoint de Cloudflare R2 (`https://<account_id>.r2.cloudflarestorage.com`), Access Key ID y Secret Access Key.
   - 10 GB de almacenamiento gratuito y 0$ en costes de transferencia (Egress).

3. **Manejo Estandarizado de Errores y Registro Central:**
   - Todo error interceptado por el filtro global debe devolver:
     `{ error: true, codigo: "ERR-CALZ-001", mensaje: "Mensaje legible", detalles: "Info técnica", timestamp: "..." }`
   - Registro obligatorio en `backend/errores.md`.

4. **Validación Estricta:**
   - DTOs protegidos con `class-validator` y `class-transformer`. Prohibido procesar `Body` sin tipar.

---

## 3. Escritorio y Móvil (Tauri v2 en Rust)

1. **Arquitectura Canónica de Rust para Tauri:**
   - Ubicación: `src-tauri/`
   - Manifiesto: `Cargo.toml` con crates: `tauri = { version = "2", features = [...] }`, `serde`, `serde_json`, `tokio`, `thiserror`.
   - Punto de entrada: `src-tauri/src/main.rs` y `src-tauri/src/lib.rs`.
   - Módulo de comandos: `src-tauri/src/comandos/`
     - `pos.rs`: Comandos IPC para transacciones rápidas y cálculo de importes.
     - `impresion.rs`: Integración para impresión de tickets/recibos en impresoras térmicas ESC/POS.
     - `almacenamiento_local.rs`: Caché local en SQLite para operación offline en caso de caída de internet.

2. **Preparación Móvil (Tauri v2 Mobile Target):**
   - Tauri v2 admite compilar a Android y iOS con el mismo núcleo Rust y el frontend web.
   - Las capacidades y permisos se configuran de forma modular en `src-tauri/capabilities/default.json`.

3. **Regla de Ejecución:**
   - Como no hay compilador Rust instalado en la máquina, NO ejecutar comandos de Rust (`cargo`). Limitarse a crear el código fuente y las configuraciones de Tauri v2.

---

## 4. Internacionalización (i18n) Modular

1. **Estructura Descentralizada:**
   - `frontend/src/locales/{idioma}/{NombreVista}.json` (ej. `locales/es/Inventario.json`, `locales/es/PuntoVenta.json`, `locales/es/PanelCentral.json`).
   - Idioma base: **Español** (`es`).
   - Idiomas secundarios: **Inglés** (`en`), **Alemán** (`de`).
2. **Cero Texto Quemado:** Todo botón, título, badge, tooltip, mensaje de confirmación o alerta debe usar `t()`.
