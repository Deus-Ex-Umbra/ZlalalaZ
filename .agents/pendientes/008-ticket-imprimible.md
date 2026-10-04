# 008 — Ticket Imprimible y Correlativo Seguro

- **Estado:** Pendiente
- **Backlog:** POS-004, NEG-006
- **Prioridad:** Media

## Contexto
`ventas.servicio.ts` genera `numeroTicket` con `COUNT(ventas) + 1`: dos ventas simultáneas pueden obtener el mismo número y fallar por el índice único. No existe impresión de ticket.

## Tareas
1. Secuencia PostgreSQL `secuencia_ticket` (migración) y uso de `nextval` dentro de la transacción de venta. Formato `TCK-AAAAMM-NNNN`.
2. Componente `frontend/src/componentes/pos/ticket-venta.tsx` con estilos `@media print` para 58 mm y 80 mm (configurable).
3. Botón "Imprimir" tras el cobro que llama a `window.print()`; reimpresión desde el historial de ventas.
4. Contenido: nombre de la tienda, número de ticket, fecha, cajero, líneas (producto, talla, cantidad, precio, descuento), total, forma de pago, monto recibido y cambio. Textos vía i18n.

## Criterios de Aceptación
- 20 ventas concurrentes generan 20 números de ticket distintos.
- El ticket se imprime correctamente en una impresora térmica de 80 mm desde Chrome.
