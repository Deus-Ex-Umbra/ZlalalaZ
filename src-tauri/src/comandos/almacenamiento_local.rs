use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct EstadoConexion {
    pub modo_offline: bool,
    pub transacciones_pendientes: usize,
    pub estado: String,
}

#[tauri::command]
pub fn verificar_estado_conexion() -> Result<EstadoConexion, String> {
    // Retorna el estado actual del modo local
    Ok(EstadoConexion {
        modo_offline: false,
        transacciones_pendientes: 0,
        estado: "Conectado al servidor principal NestJS".to_string(),
    })
}
