---
name: diseno-interfaz
description: Principios de diseño (precisión, cuadrícula 4px, profundidad consistente) y memoria de diseño para mantener coherencia visual en las pantallas de LaLaLa (POS, inventario, panel).
---

# Diseño de Interfaces (Principios + Consistencia)

Diseño preciso y pulido para software empresarial: interfaces limpias, modernas y minimalistas. Cada píxel importa y las decisiones no deben desviarse entre sesiones.

## 1. Memoria de Diseño (OBLIGATORIO)
- La fuente de verdad visual es `frontend/src/app/globals.css` (variables CSS) y `frontend/tailwind.config.ts`.
- Antes de diseñar, léelos y respeta los tokens existentes (colores, radios, sombras, tipografía).
- Si se toma una decisión nueva (ej. altura estándar de botones), documéntala como comentario de token en `globals.css` o pide confirmación al usuario.

## 2. Dirección de Diseño
LaLaLa usa **Sofisticación y Confianza** (estilo Stripe) para el panel financiero y **Precisión y Densidad** (estilo Linear) para POS e inventario: espaciado ajustado y mucha información visible.

## 3. Principios Centrales
1. **Cuadrícula de 4px:** espaciados `4, 8, 12, 16, 24, 32px`. Nunca valores arbitrarios (14px, 17px).
2. **Padding simétrico**, salvo que el contenido exija lo contrario.
3. **Border radius consistente:** un solo sistema en todo el proyecto.
4. **Profundidad:** una sola estrategia (solo bordes, sombra sutil única o sombras estratificadas).
5. **Controles personalizados:** nunca `<select>` ni `<input type="date">` nativos; usar ShadCN (`selector-combobox`, `selector-fecha-hora`).
6. **Tipografía:** títulos peso 600 con `-0.02em`; montos y stock con `tabular-nums` (monoespaciado) para alinear columnas.
7. **Color con propósito:** solo para estado (stock bajo/agotado, error, éxito) o acción. Base casi en escala de grises; un único color de acento.
8. **Reactividad:** micro-interacciones de 150ms, transiciones grandes de 200–250ms. Sin animaciones de rebote.
9. **Altura de botones estandarizada** (36px escritorio, ≥44px táctil en móvil).

## 4. Flujo de Trabajo
1. Leer tokens existentes y pantallas vecinas.
2. Proponer la composición (y, si ayuda, una maqueta) antes de codificar.
3. Aplicar los patrones y verificar en escritorio y <768px.
