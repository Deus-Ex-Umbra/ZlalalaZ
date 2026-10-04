# Reglas: Backend (NestJS + TypeORM + PostgreSQL + Cloudflare R2)

## 1. Arquitectura Modular en Español
- `src/modulos/calzados/`: Catálogo (pestaña **Inventario**), variantes por talla y color, control de stock.
- `src/modulos/ingresos/`: Recepción de mercancía de proveedores (pestaña **Ingreso Mercancia**).
- `src/modulos/ventas/`: Punto de venta, transacciones, descuentos y formas de pago (pestaña **Ventas**).
- `src/modulos/gastos/`: Gastos de caja chica de empleados (pestaña **Gastos Extra**).
- `src/modulos/panel-central/`: KPIs, destacados y buscador por ID (pestaña **Panel Central**).
- `src/modulos/almacenamiento/`: Servicio unificado Cloudflare R2 (protocolo S3) con fallback a Supabase y local.
- `src/modulos/autenticacion/` y `src/modulos/usuarios/`: JWT y roles (`ADMINISTRACION`, `VENTAS`).

## 2. Integridad Transaccional
- Toda operación que modifique stock (venta, ingreso, anulación) se ejecuta dentro de un `QueryRunner` con transacción y rollback.
- El stock NUNCA puede quedar negativo (ver `03-dominio-negocio.md`).
- Los correlativos (ej. número de ticket) deben generarse con secuencias de PostgreSQL, no con `COUNT()`.

## 3. Almacenamiento S3 / Cloudflare R2
- Uso de `@aws-sdk/client-s3` configurado con el endpoint de Cloudflare R2 (`https://<account_id>.r2.cloudflarestorage.com`), Access Key ID y Secret Access Key.
- 10 GB de almacenamiento gratuito y 0$ en costes de transferencia (Egress).

## 4. Manejo Estandarizado de Errores
- Todo error interceptado por el filtro global debe devolver:
  `{ error: true, codigo: "ERR-CALZ-001", mensaje: "Mensaje legible", detalles: "Info técnica", timestamp: "..." }`
- Registro obligatorio en `backend/errores.md`.

## 5. Validación Estricta
- DTOs protegidos con `class-validator` y `class-transformer`. Prohibido procesar `Body` sin tipar.
- Montos monetarios: columnas `decimal(10,2)`; convertir con `Number()` al leer de TypeORM.
