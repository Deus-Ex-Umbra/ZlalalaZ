---
name: desarrollo-modulos
description: Habilidad para construir nuevos módulos y funcionalidades full-stack (NestJS + Next.js) para el sistema POS y Tienda ZLaLaLaZ.
---

# Desarrollo de Módulos (ZLaLaLaZ)

Al usar esta habilidad para crear o completar un módulo de negocio, sigue los estándares del proyecto en todos los niveles:

## 0. Antes de Empezar
- Lee `rules/03-dominio-negocio.md`: campos, validaciones y fórmulas oficiales de cada pestaña de la hoja.
- Si el módulo corresponde a un requerimiento de `pendientes/`, úsalo como especificación y criterios de aceptación.

## 1. Backend (NestJS)
- Ubicación: `backend/src/modulos/<nombre-en-espanol>/`.
- Estructura: `<modulo>.controlador.ts`, `<modulo>.servicio.ts`, `<modulo>.modulo.ts`, `entidades/`, `dto/`.
- Entidades TypeORM con columnas en `snake_case` (`name: 'precio_compra'`) y propiedades en camelCase.
- DTOs validados con `class-validator`.
- Operaciones que afectan stock: transacción con `QueryRunner`.
- Errores: Todo nuevo error lanza una excepción estandarizada (`ERR-XXX-NNN`) documentada en `backend/errores.md`.
- Imágenes: Si el módulo maneja imágenes, usa `modulos/almacenamiento` (Cloudflare R2 vía S3).
- Verificación: `npm run build:backend`.

## 2. Frontend (Next.js)
- Ubicación: Vistas en `frontend/src/app/<ruta>/` y UI en `frontend/src/componentes/<modulo>/`.
- Datos: consume la API mediante el cliente tipado de `frontend/src/lib/`; interfaces en `frontend/src/tipos/`. Prohibido `any` y datos de ejemplo en constantes.
- UI: Componentes base de ShadCN UI y lineamientos de la skill `diseno-interfaz`.
- Internacionalización: **Cero texto quemado**. Cadenas en `frontend/src/locales/{es,en,de}/{Modulo}.json`.
- Experiencia: Guía interactiva con `driver.js` para cada pantalla nueva.
- Imágenes: Compresión a WebP en cliente (`browser-image-compression`) antes de enviar al backend.
- Responsive: probar en <768px (barra inferior y botones táctiles).
- Verificación: `npm run build:frontend` y `npm run lint:frontend`.

## 3. Optimización de Tiempo (Subagentes)
- **Prioriza el uso de varios subagentes en paralelo** para tareas de investigación o contextualización (ej. revisar backend y frontend a la vez).
