-- Esquema SAP Business One simulado. Generado, no editar.

-- OCRG: Grupos de socios de negocio
CREATE TABLE [dbo].[OCRG] (
    [GroupCode] int NULL,
    [GroupName] nvarchar(20) NULL,
    [GroupType] char(1) NULL
);

-- OTER: Territorios
CREATE TABLE [dbo].[OTER] (
    [territryID] int NULL,
    [descript] nvarchar(30) NULL,
    [inactive] char(1) NULL
);

-- OSLP: Empleados de ventas. SAP no guarda la zona: U_Zona es la de hoy
CREATE TABLE [dbo].[OSLP] (
    [SlpCode] int NULL,
    [SlpName] nvarchar(155) NULL,
    [Memo] nvarchar(50) NULL,
    [Active] char(1) NULL,
    [U_Zona] nvarchar(30) NULL
);

-- OCRD: Socios de negocio (clientes)
CREATE TABLE [dbo].[OCRD] (
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [CardType] char(1) NULL,
    [GroupCode] int NULL,
    [LicTradNum] nvarchar(32) NULL,
    [SlpCode] int NULL,
    [Territory] int NULL,
    [FatherCard] nvarchar(15) NULL,
    [FatherType] char(1) NULL,
    [PartDelivr] char(1) NULL,
    [CreditLine] numeric(19,6) NULL,
    [frozenFor] char(1) NULL,
    [CreateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL,
    [U_BloqCred] char(1) NULL,
    [U_ExigeOC] char(1) NULL
);

-- CRD1: Direcciones de socios de negocio
CREATE TABLE [dbo].[CRD1] (
    [CardCode] nvarchar(15) NULL,
    [Address] nvarchar(50) NULL,
    [AdresType] char(1) NULL,
    [Street] nvarchar(100) NULL,
    [City] nvarchar(100) NULL,
    [County] nvarchar(100) NULL
);

-- OITB: Grupos de artículos (línea de producto)
CREATE TABLE [dbo].[OITB] (
    [ItmsGrpCod] int NULL,
    [ItmsGrpNam] nvarchar(20) NULL
);

-- OITM: Artículos
CREATE TABLE [dbo].[OITM] (
    [ItemCode] nvarchar(50) NULL,
    [ItemName] nvarchar(200) NULL,
    [ItmsGrpCod] int NULL,
    [InvntItem] char(1) NULL,
    [SellItem] char(1) NULL,
    [validFor] char(1) NULL,
    [AvgPrice] numeric(19,6) NULL,
    [CreateDate] datetime NULL
);

-- OWHS: Almacenes
CREATE TABLE [dbo].[OWHS] (
    [WhsCode] nvarchar(8) NULL,
    [WhsName] nvarchar(100) NULL,
    [City] nvarchar(100) NULL
);

-- OITW: Stock por artículo y almacén, foto al corte
CREATE TABLE [dbo].[OITW] (
    [ItemCode] nvarchar(50) NULL,
    [WhsCode] nvarchar(8) NULL,
    [OnHand] numeric(19,6) NULL,
    [IsCommited] numeric(19,6) NULL,
    [OnOrder] numeric(19,6) NULL
);

-- OQUT: Ofertas de venta (cotizaciones)
CREATE TABLE [dbo].[OQUT] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [DocType] char(1) NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [TaxDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [NumAtCard] nvarchar(100) NULL,
    [SlpCode] int NULL,
    [ShipToCode] nvarchar(50) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [DiscSum] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [DocTotal] numeric(19,6) NULL,
    [DocCur] nvarchar(3) NULL,
    [DocRate] numeric(19,6) NULL,
    [DocTotalFC] numeric(19,6) NULL,
    [Comments] nvarchar(254) NULL,
    [CreateDate] datetime NULL,
    [DocTime] int NULL,
    [UpdateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL
);

-- QUT1: Líneas de cotización
CREATE TABLE [dbo].[QUT1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Dscription] nvarchar(200) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [Price] numeric(19,6) NULL,
    [PriceBefDi] numeric(19,6) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [LineTotal] numeric(19,6) NULL,
    [TotalFrgn] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [SlpCode] int NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL,
    [BaseType] int NULL,
    [BaseEntry] int NULL,
    [BaseLine] int NULL,
    [TargetType] int NULL,
    [TrgetEntry] int NULL,
    [StockPrice] numeric(19,6) NULL
);

-- ORDR: Pedidos de cliente
CREATE TABLE [dbo].[ORDR] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [DocType] char(1) NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [TaxDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [NumAtCard] nvarchar(100) NULL,
    [SlpCode] int NULL,
    [ShipToCode] nvarchar(50) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [DiscSum] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [DocTotal] numeric(19,6) NULL,
    [DocCur] nvarchar(3) NULL,
    [DocRate] numeric(19,6) NULL,
    [DocTotalFC] numeric(19,6) NULL,
    [Comments] nvarchar(254) NULL,
    [CreateDate] datetime NULL,
    [DocTime] int NULL,
    [UpdateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL,
    [PartSupply] char(1) NULL,
    [Confirmed] char(1) NULL,
    [U_WooOrderId] int NULL
);

-- RDR1: Líneas de pedido
CREATE TABLE [dbo].[RDR1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Dscription] nvarchar(200) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [Price] numeric(19,6) NULL,
    [PriceBefDi] numeric(19,6) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [LineTotal] numeric(19,6) NULL,
    [TotalFrgn] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [SlpCode] int NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL,
    [BaseType] int NULL,
    [BaseEntry] int NULL,
    [BaseLine] int NULL,
    [TargetType] int NULL,
    [TrgetEntry] int NULL,
    [StockPrice] numeric(19,6) NULL
);

-- ODLN: Entregas
CREATE TABLE [dbo].[ODLN] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [DocType] char(1) NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [TaxDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [NumAtCard] nvarchar(100) NULL,
    [SlpCode] int NULL,
    [ShipToCode] nvarchar(50) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [DiscSum] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [DocTotal] numeric(19,6) NULL,
    [DocCur] nvarchar(3) NULL,
    [DocRate] numeric(19,6) NULL,
    [DocTotalFC] numeric(19,6) NULL,
    [Comments] nvarchar(254) NULL,
    [CreateDate] datetime NULL,
    [DocTime] int NULL,
    [UpdateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL
);

-- DLN1: Líneas de entrega
CREATE TABLE [dbo].[DLN1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Dscription] nvarchar(200) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [Price] numeric(19,6) NULL,
    [PriceBefDi] numeric(19,6) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [LineTotal] numeric(19,6) NULL,
    [TotalFrgn] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [SlpCode] int NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL,
    [BaseType] int NULL,
    [BaseEntry] int NULL,
    [BaseLine] int NULL,
    [TargetType] int NULL,
    [TrgetEntry] int NULL,
    [StockPrice] numeric(19,6) NULL
);

-- OINV: Facturas de clientes. CANCELED: N normal, Y anulada, C documento de cancelación
CREATE TABLE [dbo].[OINV] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [DocType] char(1) NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [TaxDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [NumAtCard] nvarchar(100) NULL,
    [SlpCode] int NULL,
    [ShipToCode] nvarchar(50) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [DiscSum] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [DocTotal] numeric(19,6) NULL,
    [DocCur] nvarchar(3) NULL,
    [DocRate] numeric(19,6) NULL,
    [DocTotalFC] numeric(19,6) NULL,
    [Comments] nvarchar(254) NULL,
    [CreateDate] datetime NULL,
    [DocTime] int NULL,
    [UpdateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL,
    [FolioPref] nvarchar(4) NULL,
    [FolioNum] int NULL
);

-- INV1: Líneas de factura
CREATE TABLE [dbo].[INV1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Dscription] nvarchar(200) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [Price] numeric(19,6) NULL,
    [PriceBefDi] numeric(19,6) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [LineTotal] numeric(19,6) NULL,
    [TotalFrgn] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [SlpCode] int NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL,
    [BaseType] int NULL,
    [BaseEntry] int NULL,
    [BaseLine] int NULL,
    [TargetType] int NULL,
    [TrgetEntry] int NULL,
    [StockPrice] numeric(19,6) NULL
);

-- ORIN: Notas de crédito de clientes
CREATE TABLE [dbo].[ORIN] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [DocType] char(1) NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [TaxDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL,
    [NumAtCard] nvarchar(100) NULL,
    [SlpCode] int NULL,
    [ShipToCode] nvarchar(50) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [DiscSum] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [DocTotal] numeric(19,6) NULL,
    [DocCur] nvarchar(3) NULL,
    [DocRate] numeric(19,6) NULL,
    [DocTotalFC] numeric(19,6) NULL,
    [Comments] nvarchar(254) NULL,
    [CreateDate] datetime NULL,
    [DocTime] int NULL,
    [UpdateDate] datetime NULL,
    [U_Canal] nvarchar(20) NULL,
    [FolioPref] nvarchar(4) NULL,
    [FolioNum] int NULL,
    [U_MotivoNC] nvarchar(30) NULL,
    [U_TipoNC] nvarchar(2) NULL,
    [U_DocRef] nvarchar(20) NULL
);

-- RIN1: Líneas de nota de crédito
CREATE TABLE [dbo].[RIN1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Dscription] nvarchar(200) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [Price] numeric(19,6) NULL,
    [PriceBefDi] numeric(19,6) NULL,
    [DiscPrcnt] numeric(19,6) NULL,
    [LineTotal] numeric(19,6) NULL,
    [TotalFrgn] numeric(19,6) NULL,
    [VatSum] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [SlpCode] int NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL,
    [BaseType] int NULL,
    [BaseEntry] int NULL,
    [BaseLine] int NULL,
    [TargetType] int NULL,
    [TrgetEntry] int NULL,
    [StockPrice] numeric(19,6) NULL,
    [ReturnRsn] int NULL
);

