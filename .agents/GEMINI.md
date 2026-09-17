# Reglas de Proyecto: ZLaLaLaZ (Google Antigravity IDE)

Este archivo define las reglas contextuales obligatorias que rigen el comportamiento de los agentes en este proyecto.

## 1. Stack Tecnológico y Repositorios
- **Frontend (`frontend/`):** Next.js (App Router), React, TypeScript, Tailwind CSS, ShadCN UI, Lucide Icons, `driver.js`, `browser-image-compression`. Repositorio: `https://github.com/Deus-Ex-Umbra/frontend-ZlalalaZ`.
- **Backend (`backend/`):** NestJS con arquitectura modular, TypeScript, TypeORM/Prisma, PostgreSQL, integración S3/Cloudflare R2. Repositorio: `https://github.com/Deus-Ex-Umbra/backend-ZlalalaZ`.
- **Escritorio & Móvil (`src-tauri/`):** Tauri v2 en **RUST**. Repositorio: `https://github.com/Deus-Ex-Umbra/ZlalalaZ`.

## 2. Reglas Universales de Código
1. **TypeScript (Frontend y NestJS Backend): Idioma Español Absoluto.**
   - Clases, métodos, variables, archivos (`.ts`, `.tsx`) y carpetas en estricto español (ej. `calzado.controlador.ts`, `obtenerInventario()`, `src/modulos/ventas/`).
   - Únicas excepciones: palabras reservadas del lenguaje, decoradores nativos (`@Injectable`, `@Controller`), hooks nativos (`useEffect`, `useState`) y librerías de npm.
2. **Rust (Tauri Escritorio/Móvil y Rust Backend opcional): Estándar Canónico de Rust.**
   - `snake_case` para funciones, variables, nombres de archivos (`.rs`) y módulos (`mod comando_pos;`).
   - `PascalCase` para structs, enums y traits (`struct DetalleVenta`, `enum MetodoPago`).
   - `SCREAMING_SNAKE_CASE` para constantes y estáticos.
   - Manejo de errores con `Result<T, E>` y tipos de error explícitos.
   - En lo posible, términos de negocio en español adaptados a la sintaxis canónica de Rust (`fn procesar_venta()`, `struct Calzado`).
3. **Rust sin compilación local:** No ejecutar `cargo build` ni comandos de Rust en este entorno. Solo generar archivos y código fuente con sintaxis válida.
4. **Cero Texto Quemado (i18n):** Todo texto visible en UI debe usar llaves de traducción (`t('pos.cobrar')`) en `frontend/src/locales/{idioma}/{Pagina}.json`.
5. **Registro Central de Errores:** Registrar cada error en `backend/errores.md` con código unificado (`ERR-XXX-NNN`).
6. **Estrategia de Imágenes "Presupuesto Cero":**
   - Compresión a WebP en el cliente antes de subir.
   - Subida a Cloudflare R2 vía S3 API.
   - Renderizado con Next.js `<Image>` para aprovechar la caché de Vercel Edge.
7. **Diseño Adaptable y Móvil:** Preparar componentes para visualización de escritorio y pantallas táctiles móviles. La interfaz móvil completa se desarrollará en la fase final.
