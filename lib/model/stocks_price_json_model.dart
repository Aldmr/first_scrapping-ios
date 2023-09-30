// To parse this JSON data, do
//
//     final stocksJsonModel = stocksJsonModelFromJson(jsonString);

import 'dart:convert';

StocksJsonModel stocksJsonModelFromJson(String str) =>
    StocksJsonModel.fromJson(json.decode(str));

String stocksPriceJsonModelToJson(StocksJsonModel data) =>
    json.encode(data.toJson());

class StocksJsonModel {
  bool success;
  List<Result> result;

  StocksJsonModel({
    required this.success,
    required this.result,
  });

  factory StocksJsonModel.fromJson(Map<String, dynamic> json) =>
      StocksJsonModel(
        success: json["success"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  double rate;
  double lastprice;
  String lastpricestr;
  double hacim;
  String hacimstr;
  dynamic min;
  String minstr;
  dynamic max;
  String maxstr;
  String time;
  String text;
  String code;

  Result({
    required this.rate,
    required this.lastprice,
    required this.lastpricestr,
    required this.hacim,
    required this.hacimstr,
    required this.min,
    required this.minstr,
    required this.max,
    required this.maxstr,
    required this.time,
    required this.text,
    required this.code,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        rate: json["rate"]?.toDouble(),
        lastprice: json["lastprice"]?.toDouble(),
        lastpricestr: json["lastpricestr"],
        hacim: json["hacim"]?.toDouble(),
        hacimstr: json["hacimstr"],
        min: json["min"],
        minstr: json["minstr"],
        max: json["max"],
        maxstr: json["maxstr"],
        time: json["time"],
        text: json["text"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
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
        "code": code,
      };
}
