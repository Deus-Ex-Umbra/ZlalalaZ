---
name: lluvia-ideas
description: "DEBES usar esta skill antes de cualquier trabajo creativo (crear funciones, construir componentes, agregar lógica). Explora la intención del usuario, requisitos y diseño ANTES de programar."
---

# Lluvia de Ideas y Diseño (Brainstorming)

Esta skill te ayuda a transformar ideas en diseños y especificaciones claras mediante diálogo colaborativo natural. 

Empieza por entender el contexto actual del proyecto, luego haz preguntas de una en una para refinar la idea. Una vez que entiendas qué construir, presenta un diseño y pide aprobación.

<HARD-GATE>
NO invoques ninguna skill de implementación, no escribas código, ni andamies ningún proyecto hasta presentar un diseño y que el usuario lo apruebe. Esto aplica a TODOS los proyectos, incluso los más simples.
</HARD-GATE>

## Optimización de Tiempo con Subagentes
- **Prioriza el uso de varios subagentes** para tareas paralelas de investigación, contextualización o búsqueda de referencias de diseño. Esto ayuda a agilizar la lluvia de ideas sin bloquear tu hilo principal y optimiza el tiempo.

## Checklist de Proceso
1. **Explorar el contexto del proyecto**: lee archivos, commits, `BACKLOG_TEMPORAL.md` y `rules/03-dominio-negocio.md`.
2. **Preguntar de una en una**: comprende el propósito y los límites.
3. **Proponer 2-3 enfoques**: con sus ventajas/desventajas y tu recomendación.
4. **Presentar diseño**: por partes y pedir confirmación.
5. **Escribir documento de diseño (Spec)**: actualiza el archivo correspondiente en `.agents/pendientes/NNN-<tema>.md` (o crea uno nuevo con el siguiente número) con contexto, diseño, tareas y criterios de aceptación.
6. **Autorevisión del Spec**: arregla placeholders (TODOs) y ambigüedades.
7. **Transición**: invoca la skill `ejecucion-planes` SOLO si el diseño fue aprobado.

## Principios Clave
- **Una pregunta a la vez** - No abrumar.
- **YAGNI (You Aren't Gonna Need It)** - Remueve funcionalidades innecesarias.
- **Validación Incremental** - Obtén el visto bueno antes de seguir.
