# Proyecto LaLaLa — Sistema de Gestión y POS para Tienda de Calzado

Plataforma unificada para la tienda de calzados **"LA, LA, LA" / "LaLaLa"**, integrando **Inventario con variantes de talla y color**, **Ingreso de Mercancía de proveedores**, **Punto de Venta (POS) rápido**, **Control de Gastos de Caja Chica** y **Panel Central Analítico con buscador instantáneo**.

---

## 🚀 Repositorios y Arquitectura

El proyecto está diseñado bajo un esquema multi-repositorio coordinado:

1. **Frontend (`frontend/`)**:
   - Repositorio: `https://github.com/Deus-Ex-Umbra/frontend-LaLaLa`
   - **Stack:** Next.js (App Router), TypeScript, Tailwind CSS, ShadCN UI, Lucide Icons.
   - **Tours Interactivos:** `driver.js` con guías paso a paso para el cajero y administradores.
   - **Optimización de Imágenes:** Compresión en cliente a formato WebP con `browser-image-compression` y caché perimetral con Next.js `<Image>` en Vercel Edge.
   - **Diseño Adaptable:** Preparado para escritorio y con interfaz móvil al final para atención en mostrador o en movimiento.

2. **Backend (`backend/`)**:
   - Repositorio: `https://github.com/Deus-Ex-Umbra/backend-LaLaLa`
   - **Stack:** NestJS con arquitectura modular, TypeScript, PostgreSQL (TypeORM/Prisma).
   - **Almacenamiento Sin Costos:** Integración con **Cloudflare R2** (S3 compatible, 10 GB gratis y 0$ costo de egress), con fallback a Supabase y local.
   - **Estándar:** Nomenclatura en español estricto, DTOs con `class-validator`, y registro central de errores (`errores.md`).

3. **Base de Datos Local (`pgsql/`)**:
   - Motor PostgreSQL portable para ejecución y pruebas locales sin dependencias externas.

> El acceso móvil se resuelve con la misma aplicación web (responsive e instalable como PWA); no hay aplicación nativa.

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

Toda la configuración de directrices, habilidades y seguimiento del proyecto se encuentra en la carpeta `.agents/`:
- `AGENTS.md`: Punto de entrada y mapa de la carpeta.
- `rules/`: Convenciones de código, arquitectura y reglas de dominio del negocio.
- `skills/`: Habilidades invocables (diseño, desarrollo de módulos, consulta de la hoja de cálculo original).
- `BACKLOG_GENERAL.md` / `BACKLOG_TEMPORAL.md`: Hoja de ruta por fases e iteración actual.
- `pendientes/`: Requerimientos detallados por tarea.
