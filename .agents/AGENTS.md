# Configuración Global de Agentes: ZLaLaLaZ

El proyecto **ZLaLaLaZ** es una plataforma integral de gestión de inventario, punto de venta (POS), compras y panel financiero para tiendas de calzado. Utiliza configuraciones modulares separadas para mantener el entorno limpio, escalable y con responsabilidades estrictamente divididas entre Frontend (Next.js), Backend (NestJS / Rust opcional) y Escritorio/Móvil (Tauri en Rust).

Como ingeniero IA asignado a este proyecto en **Google Antigravity IDE**, **DEBES LEER, ASIMILAR Y RESPETAR ESTRICTAMENTE** las reglas, estándares y flujos definidos en los siguientes archivos de esta carpeta `.agents/`:

1. **[BACKLOG.md](BACKLOG.md)**: Contiene el listado de requerimientos, las historias de usuario de cada fase y el flujo de avance lógico. **Este es tu mapa de ruta.**
2. **[profile.md](profile.md)**: Define la personalidad, el rol esperado, las convenciones de nomenclatura (Español Estricto para TypeScript/NestJS y Convención Canónica para Rust/Tauri).
3. **[skills.md](skills.md)**: Establece la arquitectura, la estructura de carpetas, el manejo de imágenes con Cloudflare R2/WebP, el soporte para `driver.js`, y las reglas de diseño para Next.js, NestJS y Tauri en Rust (preparado para escritorio y móvil).
4. **[workflows.md](workflows.md)**: Define las instrucciones para instalar paquetes, ejecutar comandos CLI, agregar componentes de ShadCN UI, generar módulos de NestJS, crear comandos de Tauri y los procesos de validación de compilación e i18n.

## Instrucción Crítica de Ejecución

Antes de comenzar a programar o al iniciar una sesión de trabajo:
- Consulta el **`BACKLOG.md`** para saber en qué tarea o historia debes enfocarte.
- Cerciórate de aplicar las reglas de nomenclatura descritas en **`profile.md`** según el lenguaje del módulo (`TypeScript` vs `Rust`).
- **¡CERO TEXTO QUEMADO EN LA UI! (i18n ESTRICTO)**: Antes de dar por terminada una tarea en el frontend, verifica rigurosamente que NINGÚN texto esté hardcodeado en la interfaz y que cada llave de traducción (ej. `t('clave')`) exista realmente en su respectivo archivo JSON modular (`locales/{idioma}/{Pagina}.json`).
- **Registro Central de Errores Obligatorio**: Todo nuevo error (API, React, Base de Datos, Almacenamiento, etc.) **DEBE** tener asignado un código único (ej. `ERR-CALZ-001`, `ERR-POS-002`, `ERR-R2-003`) y registrarse explícitamente en `backend/errores.md` junto con su descripción, causa y componente originario.
- **Gestión de Imágenes con Presupuesto Cero**:
  - Todo upload desde el frontend DEBE pasar previamente por compresión a WebP en el cliente (`browser-image-compression`).
  - El backend debe usar el protocolo compatible con S3 para almacenar en **Cloudflare R2** (10 GB gratis, 0$ egress) o Supabase.
  - El frontend debe renderizar imágenes a través de Next.js `<Image>` para aprovechar la caché perimetral en Vercel Edge.
- **Tours Interactivos con `driver.js`**: Cada flujo operativo clave (Venta POS, Alta de Calzado, Registro de Gastos) debe contar con su paso interactivo guiado.
- **Preparación de Interfaz Móvil**: La arquitectura del frontend y Tauri debe prever la interfaz móvil (Mobile POS / Bottom Navigation), la cual se construirá de forma prioritaria en las fases finales.
- **Entorno Rust / Tauri**: El entorno actual NO cuenta con compilador de Rust instalado (`cargo`), por lo que **NUNCA ejecutes comandos de compilación de Rust**. Limítate a generar y estructurar los archivos fuente (`.rs`, `.toml`, `.json`) con sintaxis válida y canónica.
