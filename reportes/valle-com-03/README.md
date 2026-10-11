# Distribuidora Valle — Migración ERP y cartera

Caso de demostración con empresa y datos ficticios. Enero–junio 2026, soles sin
IGV. ERP legacy en CSV, ERP nuevo exportado a cabeceras/líneas CSV y Excel de
metas/cartera/equivalencias/ajuste de cierre. Conexión SQL real no ejecutada.

## Abrir

1. Abra `reporte/valle-com-03.pbip` en Power BI Desktop.
2. En Transformar datos → Administrar parámetros, configure **DataFolder** con
   la ruta absoluta de `datos/modelo` de esta copia.
3. Actualice y guarde. Esta copia portable no se ha refrescado en otra PC.

Modelo de tres hechos, cinco dimensiones y ocho relaciones unidireccionales.
23 medidas DAX en cuatro carpetas; dos páginas: Resultado comercial y Conciliación.
Motor comprobado contra RAW independiente: 98 contextos / 2.262 controles.

Los datos originales se conservan en `datos/fuentes`; el modelo procesado está
en `datos/modelo`. Desktop refresca el modelo procesado, no ejecuta el ETL.
Reglas, definiciones y guía están en `documentacion`. El PBIP conserva la revisión
visual 2 guardada y comprobada en Desktop. PDF/PNG son la exportación nativa anterior
conservada; no representan necesariamente la distribución actual del PBIP.

## English

Fictional ERP migration and account-assignment case. Open the PBIP, set DataFolder
to this package's absolute `datos/modelo` directory, then refresh and save.
The package contains synthetic RAW sources, eight model tables, 23 DAX measures,
two native report pages and the original PDF export. 98 engine contexts / 2,262
checks match an independent RAW reconstruction. The portable copy has not been
refreshed on another computer. The PBIP preserves the saved and Desktop-reviewed
second layout revision. PDF/PNG files preserve the previous native export and may
differ from the current interactive layout.

Publication is handled separately; the gallery card remains `ready:false`.
