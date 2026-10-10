# Ventas ejecutivas — una sola cifra oficial

**Comercial** · Power BI · SQL Server · DAX · Row-level security

## El caso

Suministros Andina es una distribuidora peruana ficticia de herramientas, equipos de protección y consumibles industriales: tres sedes, unos 110 empleados y 18 vendedores. La empresa, las personas y los datos son simulados.

Comercial dice que crece y Finanzas muestra que vendió menos. Cada reunión se gasta discutiendo el Excel en lugar del negocio, y cada jefe de zona llega con una explicación distinta de por qué su zona va atrasada.

## Preguntas que responde

- ¿Cuánto vendimos este mes y cómo vamos contra la meta?
- ¿Cuánto falta y cuánto hay que vender por día hábil?
- ¿Qué zona y qué vendedor se están atrasando?
- ¿Cuánto hay confirmado que todavía no se factura, y qué lo detiene?
- ¿Cómo crecemos contra el mismo mes del año anterior, comparando lo comparable?

## Decisión de diseño

El reporte fija una definición de venta —la oficial es la facturada, neta de anulaciones, devoluciones y descuentos— y muestra aparte, sin sumarlo, lo confirmado que aún no se factura. Un puente de conciliación lleva de la facturación a la cifra oficial y cuadra con el cierre de Finanzas con diferencia de S/ 0,00.

## Cómo se armó

1. **Requerimiento y alcance.** Se aclaró qué es una venta, qué cifra manda en el comité y qué decisiones apoya el reporte, antes de tocar datos.
2. **Fuentes.** Cada indicador se trazó hasta el campo de origen. Los datos simulados se cargan de forma reproducible, sin datos de clientes reales.
3. **Modelo dimensional.** Cinco tablas de hechos, diez dimensiones y 23 relaciones, sin uniones entre hechos.
4. **Modelo semántico y DAX.** 33 medidas ordenadas en seis carpetas y seguridad por filas con seis roles de demostración.
5. **Calidad.** Cinco controles pasan antes de mostrar nada: cuadre, modelo, reglas críticas, filtros y permisos.
6. **Visual.** Dos páginas con la secuencia resultado, comparación, explicación y acción: Dirección y Zona y vendedor.

## Detalle técnico

Las fuentes se leen de forma directa con Power Query hacia un modelo en estrella; las transformaciones viven en M y SQL versionados. Las medidas DAX calculan venta oficial, cumplimiento, ritmo requerido y pendiente, y el reporte presenta Dirección y Zona y vendedor sobre ese modelo.

### Fuentes

- ERP SAP Business One simulado en SQL Server: pedidos, facturas, notas de crédito, clientes, productos, despachos y stock
- Excel de metas comerciales con versiones aprobadas
- Excel de cierre mensual de Finanzas
- CSV de pedidos de la tienda online (WooCommerce)

### Modelo

- Esquema en estrella: 5 hechos, 10 dimensiones, 23 relaciones
- Reconocimiento de la venta tras el cierre definitivo; ajustes y devoluciones tardías separados
- Metas originales y vigentes por versión aprobada
- Pendiente de facturar en seis grupos, nunca sumado a ventas ni al cumplimiento

### Calidad

- Cuadre: 34.369 documentos fiscales coinciden con sus cabeceras y 33 cierres con el Excel de Finanzas
- Modelo: 106.098 líneas fiscales con grano único y sin claves huérfanas
- Reglas críticas: 1.140 líneas pendientes recalculadas de forma independiente
- Filtros: 170 combinaciones mes/zona y 648 mes/vendedor comprobadas
- Permisos: seis roles verificados, sin acceso al detalle ajeno

> Reporte de demostración con datos simulados; no contiene información de clientes reales.

## Cómo abrirlo

