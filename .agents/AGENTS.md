# Sistema Agéntico de LaLaLa (Antigravity IDE)

Esta carpeta define el comportamiento del sistema guiado por Inteligencia Artificial (Google Antigravity) para el desarrollo y mantenimiento de LaLaLa: sistema web de inventario y Punto de Venta (POS) para la tienda de calzado "LA, LA, LA", que reemplaza su hoja de cálculo de Google Sheets.

## Estructura
- `rules/`: Directrices inflexibles que el agente DEBE seguir incondicionalmente. NOTA: Esta carpeta no debe ser traducida a `reglas` porque Antigravity la detecta con este nombre reservado.
  - `00-convenciones-generales.md` y `00-superpoderes.md`: stack (NestJS + Next.js + PostgreSQL), español absoluto, cero texto/datos quemados, ciclo de trabajo.
  - `01-backend.md`, `02-frontend.md`: arquitectura de cada submódulo.
  - `03-dominio-negocio.md`: mapeo hoja de cálculo → sistema, reglas de negocio y fórmulas oficiales.
  - `04-workflows.md`, `05-commits.md`, `06-traduccion.md`, `07-calidad-ui.md`, `08-exploracion.md`: comandos, commits, nomenclatura, calidad visual y exploración.
- `skills/`: Habilidades invocables. NOTA: Esta carpeta no debe ser traducida a `habilidades` porque Antigravity la detecta con este nombre reservado.
  - `lluvia-ideas` → `ejecucion-planes` (ciclo diseño → implementación), `desarrollo-modulos` (full-stack), `diseno-interfaz` (UI), `consulta-hoja-calculo` (lectura de la hoja original).
  - Catálogos UI y diseño: `catalogo-shadcn` (componentes base accesibles), `catalogo-skipper-ui` (micro-interacciones y transiciones fluidas), `catalogo-cult-ui` (componentes interactivos de nicho e isla dinámica), `catalogo-watermelon-ui` (bloques de producción, dashboards y tablas) y `catalogo-motion-primitives` (animaciones atómicas, morphing y números rodantes).
- `BACKLOG_GENERAL.md`: hoja de ruta completa por fases, con el estado verificado en código.
- `BACKLOG_TEMPORAL.md`: tareas de la iteración actual.
- `pendientes/`: un archivo `NNN-tema.md` por requerimiento, con contexto, tareas y criterios de aceptación. Cada tarea del backlog referencia su pendiente.

Al iniciar cualquier tarea, el agente cargará automáticamente este contexto para asegurar calidad empresarial e higiene de código en cada interacción.
