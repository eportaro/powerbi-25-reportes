# Indicadores · Valle

Definiciones de uso y fórmulas versionadas. Motor DAX pendiente.

## 01 Resultado · Venta recibida

Venta documental recibida neta sin IGV, luego de deduplicación y precedencia ERP. Puede ser parcial; no es cierre oficial.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[venta] )
```

## 04 Contexto · Meses seleccionados

Meses del contexto; universo enero-junio 2026.

Formato: `0`. Técnico oculto: True.

```dax
COUNTROWS ( VALUES ( DimMes[periodo] ) )
```

## 04 Contexto · Meses pendientes

Meses seleccionados sin cabecera y líneas completas. No baja al filtrar cliente/asesor.

Formato: `0`. Técnico oculto: False.

```dax
COUNTROWS ( FILTER ( VALUES ( DimMes[periodo] ), CALCULATE ( MAX ( DimMes[completo] ) ) = 0 ) )
```

## 04 Contexto · Estado de cobertura

Completitud de fuentes del contexto; no implica Desktop validado ni aceptación humana.

Formato: ``. Técnico oculto: False.

```dax
IF ( [Meses seleccionados] = 0, "Sin período", IF ( [Meses pendientes] > 0, "PARCIAL · falta entrega", "COMPLETO · fuentes recibidas" ) )
```

## 02 Conciliación · Ajustes de cierre

Ajuste financiero sin reparto. Sólo aplica bajo filtros de mes; BLANK por cliente, producto o cualquier asesor.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISCROSSFILTERED ( DimCliente ) || ISCROSSFILTERED ( DimProducto ) || ISCROSSFILTERED ( DimAsesorHistorico ) || ISCROSSFILTERED ( DimAsesorActual ), BLANK (), SUM ( FactAjuste[ajuste] ) )
```

## 01 Resultado · Venta oficial

Cierre: venta recibida + ajuste permitido por ámbito. BLANK si cualquier mes seleccionado falta. Bajo asesor/producto/cliente conserva venta atribuida y explica ajuste excluido.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( [Meses seleccionados] > 0 && [Meses pendientes] = 0, IF ( ISBLANK ( [Venta recibida] ) && ISBLANK ( [Ajustes de cierre] ), BLANK (), COALESCE ( [Venta recibida], 0 ) + COALESCE ( [Ajustes de cierre], 0 ) ), BLANK () )
```

## 01 Resultado · Costo recibido

Costo de líneas del mismo grano/contexto de venta; nunca suma costo de cabecera.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[costo] )
```

## 01 Resultado · Costo oficial

Costo recibido + costo del ajuste sólo en ámbito compatible; BLANK por cobertura incompleta.

Formato: `"S/ "#,0.00`. Técnico oculto: True.

```dax
IF ( [Meses seleccionados] > 0 && [Meses pendientes] = 0, [Costo recibido] + IF ( ISCROSSFILTERED ( DimCliente ) || ISCROSSFILTERED ( DimProducto ) || ISCROSSFILTERED ( DimAsesorHistorico ) || ISCROSSFILTERED ( DimAsesorActual ), 0, COALESCE ( SUM ( FactAjuste[costo_ajuste] ), 0 ) ), BLANK () )
```

## 01 Resultado · Margen oficial

Venta oficial menos costo oficial bajo el mismo ámbito. No mostrar margen oficial de cobertura parcial.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISBLANK ( [Venta oficial] ), BLANK (), [Venta oficial] - [Costo oficial] )
```

## 01 Resultado · Margen %

Margen total / venta total del contexto; no suma ni promedia porcentajes de líneas. Venta cero: BLANK.

Formato: `0.0%`. Técnico oculto: False.

```dax
DIVIDE ( [Margen oficial], [Venta oficial] )
```

## 03 Metas · Meta comercial

Meta mensual por asesor histórico: base×factor HALF_UP. No aplicable por cliente, producto o cartera actual; no distribuir artificialmente.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISCROSSFILTERED ( DimCliente ) || ISCROSSFILTERED ( DimProducto ) || ISCROSSFILTERED ( DimAsesorActual ), BLANK (), SUM ( FactMeta[meta] ) )
```

## 03 Metas · Cumplimiento

Venta oficial / meta aplicable recalculado en total; BLANK por cobertura incompleta o ámbito no compatible.

Formato: `0.0%`. Técnico oculto: False.

```dax
DIVIDE ( [Venta oficial], [Meta comercial] )
```

## 03 Metas · Brecha a meta

Meta menos venta oficial. Positivo indica venta faltante; no equivale a forecast.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISBLANK ( [Venta oficial] ) || ISBLANK ( [Meta comercial] ), BLANK (), [Meta comercial] - [Venta oficial] )
```

## 04 Contexto · Aplicación de meta

Explica por qué no se evalúa meta/cumplimiento, sin representar BLANK como cero.

Formato: ``. Técnico oculto: False.

```dax
IF ( ISCROSSFILTERED ( DimCliente ) || ISCROSSFILTERED ( DimProducto ) || ISCROSSFILTERED ( DimAsesorActual ), "META NO APLICABLE · ámbito", IF ( [Meses pendientes] > 0, "CUMPLIMIENTO PENDIENTE · fuentes", "Meta por mes / asesor histórico" ) )
```

## 02 Conciliación · Legacy válido único

Legacy luego de clave vacía/deduplicación; incluye líneas sustituidas para el puente.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[legacy_base] )
```

## 02 Conciliación · ERP nuevo recibido

Nuevas líneas recibidas incluida última semana marzo; cabeceras sólo controlan.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[nuevo_base] )
```

## 02 Conciliación · Legacy sustituido

Legacy retirado por mismo negocio cuando ERP nuevo prevalece; restar del puente.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[legacy_sustituido] )
```

## 02 Conciliación · Corrección de migración

Diferencia nuevo−legacy de operaciones repetidas; no se suma otra vez al puente.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
SUM ( FactVenta[correccion_migracion] )
```

## 02 Conciliación · Puente documental

Legacy válido + nuevo recibido − legacy sustituido. Debe igualar venta recibida. Sin filas recibidas: BLANK.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISBLANK ( [Venta recibida] ), BLANK (), [Legacy válido único] + [ERP nuevo recibido] - [Legacy sustituido] )
```

## 02 Conciliación · Diferencia de puente

Diferencia independiente de visuales: cero con datos válidos, BLANK sin filas recibidas. No prueba DAX runtime hasta consultar motor.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
IF ( ISBLANK ( [Venta recibida] ), BLANK (), [Puente documental] - [Venta recibida] )
```

## 04 Contexto · Documentos recibidos

Negocios únicos recibidos luego de precedencia; no contar dos sistemas como dos ventas.

Formato: `#,0`. Técnico oculto: False.

```dax
DISTINCTCOUNT ( FactVenta[business_id] )
```

## 04 Contexto · Líneas recibidas

Grano único de línea documental canónica en mart.

Formato: `#,0`. Técnico oculto: True.

```dax
COUNTROWS ( FactVenta )
```

## 04 Contexto · Venta sin historia

Ventas con asesor histórico desconocido; incluidas en venta recibida, separadas de asesores identificados.

Formato: `"S/ "#,0.00`. Técnico oculto: False.

```dax
CALCULATE ( [Venta recibida], KEEPFILTERS ( FactVenta[sin_historia] = 1 ) )
```
