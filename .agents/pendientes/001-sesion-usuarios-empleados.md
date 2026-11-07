# 001 — Cierre de Sesión, Añadir Usuarios y Edición de Empleados

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `USU-001`, `USU-002`, `USU-003`
- **Prioridad:** Alta

## Diseño Aprobado (`/lluvia-ideas`)
- **Unificación de Usuarios y Empleados (Opción A aprobada):** Todo empleado de la tienda se gestiona desde `/administracion` (`Usuarios`). Esa misma lista de usuarios/empleados alimenta el selector de empleado en **Gastos de Caja Chica** (`/gastos`) y registra automáticamente al vendedor en **Ventas Realizadas** (`/pos`).
- **Cierre de sesión directo:** Botón visible de un solo clic en `MenuLateral` y `BarraSuperior`. Al cerrar sesión, `autenticacion-contexto.tsx` elimina `lalala_token` y `lalala_usuario` de `localStorage`, guarda una bandera `lalala_sesion_cerrada = "true"` para evitar que el fallback de desarrollo re-autentique automáticamente al usuario, y redirige a `/inicio-sesion`.
- **Edición de empleados y gastos:** Se expone `/administracion` en el menú lateral para administradores (permitiendo añadir usuarios y editar empleados) y se habilita `PUT /api/v1/gastos/:id` para editar el empleado o datos de cualquier gasto registrado.

## Tareas
1. **`frontend/src/lib/autenticacion-contexto.tsx`**: Ajustar la hidratación y `cerrarSesion()` para que respete el cierre explícito de sesión y redirija a `/inicio-sesion` con `router.push("/inicio-sesion")`.
2. **`frontend/src/componentes/navegacion/menu-lateral.tsx` y `barra-superior.tsx`**:
   - Añadir el enlace directo a `/administracion` (`Usuarios / Empleados`) en el menú lateral para `ADMINISTRADOR`.
   - Añadir botón visible y directo de **Cerrar Sesión** (además del menú de perfil).
3. **`backend/src/modulos/gastos/` y `backend/src/modulos/ventas/`**:
   - Crear `ActualizarGastoDto` y endpoint `PUT /api/v1/gastos/:id` en `gastos.controlador.ts` y `gastos.servicio.ts`.
   - Agregar campo opcional `nombreVendedor` / `usuarioId` en `Venta` (`venta.entidad.ts`, `crear-venta.dto.ts`, `ventas.servicio.ts`).
4. **`frontend/src/app/gastos/page.tsx`**:
   - Reemplazar el input libre de empleado por un selector conectado a `listarUsuarios()` (con opción de ir a añadir/editar empleado).
   - Añadir botón de **Editar** en cada fila de la tabla de gastos para modificar el empleado responsable o los datos del gasto.

## Criterios de Aceptación
- Hacer clic en **Cerrar Sesión** cierra inmediatamente la sesión activa y muestra `/inicio-sesion`.
- El menú lateral muestra la sección de **Usuarios / Empleados** (`/administracion`), desde donde se añaden usuarios y se editan empleados.
- En `/gastos` se selecciona el empleado desde la lista de usuarios/empleados y se puede editar cualquier gasto existente.
