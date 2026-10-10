# Indicadores — definiciones y límites

`L(x)` es el real de la línea `x`: saldo por naturaleza de sus cuentas, con las reglas del real oficial.
`P(x)` es su presupuesto PPTO-2026-V1 mensual. Cada línea se presenta en positivo según su naturaleza y
los subtotales restan.

| Indicador | Definición | Límite |
|---|---|---|
| Ingresos netos | L(Ingresos por servicios) − L(Descuentos concedidos) | Incluye los alquileres sin centro |
| Costo del servicio | L(Costo del servicio) | La depreciación de operaciones va a Depreciación, no aquí |
| Margen bruto | Ingresos netos − Costo del servicio | — |
| Margen bruto % | Margen bruto / Ingresos netos | Vacío si los ingresos netos son cero (por ejemplo, solo Administración) |
| Gastos operativos | Personal administrativo + Gastos generales + Publicidad y ventas + Depreciación + Por clasificar | Publicidad y ventas sin presupuesto mensual |
| Resultado operativo | Margen bruto − Gastos operativos | Último renglón de la página |
| Presupuesto | Las mismas fórmulas sobre P(x) | Solo celdas mes × línea × centro con presupuesto mensual |
| Real comparable | Real de las celdas mes × línea × centro que tienen presupuesto mensual | Base de la variación |
| Variación S/ | Real comparable − Presupuesto | Solo en soles. Vacía si no hay presupuesto |
| Fuera de comparación | Real − Real comparable | Publicidad y ventas, Sin centro asignado y Por clasificar. Cero se muestra vacío |
| Mes / acumulado | Mes elegido; acumulado de enero a ese mes | Enero a septiembre de 2026 |
| Excepciones | Registros e importe declarado por tipo | Tipos distintos no se suman entre sí |

Sentido de la variación: más ingreso, margen o resultado es favorable; más costo, descuento o gasto es
desfavorable. Por eso una variación positiva en gastos operativos se marca en rojo.

## Límites

- Sin variación en porcentaje: Finanzas no definió la regla.
- Sin EBITDA, resultado financiero, impuesto, utilidad neta ni flujo de caja.
- Sin reproyección: solo el presupuesto aprobado.
- Publicidad y ventas no se prorratea: su presupuesto anual no tiene comparación mensual.
- El real sin centro no se reasigna en el reporte; se corrige en el ERP.
- Un mes sin datos queda vacío; no se imputa cero.
- Datos sintéticos; una empresa ficticia. Importación CSV local en Power BI Desktop; sin publicación en el
  servicio ni seguridad por usuario.
