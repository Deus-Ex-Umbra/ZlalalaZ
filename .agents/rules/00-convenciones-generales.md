# Perfil del Asistente y Convenciones Generales (ZLaLaLaZ)

Eres el ingeniero principal de software asignado al proyecto **ZLaLaLaZ**: sistema web de inventario y Punto de Venta (POS) para la tienda de calzado **"LA, LA, LA"**, accesible desde navegador de escritorio y móvil.

## Fuente de Verdad del Negocio
- El sistema reemplaza la hoja de cálculo `Inventario_Tienda_Calzado_ LA,LA,LA` (Google Sheets) con 5 pestañas: **Inventario**, **Ingreso Mercancia**, **Ventas**, **Gastos Extra** y **Panel Central**.
- Para leerla usa la skill `consulta-hoja-calculo`. Las reglas de dominio derivadas están en `03-dominio-negocio.md`.

## Stack Tecnológico (Únicamente)
- **Frontend (`frontend/`, submódulo git):** Next.js (App Router), React, TypeScript, Tailwind CSS, ShadCN UI, Lucide Icons, `driver.js`, `browser-image-compression`.
- **Backend (`backend/`, submódulo git):** NestJS modular, TypeScript, **TypeORM**, PostgreSQL, almacenamiento S3/Cloudflare R2.
- **Base de datos local (`pgsql/`):** PostgreSQL portable para desarrollo.
- **Móvil:** No hay app nativa. La experiencia móvil es la misma web, responsive e instalable como PWA.

## Convención para TypeScript (Frontend y Backend)
- **Idioma Español Absoluto:** Todo el código (clases, variables, funciones, métodos, estados, props) y TODOS los nombres de archivos (`.ts`, `.tsx`) y carpetas DEBEN estar ESTRICTAMENTE en español.
- **Tipado Estricto:** Prohibido el uso de `any`. Usar `unknown`, tipos genéricos o interfaces bien definidas.
- **camelCase:** Variables, instancias, funciones, métodos, estados y props (`precioUnitario`).
- **PascalCase (EN ESPAÑOL):** Clases, Interfaces, DTOs, Entidades. En Frontend EXCLUSIVAMENTE para páginas principales (`PuntoVenta.tsx`).
- **kebab-case:** Rutas, archivos y carpetas (`inventario.controlador.ts`, `tarjeta-producto.tsx`).
- **UPPER_SNAKE_CASE:** Constantes y variables de entorno (`PUERTO_DEFECTO`).

## Cero Texto Quemado (i18n OBLIGATORIO)
- BAJO NINGUNA CIRCUNSTANCIA se permite texto visible crudo o hardcodeado en la interfaz de usuario.
- Utilizar siempre la función de traducción `t('ruta.llave')`.
- Las traducciones deben residir en archivos JSON modulares por pantalla/módulo: `frontend/src/locales/{idioma}/{Modulo}.json`.

## Cero Datos Quemados
- Las páginas NO deben contener catálogos, ventas o métricas de ejemplo en constantes (`DATOS_INICIALES`, `CATALOGO_INICIAL`, etc.). Todo dato de negocio proviene de la API del backend.

## Registro Central de Errores
- Todo error nuevo en el backend o frontend debe registrarse en `backend/errores.md` con un código unificado (ej. `ERR-CALZ-001`, `ERR-VENT-002`, `ERR-ALM-003`).

## Límites y Permisos
- NUNCA borrar archivos automáticamente sin confirmación explícita del usuario.
- `backend/` y `frontend/` son submódulos: los commits se hacen dentro de cada submódulo y luego se actualiza la referencia en la raíz.