-- OPOR: Pedidos de compra (solo los abiertos desde agosto de 2026)
CREATE TABLE [dbo].[OPOR] (
    [DocEntry] int NULL,
    [DocNum] int NULL,
    [CANCELED] char(1) NULL,
    [DocStatus] char(1) NULL,
    [DocDate] datetime NULL,
    [DocDueDate] datetime NULL,
    [CardCode] nvarchar(15) NULL,
    [CardName] nvarchar(100) NULL
);

-- POR1: Líneas de pedido de compra: ShipDate es la llegada estimada
CREATE TABLE [dbo].[POR1] (
    [DocEntry] int NULL,
    [LineNum] int NULL,
    [ItemCode] nvarchar(50) NULL,
    [Quantity] numeric(19,6) NULL,
    [OpenQty] numeric(19,6) NULL,
    [WhsCode] nvarchar(8) NULL,
    [ShipDate] datetime NULL,
    [LineStatus] char(1) NULL
);

-- OPKL: Listas de picking (reserva de stock), foto al corte
CREATE TABLE [dbo].[OPKL] (
    [AbsEntry] int NULL,
    [PickDate] datetime NULL,
    [Status] char(1) NULL,
    [Remarks] nvarchar(254) NULL
);

-- PKL1: Líneas de picking: RelQtty es lo liberado para el pedido
CREATE TABLE [dbo].[PKL1] (
    [AbsEntry] int NULL,
    [PickEntry] int NULL,
    [OrderEntry] int NULL,
    [OrderLine] int NULL,
    [BaseObject] int NULL,
    [RelQtty] numeric(19,6) NULL,
    [PickQtty] numeric(19,6) NULL,
    [PickStatus] char(1) NULL
);

-- OHLD: Calendarios de feriados
CREATE TABLE [dbo].[OHLD] (
    [HldCode] nvarchar(20) NULL
);

-- HLD1: Feriados de cada calendario
CREATE TABLE [dbo].[HLD1] (
    [HldCode] nvarchar(20) NULL,
    [StrDate] datetime NULL,
    [EndDate] datetime NULL,
    [Rmrks] nvarchar(50) NULL
);
