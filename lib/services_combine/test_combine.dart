import 'package:first_scrapping/api/collect_api.dart';
import 'package:first_scrapping/locator.dart';
import 'package:first_scrapping/model/stock_price_model.dart';
import 'package:first_scrapping/services_firebase/stock_firebase_service.dart';
import 'package:first_scrapping/services_scrapping/stock_scrapping_servives.dart';
import 'package:first_scrapping/tools/tools.dart';

class TestService {
  final StockScrappingServices _scrappingServices =
      locator<StockScrappingServices>();
  final StockFirebaseService _stockServiceFirebase =
      locator<StockFirebaseService>();
  // final CollectApi _collectApi = locator<CollectApi>();

  // final Tools _tools = locator<Tools>();
  Map<String, StockPriceModel> apiValues = {};

  Future testScrapAndWriteDB() async {
    await _stockServiceFirebase.readFromStockListAndEditUrl("AFYON");

    String stockURLCode = controller.stockListModel
        .code; // DB' de ki code. Örnk: /tr/sirket-bilgileri/ozet/4028e4a2420327a4014209c55161144d
    controller.stockCode.value = stockURLCode.substring(
        26); // Kap sitesindeki şirketin kodu. Örnk: 4028e4a2420327a4014209c55161144d
    controller.kfifUrl.value = stockURLCode.replaceRange(0, 26,
        "https://www.kap.org.tr/tr/kfif/"); // DB' den okunan değeri code' a kadar silip yerine adres url'si ni yazar.
    controller.generallUrl.value =
        "https://www.kap.org.tr/tr/sirket-bilgileri/genel/${controller.stockCode.value}";
    controller.name.value = controller.stockListModel.name;
    controller.symbol.value = controller.stockListModel.stockSymbol;

    await _scrappingServices.getGeneralInfo();

    print('Faaliyet Alanı: ${controller.companyActivity.value}');
    print('Sektör:${controller.companySector.value}');
    print('Dahil Olduğu Endeksler: ${controller.includeIndex.value}');
    List a = [];
    a = controller.includeIndex.value.split('/');
  }
}
