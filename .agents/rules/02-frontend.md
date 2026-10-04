# Reglas: Frontend (Next.js App Router + TypeScript + Tailwind CSS + ShadCN UI)

## 1. Estructura Base de Carpetas (Estricto)
Todo el código reside en `frontend/src/`:
- `app/` (Rutas del App Router: `inventario/`, `pos/`, `ingresos/`, `gastos/`, `panel-central/`)
- `componentes/` (UI y módulos de negocio en español)
  - `componentes/ui/` (Componentes base de ShadCN UI)
  - `componentes/pos/` (Punto de Venta)
  - `componentes/inventario/` (Catálogo)
  - `componentes/tours/` (`driver.js`)
  - `componentes/navegacion/` (Barras de navegación)
- `contextos/` (React Contexts globales)
- `hooks/` (Custom hooks en español)
- `lib/` (Utilidades y cliente API tipado)
- `locales/` (Traducciones JSON: `es/`, `en/`, `de/`)
- `tipos/` (Interfaces TypeScript compartidas con los DTOs del backend)

## 2. Consumo de API
- Toda petición al backend pasa por un único cliente tipado en `lib/` que adjunta el token JWT y traduce los errores estándar (`codigo`, `mensaje`) a notificaciones `sonner`.
- La URL base se toma de `NEXT_PUBLIC_API_URL`. Prohibido escribir URLs del backend en componentes.
- Prohibido `useState<any>`: tipar cada respuesta con interfaces de `tipos/`.

## 3. Estrategia "Presupuesto Cero" de Gestión de Imágenes
- **Compresión Pre-Upload en Cliente:** NUNCA enviar imágenes pesadas directamente. Utilizar `browser-image-compression` para redimensionar (máx 1200px), comprimir (calidad 0.8) y transformar a formato `.webp` en el navegador.
- **Renderizado y Caching Perimetral (Vercel Edge):** Usar siempre el componente `<Image>` de Next.js configurado con los dominios permitidos (Cloudflare R2/Supabase) en `next.config.mjs`.

## 4. Formato Monetario y Fechas
- Moneda: Bolivianos. Mostrar con `Intl.NumberFormat('es-BO', { style: 'currency', currency: 'BOB' })` o el formato `Bs 1.234,00` centralizado en `lib/`.
- Fechas en formato `dd/MM/yyyy` (convención de la hoja original).

## 5. Tours Interactivos
- Crear guías paso a paso configuradas con `driver.js` para capacitar rápidamente a nuevos usuarios (POS, Inventario, Caja Chica).

## 6. Diseño Adaptable, Móvil y PWA
- El POS y el catálogo deben ser completamente responsive.
- En pantallas móviles (<768px), mostrar barra inferior tipo app, cajón deslizable (`Drawer`) y botones táctiles grandes.
- La aplicación debe ser instalable como PWA (manifest + service worker); no existe app nativa.
- Impresión de tickets desde el navegador (`window.print()` con hoja de estilos para impresora térmica de 58/80 mm).
