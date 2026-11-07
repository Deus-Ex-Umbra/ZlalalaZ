# 004 — Compras / Ingresos: Editar Compras, Añadir Proveedor y Gestión de Nuevos Precios

- **Fecha:** 2026-11-04
- **Estado:** Completado
- **Backlog:** `COM-001`, `COM-002`, `COM-003`, `COM-004`
- **Prioridad:** Alta

## Resumen de la Implementación
1. **Backend (`backend/src/modulos/ingresos/`)**:
   - **Proveedores (`COM-002`)**:
     - Entidad `Proveedor` (`id`, `nombre` único, `telefono?`, `contacto?`, `activo`, `creadoEn`) registrada en `IngresosModulo` y `AppModulo`.
     - `CrearProveedorDto` para validación estricta con `class-validator`.
     - Endpoints `@Get("proveedores")` y `@Post("proveedores")` con siembra inicial automática en `onModuleInit` y combinación de nombres existentes de `ingresos_mercancia`.
   - **Editar Compras (`COM-001`)**:
     - DTO `ActualizarIngresoDto` con todos los campos opcionales.
     - Endpoint `@Put(":id")` respaldado por `IngresosServicio.actualizar(id, dto)` con `QueryRunner` transaccional: revierte cantidad anterior sobre el calzado original, verifica que el stock resultante no quede negativo (`ERR-ING-005`), traslada calzado si cambia el código, y recalcula el costo promedio ponderado y existencias.
     - Si el ingreso no existe, responde con `ERR-ING-004` (`NotFoundException`).
   - **Gestión de Precios Nuevos y Unidades No Vendidas (`COM-003`, `COM-004`)**:
     - Soporte para `modoActualizacionPrecio`: `"ACTUALIZAR_NO_VENDIDOS" | "ACTUALIZAR_MODELO_COMPLETO" | "CREAR_VARIANTE_NUEVO_PRECIO"`.
     - Opción `CREAR_VARIANTE_NUEVO_PRECIO`: si los precios difieren, crea un nuevo registro de `Calzado` con correlativo `P-N`, conservando el precio de los pares antiguos no vendidos.
     - Opción `ACTUALIZAR_MODELO_COMPLETO`: actualiza el precio de venta en todas las demás tallas del mismo modelo que tengan `stockActual > 0`.
     - Opción `ACTUALIZAR_NO_VENDIDOS`: actualiza el precio de venta del SKU y recalcula el costo promedio ponderado.

2. **Frontend (`frontend/src/app/ingresos/page.tsx` y servicios)**:
   - **Editar Compras (`COM-001`)**: Columna **Acciones** en la tabla con botón `Pencil` ("Editar") que abre el modal precargado y ejecuta `actualizarIngreso()`.
   - **Añadir Proveedor (`COM-002`)**: Selector desplegable de proveedores registrados con botón directo **"+ Añadir proveedor"** que abre diálogo modal rápido para crearlo sin salir del flujo.
   - **Banner de Advertencia de Precio Nuevo (`COM-003`, `COM-004`)**: Detección reactiva en tiempo real al ingresar precio distinto al del calzado en catálogo; muestra comparativa visual (`Bs Antiguo → Bs Nuevo`), desglose de unidades no vendidas (talla y modelo completo) y selector de decisión entre las 3 opciones de actualización.
   - **Internacionalización**: Integración de `Ingresos` en `useTraduccion` con diccionarios completos en español (`es`), inglés (`en`) y alemán (`de`) con cero texto quemado.

3. **Verificación**:
   - `npm run compilar --prefix backend` exitoso (código 0).
   - `next build` en frontend exitoso (código 0) sin errores de tipado o compilación.
