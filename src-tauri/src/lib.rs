pub mod comandos;

use comandos::pos::procesar_venta_offline;
use comandos::impresion::imprimir_ticket_termico;
use comandos::almacenamiento_local::verificar_estado_conexion;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            procesar_venta_offline,
            imprimir_ticket_termico,
            verificar_estado_conexion
        ])
        .run(tauri::generate_context!())
        .expect("Error al ejecutar la aplicación Tauri ZLaLaLaZ");
}
