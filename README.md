# Proyecto ZLaLaLaZ — Sistema de Gestión y POS para Tienda de Calzado

Plataforma unificada para la tienda de calzados **"LA, LA, LA" / "ZLaLaLaZ"**, integrando **Inventario con variantes de talla y color**, **Ingreso de Mercancía de proveedores**, **Punto de Venta (POS) rápido**, **Control de Gastos de Caja Chica** y **Panel Central Analítico con buscador instantáneo**.

---

## 🚀 Repositorios y Arquitectura

El proyecto está diseñado bajo un esquema multi-repositorio coordinado:

1. **Frontend (`frontend/`)**:
   - Repositorio: `https://github.com/Deus-Ex-Umbra/frontend-ZlalalaZ`
   - **Stack:** Next.js (App Router), TypeScript, Tailwind CSS, ShadCN UI, Lucide Icons.
   - **Tours Interactivos:** `driver.js` con guías paso a paso para el cajero y administradores.
   - **Optimización de Imágenes:** Compresión en cliente a formato WebP con `browser-image-compression` y caché perimetral con Next.js `<Image>` en Vercel Edge.
   - **Diseño Adaptable:** Preparado para escritorio y con interfaz móvil al final para atención en mostrador o en movimiento.

2. **Backend (`backend/`)**:
   - Repositorio: `https://github.com/Deus-Ex-Umbra/backend-ZlalalaZ`
   - **Stack:** NestJS con arquitectura modular, TypeScript, PostgreSQL (TypeORM/Prisma).
   - **Almacenamiento Sin Costos:** Integración con **Cloudflare R2** (S3 compatible, 10 GB gratis y 0$ costo de egress), con fallback a Supabase y local.
   - **Estándar:** Nomenclatura en español estricto, DTOs con `class-validator`, y registro central de errores (`errores.md`).

3. **Escritorio y Móvil (`src-tauri/`)**:
   - Repositorio: `https://github.com/Deus-Ex-Umbra/ZlalalaZ`
   - **Stack:** Tauri v2 en **RUST**.
   - **Convenciones:** Estándar canónico estricto de Rust (`snake_case`, `PascalCase`, `Result<T, E>`).
   - **Capacidades:** Permite empaquetar el POS como aplicación nativa de escritorio ligera y con arquitectura lista para compilar a móvil (Android/iOS) en fases posteriores.

4. **Base de Datos Local (`pgsql/`)**:
   - Motor PostgreSQL portable para ejecución y pruebas locales sin dependencias externas.

---

## ⚡ Comandos de Inicio Rápido

```bash
# Instalar dependencias en los espacios de trabajo
npm install

# Iniciar backend y frontend concurrentemente
npm run dev

# Iniciar únicamente el backend
npm run dev:backend

# Iniciar únicamente el frontend
npm run dev:frontend

# Validar tipado y compilación
npm run build
```

---

## 🤖 Agentes IA y Google Antigravity IDE

Toda la configuración de directrices, personalidad, habilidades y flujos de trabajo automatizados se encuentra en la carpeta `.agents/`:
- `AGENTS.md`: Punto de entrada y normas obligatorias.
- `profile.md`: Convenciones de idioma y estilos de código.
- `skills.md`: Arquitectura técnica de Frontend, Backend, Tauri Rust y almacenamiento.
- `workflows.md`: Comandos y pasos de validación.
- `BACKLOG.md`: Hoja de ruta por fases y tareas pendientes.
