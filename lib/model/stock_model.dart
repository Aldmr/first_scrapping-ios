class StockModel {
  String symbol;
  String? name;
  String? code;
  int? presentationCurrency;
  String? inappropriateActivity;
  String? improperPrivilege;
  double? kfifRateRevanue;
  String? improperSecurity;
  String? allSecurity;
  double? kfifRateSecurity;
  String? improperDebt;
  String? allDebt;
  double? kfifRateDebt;
  double? rate;
  double? lastprice;
  String? lastpricestr;
  double? hacim;
  String? hacimstr;
  dynamic min;
  String? minstr;
  dynamic max;
  String? maxstr;
  String? time;
  double? allLotCount;

  StockModel(
      {this.name,
      this.code,
      this.presentationCurrency,
      this.improperPrivilege,
      this.inappropriateActivity,
      this.kfifRateRevanue,
      this.improperSecurity,
      this.allSecurity,
      this.kfifRateSecurity,
      this.improperDebt,
      this.allDebt,
      this.kfifRateDebt,
      required this.symbol,
      this.rate,
      this.lastprice,
      this.lastpricestr,
      this.hacim,
      this.hacimstr,
      this.min,
      this.minstr,
      this.max,
      this.maxstr,
      this.time,
      this.allLotCount});

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'name': name,
      'code': code,
      'presentationCurrency': presentationCurrency ?? 2,
      'improperPrivilege': improperPrivilege,
      'inappropriateActivity': inappropriateActivity,
      'kfifRateRevanue': kfifRateRevanue,
      'improperSecurity': improperSecurity,
      'allSecurity': allSecurity,
      'kfifRateSecurity': kfifRateSecurity,
      'improperDebt': improperDebt,
      'allDebt': allDebt,
      'kfifRateDebt': kfifRateDebt,
      "rate": rate,
      "lastprice": lastprice,
      "lastpricestr": lastpricestr ?? "null",
      "hacim": hacim,
      "hacimstr": hacimstr ?? "null",
      "min": min,
      "minstr": minstr ?? "null",
      "max": max,
      "maxstr": maxstr ?? "null",
      "time": time ?? "null",
      "allLotCount": allLotCount
    };
  }

  StockModel.fromMap(Map<String, dynamic> map)
      : symbol = map['symbol'],
        name = map['name'],
        code = map['code'],
        presentationCurrency = map['presentationCurrency'],
        improperPrivilege = map['improperPrivilege'],
        inappropriateActivity = map['inappropriateActivity'],
        kfifRateRevanue = map['kfifRateRevanue'].toDouble(),
        improperSecurity = map['improperSecurity'],
        allSecurity = map['allSecurity'],
        kfifRateSecurity = map['kfifRateSecurity'],
        improperDebt = map['improperDebt'],
        allDebt = map['allDebt'],
        kfifRateDebt = map['kfifRateDebt'],
        rate = map["rate"]?.toDouble(),
        lastprice = map["lastprice"]?.toDouble(),
        lastpricestr = map["lastpricestr"],
        hacim = map["hacim"]?.toDouble(),
        hacimstr = map["hacimstr"],
        min = map["min"],
        minstr = map["minstr"],
        max = map["max"],
        maxstr = map["maxstr"],
        time = map["time"],
        allLotCount = map["allLotCount"].toDouble();

  @override
  String toString() {
    return "symbol:$symbol\nname:$name\ncode:$code\npresentationCurrency:$presentationCurrency\nimproperPrivilege:$improperPrivilege\ninappropriateActivity:$inappropriateActivity\nrevanue:$kfifRateRevanue\nsecurity:$improperSecurity\nallSecurity:$allSecurity\nkfifRateSecurity:$kfifRateSecurity\ndebt:$improperDebt\nalldebt:$allDebt\nkfifRateDebt:$kfifRateDebt";
  }
}
