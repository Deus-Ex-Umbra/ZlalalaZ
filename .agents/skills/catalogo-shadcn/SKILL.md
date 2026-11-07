---
name: catalogo-shadcn
description: "Catálogo exhaustivo y actualizado de TODOS los componentes existentes de shadcn/ui (documentación oficial: https://ui.shadcn.com/docs/components), con anatomía, casos de uso en tienda de calzado y POS LaLaLa, y reglas de integración."
---

# Catálogo Integral de Componentes shadcn/ui - LaLaLa (Calzado & POS)

> 🔗 **Documentación Oficial de Referencia**: [https://ui.shadcn.com/docs/components](https://ui.shadcn.com/docs/components)
> Consulta siempre la documentación oficial para revisar los últimos parámetros, hooks accesibles y variantes de estilo.

Esta skill proporciona el catálogo completo, exhaustivo y actualizado de todos los componentes existentes en **shadcn/ui**, adaptados a nuestro estándar de código en **Español Absoluto**, **i18n estricto** y parámetros con prefijo `_`.

---

## Directivas Universales de Integración
1. **Cero Texto Quemado (i18n Estricto)**: Ningún texto, etiqueta, placeholder, tooltip o mensaje de error debe quemarse en el JSX. Utilizar siempre `t('modulo.clave')` y diccionarios en `frontend/src/locales/{idioma}/{Modulo}.json`.
2. **Convenciones de Manejadores de Eventos**: Todo callback o manejador debe recibir sus parámetros con el prefijo `_`:
   ```tsx
   const manejarCambio = (_nuevoValor: string) => { ... };
   const manejarEnvio = (_evento: React.FormEvent) => { ... };
   const manejarSeleccionCalzado = (_codigoCalzado: string) => { ... };
   ```
3. **Temas y Accesibilidad**: Compatibilidad total con modo oscuro/claro (`next-themes` / `tema-contexto`) y soporte para lectores de pantalla mediante primitivas accesibles (Radix UI).
4. **Instalación Oficial**: Usar siempre el CLI de shadcn: `npx shadcn@latest add <nombre-componente>` dentro de `frontend/`.

---

## 📚 Índice Alfabético y Exhaustivo de Componentes shadcn/ui

### 1. Estructura, Layout y Navegación
- **`sidebar`** (`/docs/components/sidebar`): Sistema completo de navegación lateral con soporte para colapso, variantes flotantes, acordeones internos, badges y atajos de teclado.
  - *Uso en LaLaLa*: Menú lateral principal de la aplicación (`POS`, `Inventario`, `Ingresos`, `Gastos`, `Panel Central`, `Configuraciones`).
- **`breadcrumb`** (`/docs/components/breadcrumb`): Miga de pan para indicar la profundidad jerárquica de la ruta actual.
  - *Uso en tienda*: `Inventario > Botines > Timberland Pro Cuero Negro Talla 41`.
- **`menubar`** (`/docs/components/menubar`): Barra de menús superior con accesos rápidos de escritorio (`Ventas`, `Inventario`, `Caja`, `Reportes`, `Ayuda`).
- **`navigation-menu`** (`/docs/components/navigation-menu`): Menú estructurado con paneles desplegables enriquecidos y previsualizaciones.
- **`pagination`** (`/docs/components/pagination`): Controles de paginación para tablas masivas de calzados, transacciones y kardex.
- **`tabs`** (`/docs/components/tabs`): Pestañas para alternar vistas (ej. `Catálogo Activo`, `Stock Crítico`, `Por Agotarse`, `Mochilas/Accesorios`).
- **`direction`** (`/docs/components/direction`): Soporte de dirección de texto (LTR/RTL).
- **`separator`** (`/docs/components/separator`): Divisores visuales horizontales o verticales entre secciones del carrito o métricas.
- **`resizable`** (`/docs/components/resizable`): Paneles divisores ajustables por el usuario para redimensionar el catálogo y el carrito POS simultáneamente.

### 2. Teclado, Atajos y Comandos
- **`command`** (`/docs/components/command`): Paleta de comandos interactiva con búsqueda difusa (fuzzy search) y filtros.
  - *Uso en LaLaLa*: Búsqueda rápida global de productos por código/marca (`Ctrl+K` o `F2`) y atajos del POS.
- **`kbd`** (`/docs/components/kbd`): Indicador visual tipográfico para teclas y atajos de teclado.
  - *Uso en tienda*: Representar visualmente combinaciones de atajos (`F4` para Cobrar, `F9` para Descuento, `Esc` para Cancelar).

### 3. Formularios, Entradas y Controles de Datos
- **`button`** (`/docs/components/button`): Botón accesible con variantes (`default`, `destructive`, `outline`, `secondary`, `ghost`, `link`).
- **`button-group`** (`/docs/components/button-group`): Agrupación visual y accesible de botones contiguos (ej. selector rápido de métodos de pago).
- **`calendar`** (`/docs/components/calendar`): Calendario accesible basado en `react-day-picker`.
- **`date-picker`** (`/docs/components/date-picker`): Selector de fechas con popover integrado para filtros de reportes y arqueos de caja.
- **`checkbox`** (`/docs/components/checkbox`): Casilla de verificación para opciones como "Imprimir ticket automáticamente" o selección múltiple de stock.
- **`combobox`** (`/docs/components/combobox`): Selector desplegable con autocompletado y búsqueda en tiempo real para marcas, modelos y clientes frecuentes.
- **`field`** (`/docs/components/field`): Contenedor de control de formulario unificado que enlaza etiqueta, input, descripción y mensaje de error.
- **`form`** (`/docs/components/form`): Integración robusta de formularios con `react-hook-form` y validación tipada vía `zod`.
- **`input`** (`/docs/components/input`): Campo de texto básico accesible para código de barras, modelo, color o notas.
- **`input-group`** (`/docs/components/input-group`): Campo de entrada con prefijos o sufijos (icono de lupa, moneda `Bs`, unidad `pares`).
- **`input-otp`** (`/docs/components/input-otp`): Entrada de caracteres segmentados para claves de supervisor, autorizaciones de descuento o PIN de caja.
- **`label`** (`/docs/components/label`): Etiqueta accesible vinculada al identificador del campo.
- **`native-select`** (`/docs/components/native-select`): Selector nativo ligero para dispositivos móviles o controles sencillos.
- **`radio-group`** (`/docs/components/radio-group`): Opciones de selección excluyente (ej. tipo de comprobante: `Ticket Térmico`, `Factura`, `Nota`).
- **`select`** (`/docs/components/select`): Desplegable accesible con soporte para grupos de opciones (categorías, tallas, formas de pago).
- **`slider`** (`/docs/components/slider`): Control deslizante para rangos continuos (filtro de precios o porcentaje de descuento).
- **`switch`** (`/docs/components/switch`): Interruptor conmutable (ej. activar/desactivar descuento automático a clientes frecuentes).
- **`textarea`** (`/docs/components/textarea`): Área de texto multilínea para observaciones de venta o notas en caja chica.
- **`toggle`** (`/docs/components/toggle`): Botón de estado binario.
- **`toggle-group`** (`/docs/components/toggle-group`): Selector múltiple para marcar tallas disponibles (ej. `36`, `37`, `38`, `39`, `40`, `41`).

### 4. Paneles, Modales y Superposiciones (Overlays)
- **`dialog`** (`/docs/components/dialog`): Ventana modal sobrepuesta para acciones principales (registrar nuevo calzado, registrar gasto de caja).
- **`alert-dialog`** (`/docs/components/alert-dialog`): Modal interruptivo para operaciones destructivas o críticas (anular venta, cancelar ticket, eliminar calzado).
- **`drawer`** (`/docs/components/drawer`): Cajón deslizable desde los bordes de la pantalla (ideal para carrito de compras en teléfonos móviles).
- **`sheet`** (`/docs/components/sheet`): Panel lateral deslizante (slide-over) para el detalle del carrito POS o la ficha técnica del calzado.
- **`popover`** (`/docs/components/popover`): Contenedor flotante anclado a un botón o elemento de referencia (filtros flotantes, calculadora rápida).
- **`hover-card`** (`/docs/components/hover-card`): Tarjeta emergente con vista previa al pasar el ratón (foto ampliada del zapato y tallas en stock).
- **`context-menu`** (`/docs/components/context-menu`): Menú desplegable al hacer clic derecho sobre una fila de producto (Editar, Ver Kardex, Duplicar).
- **`tooltip`** (`/docs/components/tooltip`): Mensaje explicativo conciso al posar el cursor sobre iconos o botones abreviados.

### 5. Presentación de Datos, Tablas y Contenedores
- **`card`** (`/docs/components/card`): Tarjeta estructurada con cabecera, contenido y pie (tarjetas de productos, métricas de ventas).
- **`avatar`** (`/docs/components/avatar`): Foto de perfil del vendedor/administrador con fallback de iniciales.
- **`badge`** (`/docs/components/badge`): Píldora de estado (ej. `En Stock`, `Stock Bajo`, `Agotado`, `Efectivo`, `Transferencia`).
- **`table`** (`/docs/components/table`): Tabla estructurada accesible.
- **`data-table`** (`/docs/components/data-table`): Tabla interactiva avanzada con ordenamiento, filtrado y selección de filas (TanStack Table).
- **`chart`** (`/docs/components/chart`): Gráficos interactivos de líneas, barras, áreas y tartas basados en Recharts (ventas del mes, métodos de pago, top calzados).
- **`item`** (`/docs/components/item`): Elemento de lista flexible para listas interactivas del carrito POS.
- **`aspect-ratio`** (`/docs/components/aspect-ratio`): Contenedor con proporción geométrica fija para imágenes de calzados (1:1 o 4:3).
- **`carousel`** (`/docs/components/carousel`): Carrusel de fotos del calzado (ángulo lateral, frontal, suela).
- **`scroll-area`** (`/docs/components/scroll-area`): Área con barra de desplazamiento consistente para el carrito y lista de tallas.
- **`accordion`** (`/docs/components/accordion`): Paneles colapsables interactivos (desglose por marcas o preguntas frecuentes).
- **`collapsible`** (`/docs/components/collapsible`): Sección individual expandible/colapsable (filtros avanzados de búsqueda).

### 6. Retroalimentación, Alertas y Mensajería
- **`alert`** (`/docs/components/alert`): Cuadro de aviso para alertas importantes (aviso de caja cerrada, advertencia de stock cero).
- **`sonner`** (`/docs/components/sonner`): Sistema moderno de notificaciones toast flotantes para éxito o error de operaciones.
- **`toast`** (`/docs/components/toast`): Sistema alternativo de notificaciones temporales.
- **`progress`** (`/docs/components/progress`): Barra de progreso para importación masiva de calzados o sincronización offline.
- **`skeleton`** (`/docs/components/skeleton`): Efecto de carga pulsante mientras el backend NestJS responde la petición.
- **`spinner`** (`/docs/components/spinner`): Indicador giratorio de carga para operaciones asíncronas (generación de ticket, cobro).
- **`empty`** (`/docs/components/empty`): Vista de estado vacío cuando una búsqueda de calzado o filtro de ventas no tiene resultados.
- **`bubble`** (`/docs/components/bubble`): Burbuja de anotación o estado de venta.
- **`message`** (`/docs/components/message`): Fila de mensaje para bitácoras y registros de auditoría.
- **`message-scroller`** (`/docs/components/message-scroller`): Contenedor con auto-scroll para flujos de actividad reciente.
- **`questionnaire`** (`/docs/components/questionnaire`): Formulario guiado paso a paso para apertura de caja o arqueo de turno.
- **`marker`** (`/docs/components/marker`): Marcador visual interactivo sobre diagramas de calzado o zonas de almacén.
- **`attachment`** (`/docs/components/attachment`): Componente para adjuntar comprobantes de transferencia bancaria o recibos escaneados.
- **`typography`** (`/docs/components/typography`): Estilos tipográficos consistentes (`h1`, `h2`, `p`, `lead`, `blockquote`).
