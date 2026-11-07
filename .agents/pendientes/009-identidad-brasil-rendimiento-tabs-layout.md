# 009 — Identidad Brasil, Eliminación de Halos y Redundancias, Optimización de Carga/Paginación y Layout con Tabs

- **Fecha:** 2026-11-05
- **Estado:** Completado
- **Backlog:** `BRA-001`, `UI-001`, `UI-002`, `REN-002`, `TAB-001`
- **Prioridad:** Crítica

## Contexto y Problemas Detectados

1. **Identidad de Marca y Gama de Colores de Brasil**:
   - El logotipo oficial de la tienda es **"la la la — CALZADOS BRASILEÑOS"** sobre la bandera de Brasil (Verde Bandeira `#009739`, Amarillo Oro `#FEDD00` / `#EAB308`, Azul Celestial `#012169` / `#002776`, Blanco `#FFFFFF`).
   - El sistema usaba el ícono genérico `<Store />` en el menú lateral/barra superior, un emblema ajeno (`LogoDeusUmbrae`) en el inicio de sesión y azul genérico (`#2563eb`) por defecto.
2. **Halos de Luz Invasivos**:
   - `HaloAmbientalCursor` dibujaba una mancha difuminada de `480x480px` persiguiendo al cursor con resortes físicos (`useSpring` a 60fps), ensuciando los fondos blancos y consumiendo CPU/GPU, acompañado de `DestellosEsquinasSistema`, `TarjetaFoco` y `BotonHalo`.
3. **Redundancias en Barra Superior, Barra Lateral y Páginas**:
   - El botón **"Cerrar sesión"** aparecía hasta 4 veces simultáneamente (2 en `BarraSuperior`, 2 en `MenuLateral`) y una 5ta vez en `/configuraciones`.
   - El perfil de usuario (`Administrador LaLaLa`) estaba duplicado en `BarraSuperior` y `MenuLateral`.
   - El título de la página aparecía duplicado en `BarraSuperior` y en el `<h1>` inmediatamente debajo (y en `/pos` había dos `<h1>` seguidos).
   - En `/` (Panel Operativo), los enlaces a los módulos del sistema se repetían 4 veces (en el menú lateral, en la barra "Acciones Rápidas", en la tira de "5 pasos del ciclo" y en las 3 tarjetas inferiores).
4. **Lentitud en Primera Carga y Navegación desde el Menú Lateral**:
   - `MenuLateral` ejecutaba `e.preventDefault()` en todos los `<Link>`, anulando la navegación suave y `prefetch` nativo de Next.js.
   - `listarCatalogoCompleto()` descargaba todo el inventario en bucle secuencial al entrar a `/inventario`, `/pos` e `/ingresos`.
   - `TiraTallasModelo` montaba un `<TooltipProvider>` + 10 `<Tooltip>` de Radix UI por fila (300–500 instancias por tabla), bloqueando la hidratación de React.
   - `VistaVentasRealizadas` pedía `limite: 150` ventas sin paginación en el DOM; `GET /ingresos/proveedores` hacía `SELECT DISTINCT` + `INSERT` en cada lectura; y `/gastos` sumaba métricas solo sobre los 10 ítems de la página actual.
5. **Falta de Layout Consistente con Tabs**:
   - Las vistas apilaban bloques verticalmente sin estructura de pestañas (`Tabs` de ShadCN UI).

## Tareas de Implementación

1. **Identidad Brasil y Logotipo Oficial (`BRA-001`)**:
   - Incorporar `logo-lalala-brasil.jpg` y vectorizar el emblema **"la la la — CALZADOS BRASILEÑOS"** en `LogoDeusUmbrae` y `LogoInstitucional`.
   - Configurar la paleta **Brasil** como tema predeterminado en `globals.css`, `tema-contexto.tsx`, `paleta-tema-calzado.ts` y `selector-tema.tsx`.
2. **Eliminación de Halos y Limpieza de Navegación (`UI-001`, `UI-002`)**:
   - Desactivar y remover `HaloAmbientalCursor`, `DestellosEsquinasSistema`, efectos spotlight en `TarjetaFoco`/`BotonHalo` y `EfectosAmbientalesSistema` en `ContenedorPrincipal`.
   - Limpiar `BarraSuperior` y `MenuLateral`: un único menú de perfil en `BarraSuperior`, cierre de sesión sin duplicaciones, eliminación de títulos redundantes y navegación nativa con `<Link prefetch={true}>`.
3. **Optimización de Carga, Caché SWR y Paginación Real (`REN-002`)**:
   - Crear `frontend/src/lib/cache-datos.ts` (caché en memoria con invalidación y *stale-while-revalidate*).
   - Optimizar `TiraTallasModelo` reemplazando los 10 `<Tooltip>` de Radix UI por fila con un visor ligero bajo demanda.
   - Añadir `GET /calzados/resumen` en backend, optimizar `GET /ingresos/proveedores` (sin escrituras en `GET`) y devolver totales reales en `GET /gastos`.
   - Paginar `VistaVentasRealizadas` (`limite: 12` con `<Paginacion />`).
4. **Layout Consistente con Tabs de ShadCN UI y Cero Redundancias (`TAB-001`)**:
   - Estructurar `/`, `/pos`, `/inventario`, `/ingresos`, `/gastos`, `/panel-central`, `/administracion` y `/configuraciones` con `Tabs` limpias, eliminando bloques repetidos y montando bajo demanda solo la pestaña activa.

## Criterios de Aceptación
- El software luce la identidad oficial de Brasil (**Verde `#009739`**, **Amarillo Oro `#FEDD00`**, **Azul `#012169`**) y el logo **"la la la — Calzados Brasileños"**.
- Cero halos de luz siguiendo al cursor o manchando los fondos.
- Sin elementos duplicados en `BarraSuperior`, `MenuLateral` ni en el cuerpo de las páginas.
- Navegación instantánea desde el menú lateral con paginación real y estructura de `Tabs` en todas las páginas.
- Compilación limpia (`0` errores TypeScript en `backend/` y `frontend/`).
