# Servicios Sur — reglas de dotación y rotación

Empresa y personas ficticias; enero a septiembre de 2026. Tres fuentes:
HRIS relacional exportado a CSV, planillas CSV y plan de dotación manual en Excel.

- Contar personas, no contratos. Ingreso y baja son inclusivos. Una persona
  puede figurar al cierre del día de baja y en el evento de baja. Estado actual
  no borra historia. Deduplicar contratos idénticos; conflictos requieren revisión.
- Apertura: último día del mes anterior. Cierre: último día del mes.
  Transferencias no son altas/bajas; reingreso conserva la identidad.
- Incluir temporales y jornada parcial. FTE es otra unidad, no personas.
- Área y sede corresponden a la asignación histórica al corte o al fin de contrato,
  si ocurrió antes. No repartir costo por días de traslado ni usar asignación actual.
- Plan: versión P2026 aprobada, unidad PERSONAS. Excluir borrador RF2026Q4.
  Tarjetas de dotación, plan y brecha usan el último mes seleccionado.
- Brecha = personas al cierre − plan. Brecha negativa no acredita vacantes abiertas.
- Bajas voluntarias excluyen FIN_CONTRATO. Índice ponderado mensual = suma de
  bajas voluntarias / suma de las medias mensuales de apertura y cierre.
  No anualizar, sumar ni promediar porcentajes. Denominador cero devuelve vacío.
- Costo en PEN: HABER + CARGA_EMPRESA + AJUSTE con su signo, únicamente cierre y
  detalle contabilizados, por devengo. Excluir borradores; conservar ajuste negativo.
  No es pago de caja, costo por persona ni cálculo tributario.
- Costo y movimientos acumulan meses seleccionados; la serie usa cada foto mensual.
  Filtros dentro de una dimensión se unen con O; dimensiones se combinan con Y.

Modelo: cuatro dimensiones y cuatro hechos, ocho tablas y quince relaciones
unidireccionales. Diecisiete DAX documentados en indicadores.md. Sin selección
restrictiva: cierre septiembre 57 personas, FTE 55,75, plan 62, brecha −5;
9 altas, 5 bajas, 4 voluntarias; costo S/ 3.072.124,14. Índice ponderado mensual
0,815494393476045 %, presentado como 0,82 %.
