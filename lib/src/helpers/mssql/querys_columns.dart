mixin QuerysPercQtdSeparacoesColumnsNames {
  static const String percSeparado = 'PercSeparado';
  static const String percNSeparado = 'PercNSeparado';
  static const String qtdPedidoSeparado = 'QtdPedidoSeparado';
  static const String qtdPedidoNSeparado = 'QtdPedidoNSeparado';
}

mixin QueryQtdPorSeparadorColumnsNames {
  static const String separador = 'Separador';
  static const String qtdSeparada = 'QtdSeparada';
  static const String ticketAverage = 'TicketMedio';
}

mixin QueryQtdPorHoraColumnsNames {
  static const String hour = 'HoraDaSeparacao';
  static const String qtdSeparada = 'QtdPedidoSeparado';
}

mixin QueryOrdersColumnsNames {
  static const String id = 'IdMov';
  static const String typeMov = 'TipoMov';
  static const String statusSepMov = 'StatusSepMov';
  static const String dscStatusSepMov = 'DscStatusSepMov';
  static const String numMov = 'NumMov';
  static const String codClient = 'CodigoCliente';
  static const String nameClient = 'NomeCliente';
  static const String razClient = 'RazaoCliente';
  static const String cpfCNPJClient = 'CNPJCliente';
  static const String dateMov = 'DataMov';
  static const String vendor = 'Vendedor';
}

mixin QueryUserAccessCompaniesColumnsNames {
  static const String idCompany = 'CodFilial';
  static const String nameCompany = 'NomeFilial';
}

mixin QueryWheryColumnsNames {
  static const String operation = 'DataOperacao';
  static const String dtMov = 'DtMov';
}

mixin QueryOrderItemsColumnsNames {
  static const String idMov = 'IdMov';
  static const String idItemMov = 'IdItemMov';
  static const String image = 'Imagem';
  static const String productCod = 'Codigo';
  static const String productReference = 'Referencia';
  static const String productName = 'Nome';
  static const String productManufacturer = 'Fabricante';
  static const String productGroup = 'Grupo';
  static const String productStorageLocation = 'LocalArmazenamento';
  static const String productStandardUnit = 'UnidPadrao';
  static const String salesUnit = 'UnidVenda';
  static const String conversionFactor = 'Fator';
  static const String qttRequested = 'QtdSolicitada';
  static const String qttInvoiced = 'QtdFaturada';
  static const String qttSeparate = 'QtsSeparada';
  static const String currentBalance = 'SdoAtual';
  static const String hasAGrid = 'PossuiGrade';
  static const String hasASerialNumber = 'PossuiSerie';
  static const String hasABatchNumber = 'PossuiLote';
}
