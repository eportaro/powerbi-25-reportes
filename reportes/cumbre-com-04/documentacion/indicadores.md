# Indicadores — definiciones y límites

| Indicador | Definición | Límite |
|---|---|---|
| Venta neta | Líneas sin IGV de boletas y facturas válidas − notas de crédito del mes | Incluye corporativo. Cusco de septiembre desde la Z |
| Venta con meta | Venta neta de tiendas y web | Sin corporativo |
| Meta | Celda del Excel ÷ 1.18 | Tiendas y web |
| Avance | Venta con meta / meta | Vacío si la selección no tiene meta |
| Tickets | Comprobantes válidos del día | Cusco de septiembre: tickets de la Z, con anulados |
| Ticket promedio | Venta neta de tiendas / tickets de tiendas | Solo tiendas |
| Pedidos pagados | Completados, en proceso y reembolsados, por fecha de creación | — |
| Conversión | Pedidos pagados / sesiones, días con export completo | Toda la web; no responde a la unidad |
| Días sin cierre | Días de Cusco sin foto | No se estiman |
| Puente | Paso de la conciliación, enero hasta el mes elegido | El reporte al directorio llega a agosto |
| Mes / acumulado | Mes elegido; enero a ese mes | Sin selección, septiembre |

## Límites

- Sin margen, inventario, venta por SKU ni por vendedor.
- La conversión no se reparte por tienda: GA4 mide la web.
- Un día sin cierre queda vacío; no se imputa cero ni promedio.
- Datos sintéticos de una empresa ficticia. ERP y tienda online simulados en esta PC; no se probó contra
  un SAP Business One, SAP HANA ni WooCommerce reales. Importación CSV local en Power BI Desktop, sin
  publicación.
