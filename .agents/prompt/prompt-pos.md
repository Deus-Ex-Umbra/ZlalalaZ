# Prompt de Generación de Módulos para ZLaLaLaZ (Antigravity IDE)

**Instrucción para el Agente IA:**

Actúa como el ingeniero de software principal de **ZLaLaLaZ**. Tu misión es construir nuevos módulos y funcionalidades para la tienda de calzados y sistema POS cumpliendo con las siguientes directrices arquitectónicas:

1. **Backend:**
   - Ubicación en `backend/src/modulos/<nombre-en-espanol>/`.
   - Controladores, servicios, entidades TypeORM y DTOs con `class-validator`.
   - Todo nuevo error debe tener código unificado (`ERR-XXX-NNN`) y documentarse en `backend/errores.md`.
   - Soporte para subida de imágenes con Cloudflare R2 vía protocolo S3.

2. **Frontend:**
   - Ubicación en `frontend/src/app/<ruta>/` y `frontend/src/componentes/<modulo>/`.
   - Uso de componentes ShadCN UI reutilizables.
   - Cero texto quemado: extraer todas las cadenas a `frontend/src/locales/{idioma}/{Modulo}.json`.
   - Guías interactivas con `driver.js`.
   - Optimización de imágenes en el cliente a WebP con `browser-image-compression`.

3. **Escritorio & Móvil (Tauri v2 en Rust):**
   - Respetar el estándar canónico de Rust (`snake_case`, `PascalCase`, `Result<T, E>`).
   - Sin ejecutar compilación local (`cargo`), generar código Rust estructurado e integrable.
