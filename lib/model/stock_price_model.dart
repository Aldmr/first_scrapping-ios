class StockPriceModel {
  final double rate;
  final double lastprice;
  final String lastpricestr;
  final double hacim;
  final String hacimstr;
  final dynamic min;
  final String minstr;
  final dynamic max;
  final String maxstr;
  final String time;
  final String text;
  final String code;

  StockPriceModel(
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
    this.text,
    this.code,
  );
  Map<String, dynamic> toMap() {
    return {
      "rate": rate,
      "lastprice": lastprice,
      "lastpricestr": lastpricestr,
      "hacim": hacim,
      "hacimstr": hacimstr,
      "min": min,
      "minstr": minstr,
      "max": max,
      "maxstr": maxstr,
      "time": time,
      "text": text,
      "code": code
    };
  }

  StockPriceModel.fromMap(Map<String, dynamic> map)
      : rate = map["rate"]?.toDouble(),
        lastprice = map["lastprice"]?.toDouble(),
        lastpricestr = map["lastpricestr"],
        hacim = map["hacim"]?.toDouble(),
        hacimstr = map["hacimstr"],
        min = map["min"],
        minstr = map["minstr"],
        max = map["max"],
        maxstr = map["maxstr"],
        time = map["time"],
        text = map["text"],
        code = map["code"];
}
