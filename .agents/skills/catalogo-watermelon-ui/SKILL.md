---
name: catalogo-watermelon-ui
description: "Guía y catálogo integral de Watermelon UI (https://ui.watermelon.sh) para Tailwind CSS, shadcn/ui y React: más de 800 bloques de producción, dashboards, tablas de datos y paneles de gestión adaptados a LaLaLa."
---

# Catálogo Integral de Componentes Watermelon UI - LaLaLa (Calzado & POS)

> 🔗 **Documentación Oficial de Referencia**: [https://ui.watermelon.sh](https://ui.watermelon.sh)
> Watermelon UI es un registro masivo de más de 800 componentes y bloques completos de producción basados en **Tailwind CSS**, **shadcn/ui**, **Radix UI** y **Motion**.

Esta skill define la integración de los patrones, bloques de administración y estructuras de alta densidad de datos de **Watermelon UI** dentro de LaLaLa para simplificar la interfaz, ordenar flujos de trabajo y eliminar redundancias entre pantallas.

---

## 🛠️ Directivas de Integración y Buenas Prácticas

1. **Enfoque en Bloques Completos de Negocio**:
   - A diferencia de librerías atómicas, Watermelon UI destaca por proveer **bloques compuestos listos para producción** (barras de filtrado integradas con contadores, tablas de datos con acciones contextuales, tarjetas de resumen analítico con comparativas de períodos).
2. **Organización en el Proyecto**:
   - Colocar los bloques adaptados en `frontend/src/componentes/ui/watermelon/` o integrarlos en las páginas correspondientes (`inventario/`, `pos/`, `ingresos/`, `gastos/`).
3. **Ergonomía y Usabilidad (Solución al Feedback del Usuario)**:
   - Todo bloque debe contar con:
     - **Verbos de acción explícitos**: Botones claros con icono + texto (`"Registrar Venta"`, `"Importar Lote"`, `"Consultar Ficha"`), evitando iconos huérfanos sin etiqueta.
     - **Migas de pan y contexto visual**: El usuario siempre debe saber en qué módulo está y qué puede hacer a continuación.
     - **Prevención de redundancias**: Evitar duplicar las mismas métricas o tablas en múltiples rutas; centralizar la consulta en un único punto focal.
4. **Español Absoluto, Tipado Estricto e i18n**:
   - Cero texto quemado (`t('clave')`).
   - Cero `any`: todas las filas de tabla y filtros deben estar tipadas con las interfaces de `tipos/`.

---

## 📚 Catálogo de Bloques y Componentes Watermelon UI

### 1. Paneles de Resumen Ejecutivo y Bloques de Métricas
- **`Metric Stat Block with Trend Comparison` (Bloque de Estadística con Tendencia)**:
  - Tarjeta de métrica con comparativa porcentual frente al período anterior (día, mes, año), mini gráfico de chispa (*sparkline*) e indicador semántico de tendencia (verde sube, rojo baja).
  - *Uso en LaLaLa*: Panel Central (`/`) para mostrar Ingresos Totales, Ganancia Neta y Ticket Promedio con comparativa frente al mes anterior.
- **`Financial Health Summary Widget` (Widget de Salud Financiera de Caja)**:
  - Desglose instantáneo en una sola vista: Ingresos en Efectivo vs. Transferencias QR vs. Gastos de Caja Chica = Efectivo en Caja Disponible.
  - *Uso en LaLaLa*: Arqueo de caja rápido para el cierre de turno del vendedor.

### 2. Tablas de Datos Avanzadas con Barra de Filtrado
- **`Data Table with Unified Filter Toolbar` (Tabla con Barra Unificada de Filtros)**:
  - Combina en una única barra: búsqueda de texto predictiva, selector multifiltro desplegable (marca, talla, estado de stock) y botones de acción rápida (Exportar CSV, Imprimir, Añadir).
  - *Uso en LaLaLa*: **Pantalla de Inventario (`/inventario`)**, resolviendo la dispersión de filtros y permitiendo al usuario encontrar en segundos cualquier calzado por talla o modelo.
- **`Inline Editable Table Row` (Fila de Tabla con Edición Rápida)**:
  - Permite ajustar precio de venta o stock mínimo directamente en la tabla con confirmación inmediata vía check verde.
  - *Uso en LaLaLa*: Ajuste rápido de precios de liquidación o promociones temporales.

### 3. Asistentes Paso a Paso y Formularios Guiados
- **`Multi-Step Wizard Modal` (Asistente Modal Multietapa)**:
  - Modal guiado con barra de progreso superior que divide procesos complejos en 3 pasos simples:
    - *Paso 1*: Selección de Proveedor y Fecha de Factura.
    - *Paso 2*: Selección de Modelos, Tallas recibidas y Precio de Compra.
    - *Paso 3*: Confirmación de Costo Promedio Ponderado y Generación de Lote.
  - *Uso en LaLaLa*: **Ingreso de Mercancía (`/ingresos`)**, eliminando cualquier confusión o miedo del usuario a equivocarse al registrar entradas masivas.
- **`Quick Expense Dialog` (Modal de Gasto Inmediato)**:
  - Formulario compacto de 3 campos: Monto, Motivo (Categoría) y Forma de Pago (Efectivo/Transferencia) con botón de confirmación de un solo clic.
  - *Uso en LaLaLa*: **Gastos de Caja Chica (`/gastos`)**.

### 4. Paneles de Detalle y Fichas de Auditoría
- **`Two-Column Detail View` (Vista de Ficha a Dos Columnas)**:
  - Columna izquierda: Foto ampliada del calzado, código de barras y estado general de stock.
  - Columna derecha: Historial cronológico de compras (entradas), historial de ventas con precios aplicados y métricas acumuladas (total facturado, margen de ganancia).
  - *Uso en LaLaLa*: **Ficha Técnica del Calzado (`/panel-central`)**.

### 5. Estados Vacíos Educativos y de Ayuda
- **`Actionable Empty State` (Estado Vacío con Acción Inmediata)**:
  - Muestra un mensaje explicativo cordial, ilustración y un botón grande con la acción que el usuario debe ejecutar para resolver el estado vacío.
  - *Uso en LaLaLa*:
    - "No tienes calzados registrados todavía" → Botón `[+ Registrar Primer Calzado]` o `[📥 Importar desde Google Sheets]`.
    - "El carrito de ventas está vacío" → Botón `[🔍 Buscar por Código (F2)]`.

---

## 🧩 Patrón de Implementación Ejemplo: Barra Unificada de Filtro y Acción

```tsx
"use client";

import React from "react";
import { Search, Filter, Plus, Download, X } from "lucide-react";
import { Input } from "@/componentes/ui/input";
import { Button } from "@/componentes/ui/button";
import { Badge } from "@/componentes/ui/badge";

interface PropsBarraFiltrosUnificada {
  terminoBusqueda: string;
  alCambiarBusqueda: (_termino: string) => void;
  filtrosActivos: {
    categoria?: string;
    talla?: string;
    soloStockCritico?: boolean;
  };
  alLimpiarFiltros: () => void;
  alHacerClicNuevo: () => void;
  etiquetaNuevoBoton: string;
  totalResultados: number;
}

export function BarraFiltrosUnificada({
  terminoBusqueda,
  alCambiarBusqueda,
  filtrosActivos,
  alLimpiarFiltros,
  alHacerClicNuevo,
  etiquetaNuevoBoton,
  totalResultados,
}: PropsBarraFiltrosUnificada) {
  const tieneFiltros =
    Boolean(filtrosActivos.categoria) ||
    Boolean(filtrosActivos.talla) ||
    Boolean(filtrosActivos.soloStockCritico);

  return (
    <div className="flex flex-col gap-3 rounded-xl border border-border bg-card p-4 shadow-sm sm:flex-row sm:items-center sm:justify-between">
      <div className="flex flex-1 items-center gap-2">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
          <Input
            value={terminoBusqueda}
            onChange={(_e) => alCambiarBusqueda(_e.target.value)}
            placeholder="Buscar por código, marca, modelo o color..."
            className="pl-9 text-sm"
          />
        </div>
        {tieneFiltros && (
          <Button
            variant="ghost"
            size="sm"
            onClick={alLimpiarFiltros}
            className="text-xs text-muted-foreground hover:text-foreground"
          >
            <X className="mr-1 h-3.5 w-3.5" />
            Limpiar filtros
          </Button>
        )}
      </div>

      <div className="flex items-center gap-2 self-end sm:self-auto">
        <Badge variant="secondary" className="tabular-nums font-mono text-xs">
          {totalResultados} registros
        </Badge>
        <Button onClick={alHacerClicNuevo} size="sm" className="gap-1.5 font-medium">
          <Plus className="h-4 w-4" />
          {etiquetaNuevoBoton}
        </Button>
      </div>
    </div>
  );
}
```
