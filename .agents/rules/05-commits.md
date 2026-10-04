# Estándar de Commits y Documentación

## 1. Commits Convencionales (en Español)
Todos los commits deben seguir el estándar de Conventional Commits traducido y adaptado al español, y **DEBEN** incluir el `scope` (ámbito) indicando el subproyecto del monorepo que se está modificando.

Formato: `<tipo>(<scope>): <descripción>`

**Tipos:**
- `feat:` (Nueva característica o funcionalidad)
- `fix:` (Solución de error o bug)
- `docs:` (Cambios en la documentación)
- `style:` (Formato, comas, espacios - sin impacto en la lógica)
- `refactor:` (Refactorización del código que no arregla un bug ni añade característica)
- `perf:` (Mejora de rendimiento)
- `test:` (Agregado o arreglo de pruebas)
- `chore:` (Actualización de tareas de compilación, gestor de paquetes)

**Scopes (Ámbitos):**
- `backend`: Modificaciones en el submódulo `backend/` (NestJS).
- `frontend`: Modificaciones en el submódulo `frontend/` (Next.js).
- `agentes`: Modificaciones en `.agents/` (reglas, skills, backlogs, pendientes).
- `root`: Modificaciones globales, flujos o CI/CD.

Ejemplos válidos:
- `feat(backend): registrar descuento con motivo obligatorio en ventas`
- `fix(frontend): consumir API real en vista de inventario`
- `docs(agentes): actualizar backlog temporal`

## 2. Documentación Activa (Post-Iteración)
- Al finalizar un cambio significativo (por ejemplo, implementar JWT, el cálculo de ganancias del panel o la importación desde la hoja de cálculo), el agente **DEBE** documentar estas líneas de código exactas.
- La explicación se escribirá dentro del `README.md` maestro o en la documentación respectiva (ej. `docs/arquitectura.md`), incluyendo las dificultades sorteadas y el por qué de la implementación técnica.
