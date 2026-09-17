use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct DatosTicketImpresion {
    pub nombre_tienda: String,
    pub numero_ticket: String,
    pub fecha: String,
    pub cliente: String,
    pub items: Vec<String>,
    pub total: f64,
    pub metodo_pago: String,
}

#[tauri::command]
pub fn imprimir_ticket_termico(datos: DatosTicketImpresion) -> Result<bool, String> {
    if datos.numero_ticket.is_empty() {
        return Err("ERR-PRINT-001: El ticket carece de número identificador".to_string());
    }

    println!("[ESC/POS] =======================================");
    println!("[ESC/POS] {}", datos.nombre_tienda);
    println!("[ESC/POS] Ticket: {}", datos.numero_ticket);
    println!("[ESC/POS] Fecha: {}", datos.fecha);
    println!("[ESC/POS] Cliente: {}", datos.cliente);
    println!("[ESC/POS] ---------------------------------------");
    for item in &datos.items {
        println!("[ESC/POS] {}", item);
    }
    println!("[ESC/POS] ---------------------------------------");
    println!("[ESC/POS] TOTAL: Bs {:.2}", datos.total);
    println!("[ESC/POS] Pago: {}", datos.metodo_pago);
    println!("[ESC/POS] =======================================");

    Ok(true)
}
