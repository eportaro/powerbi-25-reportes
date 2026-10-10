# Inventario y disponibilidad — reglas del reporte

Distribuidora Norte es una empresa ficticia. Datos sintéticos de 18 artículos y dos almacenes,
LIM y TRU, al cierre del 30/09/2026. Una página para decidir qué stock puede comprometerse,
qué combinaciones requieren reposición y qué compras continúan pendientes.

## Fuentes y modelo

Tres sistemas: export ERP de 12 tablas relacionales CSV, Excel manual de políticas de
reposición y registro físico CSV. El maestro de artículos fija la unidad base y el factor
por caja. Las políticas se convierten a esa unidad antes de comparar cantidades.

El saldo oficial es la instantánea ERP al corte. Saldo inicial y movimientos sirven para
conciliarla, no para sumarlos otra vez. Inventario tiene grano artículo/almacén/corte;
compras tiene grano pedido/línea/corte y conserva almacén de destino. Tres dimensiones
compartidas, dos hechos y seis relaciones unidireccionales; no hay relación entre hechos.

## Indicadores

| Indicador | Regla y uso |
|---|---|
| Saldo físico | Existencia oficial ERP en unidad base al corte. Incluye unidades reservadas y bloqueadas. |
| Valor de stock | Saldo × costo promedio oficial del artículo/almacén en PEN sin IGV. Redondeo a céntimos por combinación antes de sumar. |
| Reserva activa | Solo reservas ACTIVA aplicables al corte; las liberadas quedan fuera. |
| Bloqueo abierto | Incidencias ABIERTA aplicables al corte. Unidades distintas de las reservadas, ya incluidas en el saldo físico. |
| Disponible neto | Saldo − reserva activa − bloqueo abierto; conserva negativos para diagnóstico. |
| Disponible prometible | MAX(disponible neto, 0) por artículo/almacén, después sumar. No incorpora compras futuras. |
| Faltante | MAX(−disponible neto, 0) por combinación. No compensar faltantes con otro almacén. |
| Bajo mínimo | Contar combinaciones con prometible estrictamente menor al mínimo vigente. Igualdad no alerta. |
| Mínimo y objetivo | Política vigente convertida a unidad base; objetivo sirve para revisar reposición, no para emitir órdenes automáticamente. |
| Política por revisar | Política ausente o inválida no equivale a mínimo cero ni a situación normal; se muestra como pendiente de revisión. |
| Compra pendiente | Por línea CONFIRMADA: MAX(pedido − recepciones contabilizadas hasta el corte, 0). Sumar por destino. |
| Compra atrasada | Pendiente positivo con fecha prometida estrictamente anterior al corte. |
| Vence al corte | Pendiente con fecha prometida igual al corte. |
| Fecha por confirmar | Pendiente sin fecha prometida; no se declara atrasado por no tener fecha. |
| Prioridad | Faltante → sin disponible → bajo mínimo → normal. Desempate por valor del faltante y códigos; no sumar prioridades. |

Los filtros Almacén y Familia afectan inventario y compras mediante dimensiones compartidas.
Las cantidades totales suman unidades base de distintos artículos: no representan una unidad
física homogénea ni demanda satisfecha. Cada indicador usa el contexto filtrado de la página.

## Controles y excepciones

Claves únicas, enlaces válidos, conversión de unidades, saldo y recepciones conciliados.
Duplicados idénticos de export se deduplican sin multiplicar importes; duplicados contradictorios,
costo ausente, recepción superior a pedido o nueva clave sin correspondencia requieren revisión.
No se silencian inconsistencias. Datos RAW y modelo preparado se conservan por separado.

Referencias sin filtros: saldo 6.017; reserva 632; bloqueo 19; neto 5.366; prometible 5.370;
faltante 4; valor S/ 498.073,27; dos combinaciones bajo mínimo; compra pendiente 1.189;
atrasada 338. Comprobación previa: 1.412 controles RAW/modelo/DAX, incluidos contextos filtrados.

## Uso y límites

Comenzar por el resultado, comparar neto y prometible, revisar alertas y bajar al detalle
artículo/almacén o pedido/línea. Compras pendientes no eliminan alertas ni aumentan stock actual.
Si una tarjeta muestra «En blanco», no hay filas elegibles en ese contexto; no equivale a
error de carga ni permite inventar datos para completar la visual.

Solo un corte. Sin histórico de demanda validado para rotación anual, cobertura o pronósticos.
Sin publicación en el servicio Power BI ni seguridad multiusuario. Desktop importa los cinco
CSV preparados; Actualizar no ejecuta el ETL sobre RAW. Configurar DataFolder según el README.
