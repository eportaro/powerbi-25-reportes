# Estado de resultados mensual — reglas del reporte

Altamar Servicios Industriales es una empresa ficticia de servicios con tres centros de costo: Operaciones
Lima, Operaciones Arequipa y Administración y ventas. Datos sintéticos de enero a septiembre de 2026, en
soles. Una página para ver si el resultado operativo del mes y del año va según el presupuesto aprobado,
y qué línea y qué centro explican la diferencia.

## Fuentes

| Fuente | Contenido | Uso |
|---|---|---|
| ERP contable, 5 CSV | Plan de cuentas, centros, periodos, cabecera y detalle de 640 asientos | Real oficial |
| Excel de Contabilidad | Cuenta de 6 dígitos → línea y sección del estado de resultados | Clasificación |
| Excel de Finanzas | Presupuesto por versión, línea, centro y periodo | Solo PPTO-2026-V1 |

Las fuentes no se modifican. Lo que el reporte excluye o muestra aparte queda registrado como excepción.

## Real oficial

- Solo asientos CONTABILIZADO. Anulados y borradores no entran en ningún saldo.
- El mes lo da el periodo de la cabecera, no la fecha contable. Solo periodos cerrados: enero a
  septiembre. Octubre está abierto y no se muestra.
- Cuentas de clase 6 y 7. Se excluyen la clase 9 y su contrapartida 791101 para no duplicar el gasto.
- Saldo por naturaleza de la cuenta: deudora = debe − haber; acreedora = haber − debe. Un movimiento
  contrario a la naturaleza se ve negativo; nunca se usa valor absoluto.
- Importes en las columnas en soles del ERP, sin reconvertir moneda extranjera.
- Un extorno es un asiento normal en su propio periodo: no se elimina en pareja ni se mueve de mes.
- Clasificación por coincidencia exacta de la cuenta en el Excel de mapeo; el nombre o la glosa no
  clasifican. La cuenta 659901 Penalidades va a Gastos generales por decisión de Contabilidad, aún no
  cargada al Excel. Cualquier otra cuenta sin mapeo va a «Por clasificar», dentro de gastos operativos.
- El resultado financiero, el impuesto a la renta y la utilidad neta no forman parte de la página.

## Presupuesto

Solo la versión aprobada PPTO-2026-V1, mensual por línea y centro. La reproyección en borrador no aparece.
Publicidad y ventas tiene presupuesto solo anual (S/ 180,000.00 en Administración): no se reparte por
meses, ni siquiera en el acumulado. El real sin centro no tiene presupuesto.

## Modelo

| Tabla | Grano | Filas |
|---|---|---:|
| FactReal | Periodo + cuenta + centro | 224 |
| FactPresupuesto | Periodo + línea + centro | 117 |
| DimMes, DimCentro, DimLinea, DimCuenta | Mes, centro, línea del estado, cuenta | 9, 4, 8, 13 |
| ControlExcepcion | Excepción declarada | 17 |
| FilaPyG | Fila visible del estado (calculada) | 12 |

Siete relaciones muchos-a-uno de dirección simple. Real y presupuesto no se unen entre sí: se cruzan
por las dimensiones compartidas de mes, centro y línea. El real conserva el grano de cuenta; el
presupuesto llega por línea y no se reparte a cuentas.

## Controles y excepciones

Claves únicas en todas las tablas y ninguna clave de hecho sin dimensión; si falla, la carga se detiene.
El real por línea concilia con debe − haber de las fuentes, y la clase 9 con su contrapartida, con
diferencia cero en los nueve meses.

| Excepción | Tratamiento |
|---|---|
| Asiento anulado y asiento en borrador | Fuera de todo saldo |
| Asientos de octubre | Periodo abierto: no oficiales |
| Alquileres sin centro desde julio | Se ven como «Sin centro asignado»; no se reasignan ni entran en la variación |
| 659901 sin fila en el Excel de mapeo | Gastos generales, por decisión de Contabilidad pendiente de cargar |
| Publicidad y ventas | Presupuesto solo anual: real aparte, sin variación mensual |
| Asiento de venta descuadrado | El ingreso cuenta; el descuadre es tema del balance |

Las excepciones se reportan, no se corrigen en el reporte. La tabla de la página muestra el corte
completo y no responde a los filtros.

Referencias acumuladas de enero a septiembre, todos los centros: ingresos netos S/ 8,634,619.39;
gastos operativos S/ 2,717,933.69; resultado operativo S/ 1,788,655.74 frente a S/ 2,093,449.04
presupuestados; variación comparable −S/ 222,729.56. Recalculadas desde las fuentes RAW por un
procedimiento independiente del modelo y comparadas con el motor de Power BI.