El repo no incluye un .pbix ni la caché de datos: el proyecto (.pbip) se abre en Power BI Desktop con el modelo y las páginas, pero sin datos cargados. Las capturas muestran el resultado. Para refrescarlo: (1) cree en SQL Server una base `SBO_ANDINA_SIM` con `datos/sap_b1/_schema.sql` y cargue cada CSV de `datos/sap_b1/` en su tabla; (2) en Power BI Desktop, en *Transformar datos > Editar parámetros*, ponga `SqlServer` (su servidor), `SqlDatabase` (`SBO_ANDINA_SIM`) y `DataFolder` (la ruta completa de la carpeta `datos/`); (3) actualice.

## Contenido de esta carpeta

- `capturas/`
- `datos/`
- `reporte/`


---

# Executive sales — one official number

**Commercial** · Power BI · SQL Server · DAX · Row-level security

## The case

Suministros Andina is a fictional Peruvian distributor of tools, protective equipment and industrial consumables: three branches, about 110 employees and 18 salespeople. The company, the people and the data are simulated.

Sales says the business is growing and Finance shows lower sales. Every meeting is spent arguing about the spreadsheet instead of the business, and each regional manager arrives with a different explanation of why their region is behind.

## Questions it answers

- How much did we sell this month and how are we doing against target?
- How much is missing and how much must we sell per working day?
- Which region and which salesperson are falling behind?
- How much is confirmed but not yet invoiced, and what is holding it up?
- How are we growing against the same month last year, comparing like with like?

## Design decision

The report fixes one definition of sales — the official figure is invoiced revenue net of cancellations, returns and discounts — and shows confirmed-but-not-yet-invoiced orders separately, never added in. A reconciliation bridge walks from invoicing to the official figure and matches Finance's close with a difference of S/ 0.00.

## How it was built

1. **Requirements and scope.** We settled what counts as a sale, which number rules in the committee and which decisions the report supports, before touching any data.
2. **Sources.** Each metric was traced back to its source field. The simulated data loads reproducibly, with no real customer data.
3. **Dimensional model.** Five fact tables, ten dimensions and 23 relationships, with no fact-to-fact joins.
4. **Semantic model and DAX.** 33 measures organised in six folders and row-level security with six demo roles.
5. **Quality.** Five checks pass before anything is shown: reconciliation, model, critical rules, filters and permissions.
6. **Visuals.** Two pages following the sequence result, comparison, explanation and action: Executive view and Region and salesperson.

## Technical detail

Sources are read directly with Power Query into a star schema; transformations live in versioned M and SQL. DAX measures compute official sales, attainment, required run rate and backlog, and the report presents the Executive view and Region and salesperson on top of that model.

### Sources

- Simulated SAP Business One ERP on SQL Server: orders, invoices, credit notes, customers, products, shipments and stock
- Sales targets spreadsheet with approved versions
- Finance monthly close spreadsheet
- Online store order CSV (WooCommerce)

### Model

- Star schema: 5 facts, 10 dimensions, 23 relationships
- Revenue recognised after final close; late adjustments and returns kept separate
- Original and current targets by approved version
- Backlog split into six groups, never added to sales or attainment

### Quality

- Reconciliation: 34,369 fiscal documents match their headers and 33 closes match Finance's spreadsheet
- Model: 106,098 fiscal lines at a unique grain with no orphan keys
- Critical rules: 1,140 open lines recomputed independently
- Filters: 170 month/region and 648 month/salesperson combinations checked
- Permissions: six roles verified, none can see another seller's detail

> Demonstration report built on simulated data; it contains no real customer information.

## How to open it

The repo includes no .pbix and no data cache: the project (.pbip) opens in Power BI Desktop with the model and the pages, but with no data loaded. The screenshots show the result. To refresh it: (1) create a SQL Server database `SBO_ANDINA_SIM` with `datos/sap_b1/_schema.sql` and load each CSV in `datos/sap_b1/` into its table; (2) in Power BI Desktop, under *Transform data > Edit parameters*, set `SqlServer` (your server), `SqlDatabase` (`SBO_ANDINA_SIM`) and `DataFolder` (the full path of the `datos/` folder); (3) refresh.

## Contents of this folder

- `capturas/`
- `datos/`
- `reporte/`

