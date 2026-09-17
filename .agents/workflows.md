# Flujos de Trabajo y Comandos Automáticos (ZLaLaLaZ)

## 1. Gestión de Dependencias y UI

- **Instalación de paquetes en la raíz o workspaces:**
  `npm install <nombre_del_paquete>`
- **Instalación en frontend:**
  `npm install <paquete> --prefix frontend`
- **Instalación en backend:**
  `npm install <paquete> --prefix backend`
- **Integración de Componentes ShadCN UI (Frontend):**
  Para agregar componentes oficiales de ShadCN UI al frontend, ejecuta:
  `cd frontend && npx shadcn@latest add <nombre_componente>` (ej. `button`, `dialog`, `card`, `tabs`, `table`, `badge`, `drawer`).
- **Generación de Módulos NestJS (Backend):**
  Para generar módulos y recursos en el backend:
  `cd backend && npx nest g resource modulos/<nombre_en_espanol>`
  (Recuerda adaptar y mantener siempre todos los nombres de archivos y clases en español).

## 2. Formateo y Linter

- **Formatear el código:**
  `npm run format`
- **Verificar errores estáticos y reglas de linter:**
  - Frontend: `npm run lint:frontend`
  - Backend: `npm run lint:backend`
  - Completo: `npm run lint`

## 3. Compilación y Validación (Build)

Tras completar una historia de usuario o cambio estructural:
- **Validar compilación de Backend:** `npm run build:backend` (o `npm run build` dentro de `backend/`).
- **Validar compilación de Frontend:** `npm run build:frontend` (o `npm run build` dentro de `frontend/`).
- **Validación del Proyecto Completo:** `npm run build` en la raíz.
- **Nota sobre Rust / Tauri:** NO ejecutar `cargo build` o `npm run tauri build` localmente mientras el entorno no tenga instalado el compilador de Rust. Solo verificar la coherencia estática de los archivos `.rs` y `Cargo.toml`.

## 4. Validación Estricta de Textos y Traducciones (i18n)

- **Cero Texto Quemado:** Antes de dar por finalizado un componente de UI, realiza una autoevaluación obligatoria:
  1. ¿Hay algún string visible en español o inglés hardcodeado en el JSX? Si lo hay, extráelo inmediatamente con `t('modulo.seccion.llave')`.
  2. ¿Existe la llave creada en `frontend/src/locales/es/{Modulo}.json`?
  3. ¿Se agregaron los equivalentes en `frontend/src/locales/en/{Modulo}.json` y `locales/de/{Modulo}.json`?
- **Llaves Crudas en UI:** Si se visualiza texto con formato de llave (ej. `inventario.tabla.columna_precio`), significa que la llave no existe o la estructura JSON está rota. Corregir de inmediato.

## 5. Registro Central de Errores

- Al introducir una nueva condición de fallo o excepción en el backend:
  1. Asígnale un código estandarizado (ej. `ERR-CALZ-005: Talla solicitada no disponible`).
  2. Lanza la excepción NestJS nativa con la estructura estándar.
  3. Documenta el error en `backend/errores.md` indicando Código, Descripción, Causa y Módulo.
