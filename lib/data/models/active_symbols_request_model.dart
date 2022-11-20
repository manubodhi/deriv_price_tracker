class ActiveSymbolsRequestModel {
  ActiveSymbolsRequestModel({
    required this.activeSymbols,
    required this.productType,
  });

  final String? activeSymbols;
  final String? productType;

  factory ActiveSymbolsRequestModel.fromJson(Map<String, dynamic> json) {
    return ActiveSymbolsRequestModel(
      activeSymbols: json["active_symbols"],
      productType: json["product_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "active_symbols": activeSymbols,
        "product_type": productType,
      };
}
