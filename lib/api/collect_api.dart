import 'dart:convert';

import 'package:first_scrapping/model/stocks_price_json_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class CollectApi {
  Future<StocksJsonModel> fetchAlbum() async {
    var res = await http.get(
        Uri.parse("https://api.collectapi.com/economy/hisseSenedi"),
        headers: {
          'content-type': "application/json",
          'authorization':
              "apikey 34ArG9SmTFmysPMkQ1l152:2AX6xG7DsA0bZMxDyP95PB"
        });

    var decode = stocksJsonModelFromJson(res.body);

    //print(decode.result[0].lastprice.toString());
    return decode;
  }
}
