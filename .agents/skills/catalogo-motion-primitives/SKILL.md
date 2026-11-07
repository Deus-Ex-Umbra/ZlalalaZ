---
name: catalogo-motion-primitives
description: "Guía y catálogo integral de Motion Primitives (https://motion-primitives.com) para Next.js, React, Tailwind CSS y Motion: bloques primitivos de animación, transiciones morphing y efectos visuales adaptados a LaLaLa."
---

# Catálogo Integral de Motion Primitives - LaLaLa (Calzado & POS)

> 🔗 **Documentación Oficial de Referencia**: [https://motion-primitives.com](https://motion-primitives.com)
> Motion Primitives (creado por Julien Thibeaut / ibelick) proporciona bloques atómicos reutilizables de animación ("motion building blocks") construidos sobre **Motion** (Framer Motion) y **Tailwind CSS**.

Esta skill define la integración de Motion Primitives en LaLaLa para enriquecer la experiencia de usuario mediante transiciones naturales, números animados para totales de caja y transformaciones elásticas (*shared layout morphing*) que hacen que la interfaz sea visualmente intuitiva y fácil de comprender.

---

## 🛠️ Directivas de Integración y Rendimiento

1. **Ubicación en el Proyecto**:
   - Integrar los componentes en `frontend/src/componentes/ui/motion-primitives/` respetando los tokens de `globals.css`.
2. **Propósito Práctico (Mejora de Usabilidad)**:
   - Las animaciones no deben ser meramente decorativas: su función principal es **guiar la atención del usuario** y comunicar cambios de estado (ej. un producto entrando al carrito, un número de venta actualizándose, una alerta de stock).
3. **Optimización con `AnimatePresence` y `layoutId`**:
   - Para transformaciones compartidas (como expandir una tarjeta de calzado hacia un modal o diálogo sin parpadeos), utilizar siempre `layoutId` de Framer Motion.
4. **Español Absoluto, Parámetros con `_` y Tipado**:
   - Funciones y componentes en español (`numero-animado.tsx`, `dialogo-morfico.tsx`, `deslizador-infinito.tsx`).
   - Parámetros de eventos con prefijo `_`.

---

## 📚 Catálogo Exhaustivo de Motion Primitives

### 1. Efectos de Texto y Cifras Monetarias
- **`Animated Number` (Número Animado)**:
  - Transición fluida de conteo numérico con física elástica (odómetro digital).
  - *Uso en LaLaLa*: Total a pagar en el carrito POS, contadores de pares en stock en el inventario y métricas de Ganancia Neta en el panel de control.
- **`Text Morph` (Morfismo de Texto)**:
  - Interpola suavemente las letras y números cuando un texto cambia de valor.
  - *Uso en LaLaLa*: Cambio de estado del botón de cobro (`"Cobrar (F4)"` → `"Procesando..."` → `"¡Venta Completada!"`).
- **`Text Loop` (Bucle de Mensajes Rotativos)**:
  - Alterna entre diferentes mensajes con transición vertical suave.
  - *Uso en LaLaLa*: Banner informativo en la barra superior ("Promoción: 10% en calzado formal", "Recuerda realizar el arqueo de caja", "Modo offline disponible").
- **`Text Effect` (Aparición Palabra por Palabra o Carácter)**:
  - Revela titulares o mensajes con un desvanecimiento secuencial.
  - *Uso en LaLaLa*: Títulos de bienvenida y mensajes de confirmación de tickets.

### 2. Modales, Diálogos y Menús Mórficos
- **`Morphing Dialog` (Diálogo Mórfico con Layout Compartido)**:
  - Una tarjeta o fila de calzado se expande de forma continua y elástica hasta convertirse en el modal de ficha completa, sin saltos de renderizado.
  - *Uso en LaLaLa*: Al hacer clic en un zapato de la cuadrícula de inventario, la tarjeta crece suavemente para mostrar el detalle de tallas, compras anteriores y precios.
- **`Morphing Popover` (Popover Mórfico)**:
  - Un botón se transforma en un contenedor flotante que aloja un selector o formulario pequeño.
  - *Uso en LaLaLa*: Selector rápido de descuentos en el carrito POS (de botón `%` a selector con motivos: `CLIENTE_FRECUENTE`, `PROMOCION`, `OTRO`).
- **`Animated Tabs` (Pestañas con Indicador Deslizante)**:
  - Pestañas con una píldora de fondo que se desliza con física de resorte hacia la pestaña seleccionada.
  - *Uso en LaLaLa*: Selector de categorías de calzado (`Todos`, `Hombre`, `Mujer`, `Niños`, `Mochilas/Accesorios`) y selector de períodos en el panel financiero (`Hoy`, `Este Mes`, `Este Año`).

### 3. Controles y Barras de Herramientas
- **`Toolbar Expandable` (Barra de Herramientas Dinámica)**:
  - Barra compacta que se expande horizontalmente al interactuar para mostrar acciones secundarias.
  - *Uso en LaLaLa*: Barra inferior flotante en la vista móvil de ventas para acceder a escáner de cámara, calculadora rápida y visor de ticket.
- **`Accordion Smooth Height` (Acordeón con Medición Dinámica de Altura)**:
  - Apertura y cierre de paneles con transición fluida calculando la altura exacta del contenido.
  - *Uso en LaLaLa*: Desglose de gastos por categoría o desglose de ventas por vendedor en el arqueo diario.

### 4. Transiciones Visuales y Fondos
- **`Infinite Slider` (Deslizador Continuo Infinito)**:
  - Carrusel horizontal con desplazamiento continuo y pausa al pasar el cursor.
  - *Uso en LaLaLa*: Cinta de marcas de calzados disponibles en la tienda (Nike, Adidas, Timberland, Cat, Skechers, Puma).
- **`Progressive Blur` (Desenfoque Progresivo)**:
  - Gradiente de desenfoque (*backdrop-blur*) que se intensifica hacia los bordes.
  - *Uso en LaLaLa*: Barra de navegación superior fija (`sticky`) para permitir una lectura nítida del contenido mientras se hace scroll.
- **`Tilt 3D` (Inclinación Perspectiva)**:
  - Respuesta al cursor en 3D para tarjetas de resumen y calzados destacados.
- **`In View Transitions` (Aparición al Scroll)**:
  - Anima suavemente elementos hacia arriba cuando entran en la ventana visible (*viewport*).

---

## 🧩 Patrón de Implementación Ejemplo: Número Animado con Formato Monetario

```tsx
"use client";

import React, { useEffect } from "react";
import { useMotionValue, useSpring, useTransform, motion } from "framer-motion";

interface PropsNumeroAnimado {
  valor: number;
  esMoneda?: boolean;
  decimales?: number;
  className?: string;
}

export function NumeroAnimado({
  valor,
  esMoneda = false,
  decimales = 2,
  className,
}: PropsNumeroAnimado) {
  const valorMovimiento = useMotionValue(0);
  const valorResorte = useSpring(valorMovimiento, {
    stiffness: 90,
    damping: 18,
  });

  useEffect(() => {
    valorMovimiento.set(valor);
  }, [valor, valorMovimiento]);

  const textoPantalla = useTransform(valorResorte, (_actual) => {
    if (esMoneda) {
      return `Bs ${_actual.toLocaleString("es-BO", {
        minimumFractionDigits: decimales,
        maximumFractionDigits: decimales,
      })}`;
    }
    return Math.round(_actual).toLocaleString("es-BO");
  });

  return (
    <motion.span className={className}>
      {textoPantalla}
    </motion.span>
  );
}
```
