---
name: catalogo-cult-ui
description: "Guía y catálogo exhaustivo de componentes interactivos y de ingeniería de diseño de Cult UI (https://www.cult-ui.com) para Tailwind CSS, Framer Motion y shadcn/ui, adaptado a LaLaLa."
---

# Catálogo Integral de Componentes Cult UI - LaLaLa (Calzado & POS)

> 🔗 **Documentación Oficial de Referencia**: [https://www.cult-ui.com](https://www.cult-ui.com)
> Cult UI es una biblioteca de componentes de código abierto para React y Tailwind CSS, especializada en componentes animados de nicho y estética "Silicon Valley" para dashboards e interfaces interactivas de alta fidelidad.

Esta skill proporciona el catálogo de componentes de **Cult UI** y las reglas para integrarlos armónicamente en el sistema LaLaLa sin romper la sobriedad empresarial ni el rendimiento.

---

## 🛠️ Directivas de Integración

1. **Integración con CLI y Registro shadcn**:
   - Cult UI funciona como registro compatible con shadcn/ui:
     ```bash
     npx shadcn@latest add @cult-ui/<nombre-componente>
     ```
   - O copiando directamente el código fuente a `frontend/src/componentes/ui/cult/`.
2. **Coherencia con el Sistema de Diseño**:
   - Utilizar las variables CSS de LaLaLa (`--background`, `--foreground`, `--primary`, `--border`, `--radius`).
   - Evitar saturación de efectos: reservar los efectos especiales (halos, gradientes dinámicos) exclusivamente para llamadas a la acción primarias o estados de sistema importantes.
3. **Reglas de Código de LaLaLa**:
   - Nombres de archivos en español (`isla-dinamica.tsx`, `boton-halo.tsx`, `cuadricula-bento.tsx`).
   - Callbacks con prefijo `_` (`const manejarClic = (_evento: React.MouseEvent) => { ... }`).
   - Cero texto quemado (`t('modulo.clave')`).

---

## 📚 Índice y Casos de Uso de Componentes Cult UI

### 1. Elementos Flotantes y de Estado
- **`Dynamic Island` (Isla Dinámica Flotante)**:
  - Cápsula flotante animada en la parte superior que se expande o contrae dinámicamente con transiciones elásticas.
  - *Uso en LaLaLa*: Notificador central de estado: sincronización de ventas offline (IndexedDB → Backend), alerta de conexión a internet o resumen de venta recién completada con ticket generado.
- **`Dock` (Muelle Flotante de Acciones)**:
  - Barra de herramientas con magnificación al pasar el cursor (estilo dock interactivo).
  - *Uso en LaLaLa*: Barra de herramientas rápida flotante en pantallas táctiles de POS para cambiar entre escaneo de código, teclado numérico, calculadora de cambio y búsqueda manual.

### 2. Botones y Controles de Acción Avanzados
- **`Halo Button` (Botón con Halo Difuso)**:
  - Botón con resplandor suave perimetral reactivo al movimiento del ratón.
  - *Uso en LaLaLa*: Botón de acción destacada como **"Completar Venta"** o **"Apertura de Caja"**.
- **`Gradient Border Button` (Botón con Borde Gradiente)**:
  - Borde animado con gradiente lineal sutil.
  - *Uso en LaLaLa*: Botones de promociones especiales o asignación de descuento por cliente frecuente.
- **`Copy Button with Morph` (Botón de Copia con Transformación)**:
  - Botón que transforma su icono y etiqueta de "Copiar" a "¡Copiado!" con animación fluida.
  - *Uso en LaLaLa*: Copiar código de barras o correlativo de ticket en la ficha técnica del calzado.

### 3. Tarjetas, Grids y Distribución de Información
- **`Bento Grid` (Cuadrícula Bento Modular)**:
  - Sistema de tarjetas asimétricas interconectadas para presentar métricas clave, productos destacados y actividad reciente de forma moderna y balanceada.
  - *Uso en LaLaLa*: Rediseño del **Panel de Control principal (`/`)**, organizando en un solo golpe de vista: Ingresos del día, Ganancia Neta, Stock Crítico, Calzado más Vendido y Accesos Rápidos.
- **`Minimal Card` (Tarjeta Minimalista con Profundidad)**:
  - Tarjeta de líneas puras con micro-sombra refinada y soporte para elevación hover de 2px.
  - *Uso en LaLaLa*: Tarjetas del catálogo de calzados y filas de selección en el POS.
- **`Shift Card` (Tarjeta con Desplazamiento de Capas)**:
  - Al interactuar, desplaza los datos secundarios y revela controles de acción rápida.
  - *Uso en LaLaLa*: Tarjetas de inventario para mostrar rápidamente tallas disponibles y botón de edición.

### 4. Entradas de Texto y Búsqueda
- **`Spotlight Search Input` (Buscador con Foco Resaltado)**:
  - Campo de búsqueda interactivo con iluminación perimetral y soporte para atajos de teclado (`Ctrl + K`).
  - *Uso en LaLaLa*: Barra de búsqueda universal de calzados por código, modelo, color y marca.
- **`Expanding Input` (Entrada Auto-Expandible)**:
  - Campo de texto que expande su ancho suavemente al recibir el foco.
  - *Uso en LaLaLa*: Buscador compacto en la barra superior de navegación.

### 5. Tipografía y Textos Animados
- **`Text Morph` (Morfismo de Texto)**:
  - Transición fluida entre caracteres o palabras (ideal para números que cambian).
  - *Uso en LaLaLa*: Transición de totales monetarios en el carrito POS cuando se añaden calzados o se aplican descuentos.
- **`Shimmer Text` (Texto con Destello Metálico)**:
  - Reflejo de luz continuo sobre el texto.
  - *Uso en LaLaLa*: Indicador de "Modo Offline Activo" o "Licencia de Sistema Verificada".

---

## 🧩 Patrón de Implementación Ejemplo: Isla Dinámica para Estado de Sincronización

```tsx
"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { CheckCircle2, WifiOff, RefreshCw, ChevronDown } from "lucide-react";
import { cn } from "@/lib/utils";

interface PropsIslaDinamica {
  enLinea: boolean;
  ventasPendientes: number;
  alSincronizar: () => void;
  sincronizando: boolean;
}

export function IslaDinamicaEstado({
  enLinea,
  ventasPendientes,
  alSincronizar,
  sincronizando,
}: PropsIslaDinamica) {
  const [expandido, setExpandido] = useState(false);

  return (
    <div className="fixed top-4 left-1/2 z-50 -translate-x-1/2">
      <motion.div
        layout
        transition={{ type: "spring", stiffness: 350, damping: 28 }}
        onClick={() => setExpandido(!expandido)}
        className={cn(
          "cursor-pointer overflow-hidden rounded-full border border-border bg-card/95 text-card-foreground shadow-lg backdrop-blur-md",
          expandido ? "rounded-2xl p-4 min-w-[320px]" : "px-4 py-2 flex items-center gap-2"
        )}
      >
        {!expandido ? (
          <div className="flex items-center gap-2 text-xs font-medium">
            {enLinea ? (
              <span className="flex h-2 w-2 rounded-full bg-emerald-500 animate-pulse" />
            ) : (
              <WifiOff className="h-3.5 w-3.5 text-amber-500" />
            )}
            <span>
              {enLinea
                ? ventasPendientes > 0
                  ? `${ventasPendientes} pendientes de sincronizar`
                  : "Sistema en línea"
                : "Modo sin conexión activo"}
            </span>
          </div>
        ) : (
          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-sm font-semibold">Estado de Red y Caja</span>
              <span className="text-xs text-muted-foreground">Toca para colapsar</span>
            </div>
            <p className="text-xs text-muted-foreground">
              {enLinea
                ? "Conexión estable con el servidor NestJS."
                : "Las ventas se guardan localmente en IndexedDB y se sincronizarán al recuperar la red."}
            </p>
            {ventasPendientes > 0 && (
              <button
                type="button"
                onClick={(_e) => {
                  _e.stopPropagation();
                  alSincronizar();
                }}
                disabled={!enLinea || sincronizando}
                className="w-full flex items-center justify-center gap-2 rounded-lg bg-primary py-2 text-xs font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
              >
                <RefreshCw className={cn("h-3.5 w-3.5", sincronizando && "animate-spin")} />
                Sincronizar ahora ({ventasPendientes})
              </button>
            )}
          </div>
        )}
      </motion.div>
    </div>
  );
}
```
