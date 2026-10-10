# Indicadores y reglas de lectura

## Personas inicio mes

Personas activas al cierre del día anterior al primer día del mes. Uso técnico mensual; no sumar snapshots.

```dax
COALESCE ( SUM ( FactDotacion[personas_inicio] ), 0 )
```

## Personas cierre mes

Personas distintas activas al cierre del mes por asignación histórica. Baja inclusiva. Grano validado persona/mes/asignación.

```dax
COALESCE ( SUM ( FactDotacion[personas_fin] ), 0 )
```

## FTE cierre mes

Suma de fracciones FTE vigentes al cierre del mes. Complementa personas; no compara con plan en personas.

```dax
COALESCE ( SUM ( FactDotacion[fte_fin] ), 0 )
```

## Plan cierre mes

Plan P2026 APROBADO en personas al cierre del mes; versión borrador excluida.

```dax
COALESCE ( SUM ( FactPlan[plan_personas] ), 0 )
```

## Brecha cierre mes

Personas reales menos plan del mismo mes/área/sede. Negativo significa bajo plan, no vacantes confirmadas.

```dax
[Personas cierre mes] - [Plan cierre mes]
```

## Dotación al cierre

Personas del último mes seleccionado; no suma meses.

```dax
VAR _mes = MAX ( DimMes[periodo] )
RETURN IF ( ISBLANK ( _mes ), BLANK (),
    CALCULATE ( [Personas cierre mes], KEEPFILTERS ( DimMes[periodo] = _mes ) ) )
```

## FTE al cierre

FTE del último mes seleccionado; no suma meses.

```dax
VAR _mes = MAX ( DimMes[periodo] )
RETURN IF ( ISBLANK ( _mes ), BLANK (),
    CALCULATE ( [FTE cierre mes], KEEPFILTERS ( DimMes[periodo] = _mes ) ) )
```

## Plan al cierre

Plan en personas del último mes seleccionado.

```dax
VAR _mes = MAX ( DimMes[periodo] )
RETURN IF ( ISBLANK ( _mes ), BLANK (),
    CALCULATE ( [Plan cierre mes], KEEPFILTERS ( DimMes[periodo] = _mes ) ) )
```

## Brecha al cierre

Real menos plan del último mes seleccionado; brecha absoluta en personas.

```dax
VAR _mes = MAX ( DimMes[periodo] )
RETURN IF ( ISBLANK ( _mes ), BLANK (),
    CALCULATE ( [Brecha cierre mes], KEEPFILTERS ( DimMes[periodo] = _mes ) ) )
```

## Altas del período

Altas de contratos en meses seleccionados. Reingreso tras intervalo cuenta alta; traslado no.

```dax
COALESCE ( CALCULATE ( COUNTROWS ( FactMovimiento ), FactMovimiento[tipo] = "ALTA" ), 0 )
```

## Bajas del período

Todas las bajas por fecha inclusiva en meses seleccionados; incluye fin de contrato. Conteo, sin tasa total.

```dax
COALESCE ( CALCULATE ( COUNTROWS ( FactMovimiento ), FactMovimiento[tipo] = "BAJA" ), 0 )
```

## Bajas voluntarias

Eventos de baja con motivo VOLUNTARIA. Conteo aditivo de meses, área y sede de la baja.

```dax
COALESCE ( CALCULATE ( COUNTROWS ( FactMovimiento ), FactMovimiento[tipo] = "BAJA", FactMovimiento[voluntaria] = 1 ), 0 )
```

## Base mensual ponderada

Suma de los promedios inicio/fin de cada mes seleccionado; conserva todos los filtros de área y sede.

```dax
SUMX ( VALUES ( DimMes[periodo] ), DIVIDE ( [Personas inicio mes] + [Personas cierre mes], 2 ) )
```

## Índice ponderado mensual

Bajas voluntarias divididas por suma de promedios mensuales inicio/fin. Un mes equivale a rotación mensual; varios meses NO son tasa anual ni suma/promedio de porcentajes. Base cero: BLANK.

```dax
DIVIDE ( [Bajas voluntarias], [Base mensual ponderada] )
```

## Costo empresa del período

Costo firmado en PEN por devengo de cierres y líneas CONTABILIZADO: HABER + CARGA_EMPRESA + AJUSTE. Suma meses seleccionados; no usa fecha de pago ni reprorratea.

```dax
COALESCE ( SUM ( FactCosto[costo_empresa_pen] ), 0 )
```

## Meses seleccionados

Cantidad de meses del contexto entre enero y septiembre de 2026.

```dax
COUNTROWS ( VALUES ( DimMes[periodo] ) )
```

## Último mes seleccionado

Mes de los snapshots de las tarjetas; los flujos acumulan los meses seleccionados.

```dax
MAX ( DimMes[periodo] )
```

