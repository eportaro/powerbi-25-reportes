# Reglas de negocio · Distribuidora Valle

Empresa ficticia, enero–junio 2026. Venta documental en soles sin IGV y costo por
línea. ERP nuevo prevalece en negocios repetidos según business_id, conservando
fecha/cliente/artículo; no sumar cabecera además de sus líneas.

- Identidades homologadas; ZZ corresponde a CLIENTE-B para este caso. Una nueva
  equivalencia ambigua requiere confirmación, no expansión a dos clientes.
- Duplicado idéntico cuenta una vez; clave vacía no contabilizada se excluye.
- Atribución histórica por intervalos [desde,hasta). CB1 termina 17 junio;
  CLIENTE-C enero–febrero permanece sin asignación histórica.
- Cartera actual al 30 junio es una comparación separada, no una corrección del pasado.
- Meta por mes/asesor: base × factor, HALF_UP a céntimos. Cliente/producto y cartera
  actual no tienen meta distribuida; esos ámbitos son no aplicables.
- Ajuste de marzo -250 PEN, costo cero, en total sin asignación comercial.
- Mayo incompleto impide evaluar cierre y cumplimiento que lo incluyen. Recibir
  cabeceras y líneas habilita el recálculo; no fabricar ceros antes de la entrega.
- Margen y cumplimiento se recalculan como ratios de totales, no suma de porcentajes.

No hay historiales de stock/cohortes reconstruidos ni SQL real ejecutado. Las
fuentes del ERP nuevo son exportaciones simuladas CSV de un sistema relacional.
