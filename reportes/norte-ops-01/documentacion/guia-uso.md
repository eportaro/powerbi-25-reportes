# Guía breve — Inventario y disponibilidad

Una página al corte 30/09/2026. Seleccionar almacén y familia; comenzar por stock/valor/prometible, detectar alertas y bajar al detalle SKU/almacén para decidir reposición. Los filtros afectan ambos hechos mediante dimensiones compartidas, sin relacionar hechos entre sí.

| Elemento | Uso y límite |
|---|---|
| Saldo | Stock físico ERP, incluye reserva y bloqueo; no representa disponibilidad para prometer |
| Valor stock | Saldo por costo promedio oficial SKU/almacén, PEN sin IGV; redondeo por combinación antes de sumar |
| Disponible prometible | Máximo de saldo menos reserva activa menos bloqueo abierto y cero por combinación |
| Alertas | Combinaciones con prometible estrictamente menor al mínimo vigente; igualdad no alerta |
| Compra pendiente | Solo compras confirmadas, cantidad pedida menos recepciones contabilizadas al corte |
| Valor por familia | Dónde está concentrado el valor contable del stock |
| Detalle | SKU/almacén, reservas, bloqueos, neto, faltante, mínimo, pendiente y atraso para diagnosticar la señal |
| Prioridad | Faltante → sin disponible → bajo mínimo → normal; desempate por valor del faltante y códigos; solo detalle único |

Política ausente o inválida exige revisión; no inventa mínimo, objetivo ni alerta. Compra sin fecha conserva pendiente y exige confirmar fecha; no se declara atrasada. No hay rotación, cobertura ni predicción: las fuentes no tienen demanda validada suficiente.

Para abrir y configurar DataFolder, seguir el README de esta entrega. Desktop lee datos/modelo; no recalcula el ETL sobre las fuentes RAW.
