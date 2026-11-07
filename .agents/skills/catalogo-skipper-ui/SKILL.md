---
name: catalogo-skipper-ui
description: "Guía y catálogo integral de componentes y micro-interacciones de Skiper UI (https://skiper-ui.com) para Tailwind CSS, React, Framer Motion y shadcn/ui, adaptado al estándar de LaLaLa."
---

# Catálogo y Guía de Integración Skiper UI - LaLaLa (Calzado & POS)

> 🔗 **Documentación Oficial de Referencia**: [https://skiper-ui.com](https://skiper-ui.com)
> Skiper UI (frecuentemente llamado *Skipper UI*) es una librería de componentes y bloques con alta carga de movimiento e interactividad ("motion-forward"), diseñada sobre el ecosistema **shadcn/ui**, **Tailwind CSS** y **Framer Motion**.

Esta skill define la integración, catálogo y buenas prácticas para incorporar componentes de Skiper UI en el frontend de LaLaLa con micro-interacciones fluidas, transiciones de alto impacto visual y cero impacto negativo en rendimiento o accesibilidad.

---

## 🛠️ Directivas de Integración y Arquitectura

1. **Filosofía Copy-Paste y Compatibilidad con shadcn/ui**:
   - Los componentes de Skiper UI se incorporan directamente en `frontend/src/componentes/ui/skiper/` o se adaptan en los componentes base existentes.
   - Comparten las mismas variables de diseño (`globals.css`) y tokens de color que shadcn/ui.
2. **Dependencias del Ecosistema**:
   - Requiere `framer-motion` (o `motion`), `lucide-react`, `clsx` y `tailwind-merge`.
   - Se instalan con `npm install framer-motion` en el directorio `frontend/`.
3. **Respeto a la Accesibilidad y Reducción de Movimiento**:
   - Toda animación debe contemplar `prefers-reduced-motion` utilizando la directiva `motion.div` con variantes condicionales o el hook `useReducedMotion()`.
4. **Español Absoluto e i18n Obligatorio**:
   - Todo texto descriptivo, tooltips y etiquetas deben obtenerse de `t('modulo.clave')`.
   - Nombres de archivos en kebab-case (`tarjeta-flotante.tsx`, `carrusel-calzado.tsx`) y funciones en camelCase con parámetros `_parametro`.

---

## 📚 Catálogo de Componentes y Casos de Uso en LaLaLa

### 1. Botones y Micro-Interacciones de Acción
- **`Magnetic Button` (Botón Magnético)**:
  - Botón con atracción hacia el cursor al interactuar con el mouse.
  - *Uso en LaLaLa*: Botón principal de **"Cobrar Venta (F4)"** en el POS y botón de **"Guardar Entrada"** en recepción de mercancía para maximizar la satisfacción del operador.
- **`Glow Border Button` (Botón con Borde Brillante)**:
  - Botón con halo lumínico en el perímetro al pasar el ratón.
  - *Uso en LaLaLa*: Botón de "Iniciar Tour Interactivo" o "Crear Nuevo Calzado".
- **`Ripple Feedback Button` (Botón con Efecto Onda)**:
  - Feedback táctil inmediato al presionar o hacer clic.
  - *Uso en LaLaLa*: Botones táctiles grandes del POS en modo móvil/tablet para confirmar toques físicos en pantalla.

### 2. Tarjetas y Presentación de Catálogo
- **`Interactive Tilt Card` (Tarjeta con Inclinación 3D)**:
  - Tarjeta que responde a la posición del cursor con perspectiva sutil en el eje X/Y.
  - *Uso en LaLaLa*: Tarjeta de producto estrella en el Panel Central ("Calzado de Mayor Ingreso") y tarjetas de calzados en vitrina.
- **`Stacked Hover Card` (Tarjeta Apilada con Expansión)**:
  - Muestra capas traseras que se despliegan suavemente al pasar el ratón (indicando múltiples tallas o colores disponibles).
  - *Uso en LaLaLa*: Mostrar variantes de talla de un mismo modelo en la vista de cuadrícula de Inventario.
- **`Spotlight Card` (Tarjeta con Foco Dinámico)**:
  - Resalta el borde o fondo en función del ángulo del cursor.
  - *Uso en LaLaLa*: Tarjetas de métricas financieras (Ingresos, Ganancia Bruta, Ganancia Neta, Stock Crítico).

### 3. Diálogos, Paneles y Superposiciones
- **`Stacked Dialog` (Diálogo Apilado)**:
  - Ventana modal con efecto de capas flotantes apiladas para flujos de confirmación en dos pasos.
  - *Uso en LaLaLa*: Confirmación de cobro POS: Paso 1 (Selección de método de pago y monto recibido) → Paso 2 (Confirmación de vuelto e impresión de ticket).
- **`Expandable Drawer Menu` (Cajón Deslizable con Resorte)**:
  - Despliegue con física de resorte (*spring physics*) para dispositivos táctiles.
  - *Uso en LaLaLa*: Carrito lateral del POS en teléfonos y tabletas.

### 4. Carruseles y Visualización de Calzados
- **`Fluid Carousel` (Carrusel Fluido)**:
  - Navegación táctil y con arrastre para galerías de fotos de calzados con deceleración natural.
  - *Uso en LaLaLa*: Vista de detalle de calzado para mostrar vistas lateral, superior, suela y caja.
- **`Image Cursor Trail` (Rastro de Previsualización)**:
  - Revela miniaturas de calzado siguiendo el cursor sobre listas densas de inventario.
  - *Uso en LaLaLa*: Previsualización rápida de modelos en tablas de inventario sin abrir la ficha completa.

### 5. Indicadores y Estados Vacíos
- **`Animated Empty State` (Estado Vacío Animado)**:
  - Ilustración o icono con animación suave continua para listas vacías.
  - *Uso en LaLaLa*: Carrito POS vacío ("Escanea un código o selecciona un calzado para comenzar") y búsquedas sin coincidencia.
- **`Pulse Notification Badge` (Píldora con Pulso de Advertencia)**:
  - Badge con halo pulsante para alertar sobre eventos críticos.
  - *Uso en LaLaLa*: Indicador de stock crítico (≤ 2 pares) o alerta de ventas offline pendientes de sincronización.

---

## 🧩 Patrón de Implementación Ejemplo: Tarjeta con Foco (Spotlight Card)

```tsx
"use client";

import React, { useRef, useState } from "react";
import { cn } from "@/lib/utils";

interface PropsTarjetaFoco {
  titulo: string;
  subtitulo?: string;
  valor: string;
  icono: React.ReactNode;
  className?: string;
}

export function TarjetaFoco({
  titulo,
  subtitulo,
  valor,
  icono,
  className,
}: PropsTarjetaFoco) {
  const contenedorRef = useRef<HTMLDivElement>(null);
  const [posicion, setPosicion] = useState<{ x: number; y: number }>({ x: 0, y: 0 });
  const [estaSobre, setEstaSobre] = useState(false);

  const manejarMovimientoRaton = (_evento: React.MouseEvent<HTMLDivElement>) => {
    if (!contenedorRef.current) return;
    const rectangulo = contenedorRef.current.getBoundingClientRect();
    setPosicion({
      x: _evento.clientX - rectangulo.left,
      y: _evento.clientY - rectangulo.top,
    });
  };

  return (
    <div
      ref={contenedorRef}
      onMouseMove={manejarMovimientoRaton}
      onMouseEnter={() => setEstaSobre(true)}
      onMouseLeave={() => setEstaSobre(false)}
      className={cn(
        "relative overflow-hidden rounded-xl border border-border bg-card p-5 text-card-foreground shadow-sm transition-all duration-200",
        className
      )}
    >
      {/* Efecto Spotlight */}
      <div
        className="pointer-events-none absolute -inset-px opacity-0 transition-opacity duration-300"
        style={{
          opacity: estaSobre ? 1 : 0,
          background: `radial-gradient(400px circle at ${posicion.x}px ${posicion.y}px, rgba(var(--primary-rgb), 0.12), transparent 80%)`,
        }}
      />
      <div className="relative z-10 flex items-center justify-between">
        <span className="text-sm font-medium text-muted-foreground">{titulo}</span>
        <div className="rounded-lg bg-primary/10 p-2 text-primary">{icono}</div>
      </div>
      <div className="relative z-10 mt-3">
        <div className="text-2xl font-bold tracking-tight tabular-nums">{valor}</div>
        {subtitulo && (
          <p className="mt-1 text-xs text-muted-foreground">{subtitulo}</p>
        )}
      </div>
    </div>
  );
}
```
