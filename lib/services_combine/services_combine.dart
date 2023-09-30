import 'dart:math';

import 'package:first_scrapping/api/collect_api.dart';
import 'package:first_scrapping/locator.dart';
import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:first_scrapping/model/stock_model.dart';
import 'package:first_scrapping/model/stock_price_model.dart';
import 'package:first_scrapping/services_firebase/stock_firebase_service.dart';
import 'package:first_scrapping/services_scrapping/stock_scrapping_servives.dart';
import 'package:first_scrapping/tools/tools.dart';
import 'package:get/get.dart';

class ServicesCombine {
  final StockScrappingServices _scrappingServices =
      locator<StockScrappingServices>();
  final StockFirebaseService _stockServiceFirebase =
      locator<StockFirebaseService>();
  final CollectApi _collectApi = locator<CollectApi>();

  final Tools _tools = locator<Tools>();
  Map<String, StockPriceModel> apiValues = {};

  Future scrapAndWriteDB() async {
    /* 
    // ************************************************************
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
    print("Bist Katılım Tüm Listesi Kaydedildi."); */

    //*****************************************************
    var response = await _collectApi.fetchAlbum();
    // Api' den gelen tüm hisse fiyatlarını apiValues map değerine atar.
    for (int i = 0; i < response.result.length; i++) {
      apiValues[response.result[i].code] = StockPriceModel(
          response.result[i].rate,
          response.result[i].lastprice,
          response.result[i].lastpricestr,
          response.result[i].hacim,
          response.result[i].hacimstr,
          response.result[i].min,
          response.result[i].minstr,
          response.result[i].max,
          response.result[i].maxstr,
          response.result[i].time,
          response.result[i].text,
          response.result[i].code);
    }

    //*****************************************************

    await _stockServiceFirebase.readFromStockListAndEditUrl(
        "Tüm Liste"); // stockList collection'ındaki tüm bilgileri controller.allDocs Map' ine atar.

    for (int i = 0; i < controller.allDocs.length; i++) {
      String stockURLCode = controller.allDocs[i]!
          .code; // DB' de ki code. Örnk: /tr/sirket-bilgileri/ozet/4028e4a2420327a4014209c55161144d
      controller.stockCode.value = stockURLCode.substring(
          26); // Kap sitesindeki şirketin kodu. Örnk: 4028e4a2420327a4014209c55161144d
      controller.kfifUrl.value = stockURLCode.replaceRange(0, 26,
          "https://www.kap.org.tr/tr/kfif/"); // DB' den okunan değeri code' a kadar silip yerine adres url'si ni yazar.
      controller.generallUrl.value =
          "https://www.kap.org.tr/tr/sirket-bilgileri/genel/${controller.stockCode.value}";
      controller.name.value = controller.allDocs[i]!.name;
      controller.symbol.value = controller.allDocs[i]!.stockSymbol;

      Random random = Random();
      int rndomSecond1 = random.nextInt(60);
      int rndomSecond2 = random.nextInt(60);

      await Future.delayed(Duration(seconds: rndomSecond1));
      print("$rndomSecond1 Saniye sonra getAllLotCount Scrap edildi.");
      await _scrappingServices
          .getKfifData(); // Gelen veriler ile birlikte Kfif Datasını Scrap eder.

      if (controller.isKfifNull.isTrue) {
        print(
            "Kap' ta yeterli veri olmadığı için sadece  ${controller.symbol.value} sembol değeri yazıldı...");
        StockModel stockModel0 = StockModel(symbol: controller.symbol.value);
        await _stockServiceFirebase
            .saveStock(stockModel0); //StockModel i db'ye kaydeder.

        print("---${controller.symbol.value}  - Hissesi kaydedildi.---");
        continue; // Scrap edilen değer eğer null gelirse bu Hisse kodunu pas geçer.
      } else {
        await Future.delayed(Duration(seconds: rndomSecond2));
        print("$rndomSecond2 Saniye sonra getKfifData Scrap edildi.");
        await _scrappingServices
            .getGeneralInfo(); //Hissenin toplam kaç LOT sayısı olduğunu KAP' tan çeker.

        // Scrap edilen Borç ve Varlık değerlerini temizler ve double olarak parse eder.
        double realSecurity =
            double.parse(controller.security.value.replaceAll('.', ''));

        double realDebt =
            double.parse(controller.debt.value.replaceAll('.', ''));

        double realAllSecurity =
            double.parse(controller.allSecurity.value.replaceAll(".", ""));

        //----------------------------------------------------
        // kfifRate(Katılım Finans İlkeleri Oranları) değerlerinin bulunması.....
        //-Uygun olmayan varlıkların Tüm Varlıklara(ya da PD'ye) Oranı
        //-Uygun olmayan borçların Tüm Varlıklara(ya da PD'ye) Oranı

        double PD = apiValues[controller.symbol.value]!.lastprice *
            double.parse(controller.allLotCount
                .value); //Anlık hisse değeri ile Lot sayısını çarpar ve Şirketin Piyasa Değeri(PD)ni bulur.
        double kfifDebtRate;
        double kfifSecurityRate;
        int presentationCurrencyValue;
        // "1.000TL" yada "TL" olarak gelen değerlere göre int' değere dönüştürme işlemi.
        if (controller.presentationCurrency.value == 'TL') {
          presentationCurrencyValue = 1;
        } else {
          String editValue1 =
              controller.presentationCurrency.value.replaceAll(".", "");
          String editValue2 = editValue1.replaceAll("TL", "");
          presentationCurrencyValue = int.parse(editValue2);
        }

        // Kfif oranlarının hesaplamasında Yönergelere göre "Piyasa Değeri" ve "Toplam Varlıklar" değerinden hangisi büyükse o değer kullanarak hesaplama yapılır.
        //-Kfif'e Uygun olmayan borçlar oranı yine tüm varlıklara (ya da piyasa değerine) oranlanarak bulunur.
        //-Kfif'e Uygun olmayan Varlık oranı  tüm varlıklara (ya da piyasa değerine) oranlanarak bulunur. 28 781 375 000 - 13 189 162 000
        if (PD > realAllSecurity * presentationCurrencyValue) {
          kfifDebtRate = _tools.calculateKfifRate(
              realDebt * presentationCurrencyValue,
              PD); // presentationCurrencyValue değeri 1000 TL geldiği durumlar için PD ile aynı seviye çekilmesi gerekir. Bu sebeple gelen değer ile çarpımı gerekir.
          kfifSecurityRate = _tools.calculateKfifRate(
              realSecurity * presentationCurrencyValue, PD);
        } else {
          //  Burada  2 değerde aynı seviyede olduğu için presentationCurrencyValue değeri ile çarpıma gerek yoktur.
          kfifDebtRate = _tools.calculateKfifRate(realDebt, realAllSecurity);
          kfifSecurityRate =
              _tools.calculateKfifRate(realSecurity, realAllSecurity);
        }

//----------------------------------------------------
        StockModel stockModel = StockModel(
            //  Toplanan veriler ile StockModel oluşturur.
            symbol: controller.symbol.value,
            name: controller.name.value,
            code: controller.stockCode.value,
            presentationCurrency: presentationCurrencyValue,
            improperPrivilege: controller.improperPrivilege.value,
            inappropriateActivity: controller.inappropriateActivity.value,
            kfifRateRevanue:
                double.parse(controller.revenue.value.replaceAll(',', '.')),
            improperSecurity: controller.security.value,
            allSecurity: controller.allSecurity.value,
            kfifRateSecurity: kfifSecurityRate
                .toPrecision(2), //virgülden sonra 2 digit göstermeyi sağlar.
            improperDebt: controller.debt.value,
            allDebt: controller.allDebt.value,
            allLotCount: double.parse(controller.allLotCount.value),
            kfifRateDebt: kfifDebtRate.toPrecision(2),
            hacim: apiValues[controller.symbol.value]!.hacim,
            hacimstr: apiValues[controller.symbol.value]!.hacimstr,
            lastprice: apiValues[controller.symbol.value]!.lastprice,
            lastpricestr: apiValues[controller.symbol.value]!.lastpricestr,
            max: apiValues[controller.symbol.value]!.max,
            maxstr: apiValues[controller.symbol.value]!.maxstr,
            min: apiValues[controller.symbol.value]!.min,
            minstr: apiValues[controller.symbol.value]!.minstr,
            rate: apiValues[controller.symbol.value]!.rate,
            time: apiValues[controller.symbol.value]!.time);

        await _stockServiceFirebase
            .saveStock(stockModel); //StockModel i db'ye kaydeder.

        print("---${controller.symbol.value}  - Hissesi kaydedildi.---");
      }
    }
    print("**************************");
    print("TÜM HİSSE BİLGİLERİ ALINDI");
    print("**************************");
  }
}
