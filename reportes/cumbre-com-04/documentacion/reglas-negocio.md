# Ventas omnicanal frente a la meta — reglas del reporte

Cumbre Outdoor es una cadena ficticia de ropa y equipo outdoor con cinco tiendas, una tienda online y
ventas corporativas. Datos sintéticos de enero a septiembre de 2026, en soles sin IGV. Dos páginas: una
para ver si la venta va según la meta, por tienda y canal; otra para explicar por qué las cifras que
circulan no coinciden con la venta oficial.

## Fuentes

| Fuente | Contenido | Uso |
|---|---|---|
| ERP al estilo SAP Business One, en SQL Server | Boletas, facturas, notas de crédito, pedidos | Venta oficial |
| API de la tienda online (WooCommerce) | Pedidos con estado, impuestos y envío | Pedidos pagados y puente del panel |
| Google Analytics 4, export CSV | Sesiones por día y canal | Conversión |
| Excel de Comercial | Meta mensual por tienda y web | Meta |
| Excel de Finanzas | Venta presentada al directorio | Puente de conciliación |
| Fotos del cierre Z de Cusco | Un ticket de cierre por día, enviado por WhatsApp | Venta de Cusco desde el 01/09 |

Las fuentes no se modifican. Ninguna es real: el ERP es una base simulada con la estructura de SAP B1 y
la tienda online es una API local simulada.

## Venta oficial

- Líneas de boletas y facturas sin IGV, menos notas de crédito en el mes de la nota.
- Fuera los comprobantes anulados y sus documentos de cancelación.
- El flete no es venta.
- Si la integración web emitió dos boletas para el mismo pedido, vale la primera.
- El mes lo da la fecha del comprobante: la venta a la minera va en abril, en Corporativo.
- Cusco desde el 01/09: el POS dejó de sincronizar; la venta del día es la operación gravada del cierre
  Z leído de la foto. Un día sin foto no se estima.
- Las provisiones y ajustes manuales del reporte al directorio no son venta.

## Meta

La meta del Excel tiene IGV: se divide entre 1.18. La celda corregida a mano (web, julio) vale lo que
dice. La fila de total no es una tienda. El corporativo no tiene meta.

## Web

Pedido pagado: completado, en proceso o reembolsado. Conversión: pedidos pagados / sesiones, solo en
días con el export de GA4 completo; el 29/09 llegó parcial y queda fuera.

## Modelo

| Tabla | Grano | Filas |
|---|---|---:|
| FactVenta | Día × unidad | 1,654 |
| FactMeta | Mes × unidad | 54 |
| FactWeb | Día | 273 |
| FactPuente | Mes × unidad × puente × paso | 333 |
| DimFecha, DimUnidad | Día, unidad | 273, 7 |
| ControlCalidad | Control del corte | 9 |

## Controles

Claves únicas y ningún hecho sin dimensión; si falla, el modelo no se construye. Los dos puentes
(directorio y panel web) cierran al céntimo o el modelo no se construye. Las fotos de Cusco se cuadran
tres veces cada una; lo ilegible va a revisión y no cambia la cifra.

Referencias de enero a septiembre: venta neta S/ 17,933,902.50; septiembre S/ 1,958,236.19 con avance
95.9 % del mes y 95.2 % acumulado. Recalculadas por un procedimiento independiente del modelo y
contrastadas con lo que el generador escondió.
