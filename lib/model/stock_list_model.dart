class StockListModel {
  final String stockSymbol;
  final String name;
  final String code;
  

  StockListModel(this.stockSymbol,this.name, this.code,);

  Map<String, dynamic> toMap() {
    return {
      'stockSymbol': stockSymbol,
      'name': name,
      'code': code,
    };
  }
    StockListModel.fromMap(Map<String, dynamic> map)
      : stockSymbol = map['stockSymbol'],
        name = map['name'],
        code = map['code'];

}
