# 009 — Aproximador Dinámico de Espacio en la Nube

- **Estado:** Pendiente
- **Backlog:** ALM-005
- **Prioridad:** Baja

## Contexto
Cloudflare R2 ofrece 10 GB gratis. El dueño de la tienda debe saber, sin conocimientos técnicos, cuántas fotos más caben según la calidad elegida.

## Tareas
1. Niveles de compresión WebP 0 a 5 en `frontend/src/lib/optimizacion-imagenes.ts` (calidad y tamaño máximo por nivel).
2. Endpoint `GET /api/v1/almacenamiento/uso` que devuelva MB usados (suma de tamaños registrados al subir) y cantidad de fotos.
3. Widget en configuración: MB usados / 10 240 MB, fotos restantes estimadas según el tamaño promedio del nivel elegido.
4. Textos sencillos y traducidos ("Te quedan aprox. 8 500 fotos").

## Criterios de Aceptación
- Cambiar el nivel actualiza la estimación al instante sin recargar.
- La estimación difiere menos de un 10 % del promedio real tras subir 20 fotos.
