# BACKLOG TEMPORAL (Iteración Actual)

**Objetivo de la iteración:** que el sistema tenga los datos reales de la tienda, fórmulas financieras oficiales, ticket imprimible, soporte PWA offline y que el inventario deje de ser una maqueta.

## Completadas
- [x] **INF-005**: Reestructuración de `.agents/` basada en la hoja de cálculo (regla `03-dominio-negocio.md`, skill `consulta-hoja-calculo`, `pendientes/`, alineación con el stack NestJS + Next.js + PostgreSQL).
- [x] **DAT-001 / DAT-002 / DAT-004**: Importador desde la hoja (`gviz` CSV) + semillas completas en `semillas.sql` (149 productos, 20 ventas reales, 5 gastos) y hashes bcrypt depurados. → `pendientes/002-importacion-datos-hoja.md`
- [x] **DAT-003**: Normalización del catálogo de calzado y accesorios (`normalizacion-catalogo.ts`, marca, modelo y talla opcional para mochilas). → `pendientes/005-normalizacion-catalogo.md`
- [x] **NEG-001 / NEG-002 / NEG-003**: Fórmulas oficiales de Ganancia Bruta y Ganancia Neta restando el costo de lo vendido guardado en cada detalle, cálculo de `productoMayorIngreso` y conteo de Transferencias. → `pendientes/004-correccion-metricas-panel.md`
- [x] **NEG-004**: Costo promedio ponderado automático en ingresos de mercancía y validación de precios de compra. → `pendientes/006-ingresos-costo-promedio.md`
- [x] **NEG-005**: Descuentos con motivo obligatorio (`CLIENTE_FRECUENTE`, `PROMOCION`, `OTRO`), nota obligatoria para `OTRO` y módulo de Clientes Frecuentes (`/clientes`). → `pendientes/007-clientes-frecuentes-descuentos.md`
- [x] **NEG-006**: Correlativo atómico de ticket mediante secuencia PostgreSQL (`secuencia_ticket`) para prevenir colisiones en ventas simultáneas. → `pendientes/008-ticket-imprimible.md`
- [x] **NEG-007**: Forma de pago tipada en gastos como enum (`Efectivo`, `Transferencia`). → `pendientes/004-correccion-metricas-panel.md`
- [x] **POS-004**: Ticket térmico imprimible (`ticket-venta.tsx`) optimizado para impresoras térmicas de 58 mm y 80 mm con estilos `@media print`. → `pendientes/008-ticket-imprimible.md`
- [x] **ALM-005**: Aproximador dinámico de fotos en la nube según niveles de compresión WebP 0 al 5 con `WidgetAlmacenamiento` y endpoint `GET /almacenamiento/uso`. → `pendientes/009-aproximador-espacio-nube.md`
- [x] **MOB-001 / MOB-002 / MOB-003**: Soporte PWA instalable (`manifest.ts`, `sw.js`), ventas offline con cola en IndexedDB (`cola-ventas-offline.ts`), sincronización automática al recuperar la red y endpoint por lotes `POST /api/v1/ventas/sincronizar`. → `pendientes/001-pwa-soporte-offline-pos.md`
- [x] **FE-001 a FE-006**: Frontend 100% conectado a la API (Inventario, POS, Ingresos, Gastos, Panel Central), cero `any`, cero datos quemados, tablas ordenables y paginadas. → `pendientes/003-integracion-frontend-api.md`
- [x] **TR-001 / TR-002**: Tours interactivos guiados con `driver.js` para bienvenida, POS e Inventario.

## En cola (Próxima Iteración)
- [ ] **Fase 2**: Facturación electrónica y reportes contables avanzados en PDF/Excel.

*Nota: Todas las tareas completadas fueron auditadas y verificadas tanto en NestJS (`npm run compilar`) como en Next.js (`npm run build`).*
