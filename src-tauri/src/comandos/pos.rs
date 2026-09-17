use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct ItemSolicitud {
    pub codigo_producto: String,
    pub nombre_producto: String,
    pub talla: String,
    pub color: String,
    pub cantidad: u32,
    pub precio_unitario: f64,
    pub descuento: f64,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct VentaOfflineSolicitud {
    pub nombre_cliente: String,
    pub forma_pago: String,
    pub items: Vec<ItemSolicitud>,
    pub monto_recibido: f64,
    pub descuento_general: f64,
    pub notas: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct VentaOfflineResultado {
    pub numero_ticket: String,
    pub fecha_hora: String,
    pub subtotal: f64,
    pub descuento_total: f64,
    pub total_pagar: f64,
    pub cambio: f64,
    pub mensaje: String,
}

#[tauri::command]
pub fn procesar_venta_offline(solicitud: VentaOfflineSolicitud) -> Result<VentaOfflineResultado, String> {
    if solicitud.items.is_empty() {
        return Err("ERR-VENT-001: El carrito no contiene productos".to_string());
    }

    let mut subtotal: f64 = 0.0;
    let mut descuento_items: f64 = 0.0;

    for item in &solicitud.items {
        let subtotal_linea = item.precio_unitario * (item.cantidad as f64);
        subtotal += subtotal_linea;
        descuento_items += item.descuento;
    }

    let descuento_total = descuento_items + solicitud.descuento_general;
    let total_pagar = (subtotal - descuento_total).max(0.0);

    let cambio = if solicitud.forma_pago == "Efectivo" {
        if solicitud.monto_recibido < total_pagar {
            return Err(format!(
                "ERR-VENT-002: Monto recibido ({:.2}) es inferior al total ({:.2})",
                solicitud.monto_recibido, total_pagar
            ));
        }
        solicitud.monto_recibido - total_pagar
    } else {
        0.0
    };

    let numero_ticket = format!("TCK-OFF-{}", std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs());

    Ok(VentaOfflineResultado {
        numero_ticket,
        fecha_hora: "2026-09-17 00:00:00".to_string(),
        subtotal,
        descuento_total,
        total_pagar,
        cambio,
        mensaje: "Venta registrada con éxito en modo local / offline".to_string(),
    })
}
