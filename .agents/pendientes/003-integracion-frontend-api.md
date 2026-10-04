# 003 — Integración del Frontend con la API

- **Estado:** Completado
- **Backlog:** FE-001 a FE-006
- **Prioridad:** Alta

## Contexto
Las páginas `inventario`, `pos`, `ingresos`, `gastos` y `panel-central` funcionan con arreglos quemados (`DATOS_INICIALES`, `CATALOGO_INICIAL`, `INGRESOS_INICIALES`, `GASTOS_INICIALES`, `BASE_DATOS_CONSULTA`) y usan `any` (`pos/page.tsx`, `panel-central/page.tsx`). Solo `lib/autenticacion-contexto.tsx` llama al backend.

## Tareas
1. `frontend/src/lib/cliente-api.ts`: wrapper de `fetch` con `NEXT_PUBLIC_API_URL`, token JWT y conversión de errores `{ codigo, mensaje }` a notificaciones.
2. `frontend/src/tipos/`: interfaces de `Calzado`, `Venta`, `DetalleVenta`, `IngresoMercancia`, `GastoCajaChica`, `MetricasGenerales`, `FichaConsultaProducto` (alineadas con el backend).
3. Conectar cada página, en este orden: Inventario → POS → Ingresos → Gastos → Panel Central. Eliminar las constantes de datos quemados.
4. Estados de carga/vacío/error con componentes ShadCN y textos i18n.
5. Mover a i18n el texto quemado del pie de página en `app/layout.tsx`.

## Criterios de Aceptación
- `grep` de `DATOS_INICIALES|CATALOGO_INICIAL|INGRESOS_INICIALES|GASTOS_INICIALES|BASE_DATOS_CONSULTA|: any|<any>` en `frontend/src` no devuelve resultados.
- Una venta hecha en el POS descuenta stock visible en Inventario y suma en el Panel sin recargar datos de ejemplo.
- `npm run build:frontend` y `npm run lint:frontend` sin errores.
