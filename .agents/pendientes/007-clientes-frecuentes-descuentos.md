# 007 — Clientes Frecuentes y Descuentos con Motivo

- **Estado:** Pendiente
- **Backlog:** NEG-005
- **Prioridad:** Baja

## Contexto
En la hoja, 7 de 21 ventas tienen descuento (Bs 5 a Bs 30) con notas como "cliente frecuente", "cliente consecuente" o "cliente antiguo". El cliente es solo un nombre de texto y hay variantes (`Juan  Chuquimia` con doble espacio).

## Tareas
1. Entidad `Cliente` (nombre normalizado, teléfono opcional, fecha de primera compra) y relación opcional desde `Venta`.
2. En el POS: autocompletar cliente, mostrar su número de compras previas.
3. Descuento: exigir motivo de un catálogo (`CLIENTE_FRECUENTE`, `PROMOCION`, `OTRO` + nota) cuando descuento > 0.
4. Límite de descuento configurable por rol (ej. `VENTAS` hasta Bs 30; `ADMINISTRACION` sin límite).

## Criterios de Aceptación
- No se puede registrar un descuento sin motivo.
- El panel puede listar los clientes con más compras.
