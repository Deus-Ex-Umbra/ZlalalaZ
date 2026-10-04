# 06 - Traducción y Nomenclatura en Español

**Prioridad Máxima**: Casi NADA debe estar en inglés en la base de código (excepto dependencias externas o APIs nativas de librerías como React/Next, useEffect, HTML tags, clases de Tailwind). A la hora de escribir lógica, nombres de archivos, rutas, bases de datos, variables, funciones, clases, props y estados, aplica una traducción absoluta al español.

## Reglas de Traducción Obligatorias (Ejemplos):
- `auth.*` -> `autenticacion.*`
- `login.*` -> `inicio-sesion.*`
- `logout.*` -> `cierre-sesion.*`
- `user.*` -> `usuario.*`
- `password.*` -> `contrasena.*` o `clave.*`
- `role.*` -> `rol.*`
- `dashboard.*` -> `panel-control.*`
- `loading` -> `cargando`
- `payload` -> `carga_util` o `datos`
- `handleSubmit` -> `manejarEnvio`
- `handleOptionChange` -> `manejarCambioOpcion`
- `fetch` responses (`res`, `req`) -> `respuesta`, `peticion`
- Nombres de rutas (`/login`, `/api/users`) -> `/inicio-sesion`, `/api/usuarios`

**Nota:** Nomenclaturas como `login` o `auth` están ESTRICTAMENTE PROHIBIDAS. Cualquier término del dominio del negocio, flujo de usuario, props de componentes, variables de estado (useState), y métodos deben escribirse rigurosamente en español para todo el stack (Backend, Frontend, Móvil).
**TODO lo posible es español**. Si lo olvidas, el linter mental del agente debe dispararse y corregirlo.
