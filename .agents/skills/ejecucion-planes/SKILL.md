---
name: ejecucion-planes
description: Úsalo cuando tengas un plan de implementación escrito para ejecutarlo con puntos de revisión.
---

# Ejecución de Planes (Executing Plans)

## Resumen
Carga el plan, revísalo críticamente, ejecuta todas las tareas y reporta al terminar.

Anuncia al inicio: "Estoy usando la skill de ejecución de planes para implementar esto."

## Optimización y Paralelización
- **Prioriza el uso de varios subagentes** si el plan tiene tareas de investigación, contextualización o desarrollo que se puedan ejecutar en paralelo para optimizar el tiempo.

## El Proceso

### Paso 1: Cargar y Revisar Plan
1. Lee el archivo del plan.
2. Revisa si hay algo preocupante. Si lo hay, consúltalo con el humano antes de empezar.

### Paso 2: Ejecutar Tareas
Por cada tarea:
1. Márcala como en progreso.
2. **Verifica Skills de Dominio** - lee `desarrollo-modulos` (y `diseno-interfaz` si hay UI) y `rules/03-dominio-negocio.md` antes de codificar.
3. Sigue cada paso exactamente.
4. Ejecuta las verificaciones especificadas.
5. Márcala como completada.

### Paso 3: Terminar el Desarrollo
Al completar:
1. Ejecuta `npm run build:backend` y/o `npm run build:frontend` según lo tocado.
2. Marca las tareas en `BACKLOG_TEMPORAL.md` y `BACKLOG_GENERAL.md`; actualiza el `Estado` del archivo en `pendientes/` si aplica.
3. Propón el mensaje de commit (regla `05-commits.md`) por cada submódulo afectado.

## Cuándo Parar y Pedir Ayuda
**DETENTE INMEDIATAMENTE SI:**
- Encuentras un bloqueo (falla un test, falta dependencia, instrucción ambigua).
- El plan tiene huecos críticos.
- La verificación falla repetidamente.
PIDE CLARIFICACIÓN en lugar de adivinar.

## Reglas Obligatorias antes de dar por completada una tarea
<HARD-GATE>
- [ ] **Idioma**: ¿Estoy respondiendo en el idioma del usuario (Español)?
- [ ] **Simplicidad**: ¿Pudo ser escrito en menos líneas sin perder claridad?
- [ ] **Cirugía**: ¿Toqué SOLO lo necesario o me puse a 'mejorar' cosas que no eran parte de la tarea?
- [ ] **Evidencia**: ¿De verdad ejecuté la verificación antes de declarar el éxito?
</HARD-GATE>
