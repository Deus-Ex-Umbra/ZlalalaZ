# Flujos de Trabajo y Comandos Automáticos

## 1. Gestión de Dependencias y UI
- **Instalación de paquetes en la raíz o workspaces:** `npm install <nombre_del_paquete>`
- **Instalación en frontend:** `npm install <paquete> --prefix frontend`
- **Instalación en backend:** `npm install <paquete> --prefix backend`
- **Integración de Componentes ShadCN UI (Frontend):**
  `cd frontend && npx shadcn@latest add <nombre_componente>` (ej. `button`, `dialog`).
- **Generación de Módulos NestJS (Backend):**
  `cd backend && npx nest g resource modulos/<nombre_en_espanol>`

## 2. Formateo y Linter
- **Formatear el código:** `npm run formatear` (alias: `npm run format`)
- **Verificar errores estáticos y reglas de linter:**
  - Frontend: `npm run revisar:frontend` (alias: `npm run lint:frontend`)
  - Backend: `npm run revisar:backend` (alias: `npm run lint:backend`)
  - Completo: `npm run revisar` (alias: `npm run lint`)

## 3. Compilación y Validación
- **Validar compilación de Backend:** `npm run compilar:backend` (alias: `npm run build:backend`)
- **Validar compilación de Frontend:** `npm run compilar:frontend` (alias: `npm run build:frontend`)
- **Validación del Proyecto Completo:** `npm run compilar` (alias: `npm run build`) en la raíz.

## 4. Ejecución del Entorno de Desarrollo y Producción
- **Iniciar todo en desarrollo:** `npm run iniciar:dev` (alias: `npm run dev`)
- **Iniciar backend en desarrollo:** `npm run iniciar:dev:backend` (o `cd backend && npm run iniciar:dev`)
- **Iniciar frontend en desarrollo:** `npm run iniciar:dev:frontend` (o `cd frontend && npm run iniciar:dev`)
- **Iniciar todo en producción:** `npm run iniciar:prod`
- **Encender Base de Datos:** `.\encender-bd.ps1` (o `npm run bd:encender`)
- **Apagar Base de Datos:** `.\apagar-bd.ps1` (o `npm run bd:apagar`)
- **Consultar Estado de Base de Datos:** `.\estado-bd.ps1` (o `npm run bd:estado`)

## 5. Validación Estricta de Textos y Traducciones (i18n)
- **Cero Texto Quemado:** Antes de dar por finalizado un componente UI:
  1. ¿Hay algún string visible hardcodeado? Extráelo con `t('modulo.seccion.llave')`.
  2. ¿Existe la llave creada en `frontend/src/locales/es/{Modulo}.json`?
  3. ¿Se agregaron los equivalentes en `en/` y `de/`?
- **Llaves Crudas en UI:** Si se visualiza la llave literal (ej. `inventario.tabla`), corregir de inmediato.

## 6. Registro Central de Errores
- Al introducir nueva condición de fallo:
  1. Asígnale un código estandarizado.
  2. Lanza la excepción NestJS nativa con la estructura estándar.
  3. Documenta en `backend/errores.md`.
