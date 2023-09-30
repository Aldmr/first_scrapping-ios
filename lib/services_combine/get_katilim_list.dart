import 'package:first_scrapping/locator.dart';
import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:first_scrapping/services_firebase/stock_firebase_service.dart';
import 'package:first_scrapping/services_scrapping/stock_scrapping_servives.dart';

class GetKatilimList {
  final StockScrappingServices _scrappingServices =
      locator<StockScrappingServices>();
  final StockFirebaseService _stockServiceFirebase =
      locator<StockFirebaseService>();

  Future getKatilimList() async {
    // Bist Katılım Tüm Endeksindeki Hisseleri alır ve DB'ye yazar.
    await _scrappingServices.getKatilimTum();

    for (int i = 0; i < controller.symbolList.length; i++) {
      if (controller.symbolList[i] == "Kod") {
        continue;
      } else {
        StockListModel stockListModel = StockListModel(controller.symbolList[i],
            controller.nameList[i], controller.codeList[i]);
        await _stockServiceFirebase.saveStockList(stockListModel);
      }
    }
    print("Bist Katılım Tüm Listesi Kaydedildi.");
  }
}
