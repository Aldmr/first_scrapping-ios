import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_scrapping/controller.dart';
import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:first_scrapping/model/stock_model.dart';
import 'package:first_scrapping/model/stock_price_model.dart';
import 'package:first_scrapping/model/stocks_price_json_model.dart';
import 'package:first_scrapping/services_firebase/stock_db_base.dart';
import 'package:get/get.dart';

class StockFirebaseService extends StockDBBase {
  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;
  final ScrapController controller = Get.put(ScrapController());

  @override
  Future<bool> saveStock(StockModel stockModel) async {
    await _firestoreAuth
        .collection("StockInfo")
        .doc(stockModel.symbol)
        .set(stockModel.toMap());

    return true;
  }

  @override
  Future<bool> saveOnlyLotCount(StockModel stockModel) async {
    await _firestoreAuth
        .collection("StockInfo")
        .doc(stockModel.symbol)
        .update({"kfifRateDebt": stockModel.kfifRateDebt});
    return true;
  }

  @override
  Future<bool> saveStockList(StockListModel stockList) async {
    await _firestoreAuth
        .collection("StockList")
        .doc(stockList.stockSymbol)
        .set(stockList.toMap());
    return true;
  }

  @override
  Future<bool> saveStocksPriceList(StockPriceModel stockPriceModel) async {
    await _firestoreAuth
        .collection("StockListPrice")
        .doc(stockPriceModel.code)
        .set(stockPriceModel.toMap());
    return true;
  }

  @override
  Future<bool> readStockPrice(String symbol) async {
    DocumentSnapshot<Map<String, dynamic>> readingStockPrice =
        await _firestoreAuth.collection("StockListPrice").doc(symbol).get();
    Map<String, dynamic>? didReadStockPrice = readingStockPrice.data();
    StockPriceModel readStockPrice =
        StockPriceModel.fromMap(didReadStockPrice!);
    controller.stockPrice = readStockPrice.lastprice;
    return true;
  }

  @override
  Future<bool> readFromStockListAndEditUrl(String symbol) async {
    if (symbol == "Tüm Liste") {
      QuerySnapshot<Map<String, dynamic>> allDoc =
          await _firestoreAuth.collection("StockList").get();
      for (int i = 0; i < allDoc.docs.length; i++) {
        Map<String, dynamic>? data = allDoc.docs[i].data();
        controller.allDocs[i] = StockListModel.fromMap(data);
      }
      print(controller.allDocs[1]!.stockSymbol);
    } else {
      DocumentSnapshot<Map<String, dynamic>> readingStockOneSymbol =
          await _firestoreAuth.collection("StockList").doc(symbol).get();

      Map<String, dynamic>? didReadStockPrice = readingStockOneSymbol.data();
      StockListModel readOneStock = StockListModel.fromMap(didReadStockPrice!);
      controller.stockListModel = readOneStock;
      print(readOneStock.code);
    }
    return true;
  }
}
