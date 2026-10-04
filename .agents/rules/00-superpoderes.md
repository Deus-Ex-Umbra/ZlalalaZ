# Flujo de Trabajo Superpoderes (Antigravity IDE)

Esta regla define el ciclo de desarrollo central que el agente DEBE seguir para garantizar calidad sistemática.

## Ciclo de Desarrollo Básico

1. **Contexto:** Leer `BACKLOG_TEMPORAL.md` (iteración actual) y, si aplica, el requerimiento en `pendientes/NNN-*.md`.
2. **Lluvia de ideas:** Antes de programar algo nuevo, usar la skill `lluvia-ideas`: discutir enfoques, hacer preguntas aclaratorias y generar una especificación.
3. **Planificación:** Convertir la especificación en tareas pequeñas (2-5 min) con rutas de archivos exactas.
4. **Ejecución:** Ejecutar las tareas con la skill `ejecucion-planes`, haciendo pausas para la revisión humana (checkpoints).
5. **Revisión:** Revisar el código completado contra el plan antes de darlo por terminado.
6. **Finalización:** Compilar (`npm run build:backend` / `npm run build:frontend`), verificar tipado estricto y solicitar confirmación.
7. **Cierre de backlog:** Marcar la tarea en `BACKLOG_TEMPORAL.md` y `BACKLOG_GENERAL.md`. Si el requerimiento de `pendientes/` quedó completo, indicarlo en su encabezado (`Estado: Completado`).

## Gestión de Backlogs
- `BACKLOG_GENERAL.md`: hoja de ruta completa por fases. Solo se marca `[x]` lo verificado en código, nunca lo supuesto.
- `BACKLOG_TEMPORAL.md`: tareas de la iteración actual (máx. ~5). Al terminar la iteración se limpia y se rellena con la siguiente fase del general.
- `pendientes/NNN-tema.md`: un archivo por requerimiento con contexto, tareas y criterios de aceptación. Numeración correlativa de 3 dígitos.

## Integración con Habilidades (Skills)
- ANTES de realizar cualquier acción, verificar si hay una skill aplicable: `lluvia-ideas`, `ejecucion-planes`, `desarrollo-modulos`, `diseno-interfaz`, `consulta-hoja-calculo`.
- Nunca inventar si existe un procedimiento establecido en una skill.
- Todas las interacciones deben ser estrictamente en **Español**.
