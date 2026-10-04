# Reglas de Exploración de Archivos y Búsqueda

Al realizar búsquedas de archivos, análisis de directorios o exploraciones dentro del proyecto, debes aplicar las siguientes restricciones:

- **Excluir SIEMPRE** directorios de dependencias, cachés y carpetas compiladas por defecto para evitar saturar el contexto y mejorar la eficiencia:
  - `node_modules`
  - `dist`
  - `build`
  - `.next`
  - `pgsql` (binarios del PostgreSQL portable)
  - `.git`
  - `.turbo`
  - Archivos de log (`*.log`)
  - Archivos ocultos del sistema (ej. `.DS_Store`)

- **Excepción:** Únicamente debes explorar estos directorios si el objetivo específico y explícito de la tarea lo requiere (por ejemplo: investigar el código interno de una dependencia en `node_modules`, o verificar el bundle de compilación en `dist`/`.next`).
