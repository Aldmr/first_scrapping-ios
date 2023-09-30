import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:first_scrapping/model/stock_model.dart';
import 'package:first_scrapping/model/stock_price_model.dart';
import 'package:first_scrapping/model/stocks_price_json_model.dart';

abstract class StockDBBase {
  Future<bool> saveStock(StockModel stockModel);
  Future<bool> saveStockList(StockListModel stockList);
  Future<bool> readFromStockListAndEditUrl(String symbol);
  Future<bool> saveStocksPriceList(StockPriceModel stockPriceModel);
  Future<bool> readStockPrice(String symbol);
  Future<bool> saveOnlyLotCount(StockModel stockModel);
}
