import 'package:first_scrapping/controller.dart';
import 'package:first_scrapping/locator.dart';
import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:first_scrapping/model/stock_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

final ScrapController controller = Get.put(ScrapController());

late StockModel stockModel;
late StockListModel stockListModel;

class StockScrappingServices {
  /* var cgifUrl = Uri.parse(
      'https://www.kap.org.tr/tr/kfif/4028e4a240f2ef4c014101b726fa011d'); */
  var endeksUrl = Uri.parse("https://www.kap.org.tr/tr/Endeksler");
  Map katilimMapList = {};
  int i = 0;
  Future getKfifData() async {
    var stockKfifParsedUri =
        Uri.parse(controller.kfifUrl.value); // Oluşan url parse edilir.
    var res = await http.get(stockKfifParsedUri); // scrapping başlar.

    final body = res.body;

    final document = parser.parse(body);
    controller.isKfifNull.value =
        false; // Scrap edilen data'nın null olmadığını isKfifNull değerine false olarak atar.
    var responseMainTable = document
            .getElementsByClassName('w-section.middle-section')[
                0] // [0] indisi scriptin içindeki ilk  <div class "w-section.middle-section" başlığını seçer.
            .children[0] // <div class "w-section.middle-section"  0. elemanı
            .children[1] //<div class "w-container.middle-container"  1. Elemanı
            .children[
        2]; //<div class="w-section.middle-section" ng-controller ="kFifController"> 2. Elemanı (İndex 0' dan başlar.)
    var a = responseMainTable.children[2].text.removeAllWhitespace.trim();

    if (a != "") {
      controller.presentationCurrency.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[0]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.improperPrivilege.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[3]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.inappropriateActivity.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[4]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.revenue.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[5]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.security.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[6]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.allSecurity.value = responseMainTable
          .children[10] // <div id ="tableArea"> 10. elemanı
          .children[2]
          .children[0]
          .children[2]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.debt.value = responseMainTable
          .children[2] // <div id ="tableArea"> 2. elemanı
          .children[0]
          .children[0]
          .children[7]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();
      controller.allDebt.value = responseMainTable
          .children[12] // <div id ="tableArea"> 12. elemanı
          .children[0]
          .children[0]
          .children[8]
          .children[1]
          .children[0]
          .text
          .removeAllWhitespace
          .trim();

      // Scrap edilen data'nın null olduğunu isKfifNull değerine true olarak atar.
    } else {
      controller.isKfifNull.value = true;
    }
  }

  Future getGeneralInfo() async {
    //controller.genelUrl.value;
    var parseUri = Uri.parse(controller.generallUrl.value);

    var res = await http.get(parseUri); // scrapping başlar.
    final body = res.body;
    final document = parser.parse(body);

    var responseMainTable = document
        .getElementsByClassName('w-section.middle-section')[0]
        .children[0]
        .children[2];

    controller.allLotCount.value = responseMainTable
        .children[1].children[12].children[1].children[0].text
        .toString()
        .removeAllWhitespace
        .trim();

    controller.includeIndex.value = responseMainTable
        .children[1].children[6].children[3].children[0].text
        .toString()
        .trim();

    controller.companyActivity.value = responseMainTable
        .children[1].children[4].children[1].text
        .toString()
        .trim();

    controller.companySector.value =
        responseMainTable.children[1].children[7].text.toString().trim();
  }

  Future getKatilimTum() async {
    //Katılım Endeks Hisselerini alır ve DB'ye yazar. //
    try {
      var res = await http.get(endeksUrl);
      final body = res.body;
      final document = parser.parse(body);
      var response = document
          .getElementsByClassName('w-col.w-col-9.w-clearfix.sub-col.asd')[0]
          .children[176];
      for (var i = 0; i < (response.nodes.length - 1) / 2; i++) {
        controller.symbolList.add(
            response.children[i].children[1].text.removeAllWhitespace.trim());
        controller.nameList.add(response.children[i].children[2].text.trim());
        if (i == 0) {
          controller.codeList.add("title");
        } else {
          controller.codeList.add(response.children[i].children[1]
              .getElementsByTagName('a')[0]
              .attributes['href']);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
/////////////////////////////////////////////////////


//****** Örnek : ACSEL  */
/* document
        .getElementsByClassName('w-col.w-col-9.w-clearfix.sub-col.asd')[0]
        .children[176]
        .children[1]
        .children[1]
        .text
        .toString(); */

//****** Örnek : /tr/sirket-bilgileri/ozet/4028e4a2420327a4014209c55161144d    */
/* document
        .getElementsByClassName('w-col.w-col-9.w-clearfix.sub-col.asd')[0]
        .children[176]
        .children[1]
        .children[1]
        .getElementsByTagName('a')[0]
        .attributes['href']; */

// Ürün İsmi => element.children[3].children[0].children[0].text
// Ürün Resmi => element.children[1].children[0].children[0].children[0].children[0].children[0].children[0].attributes['data-srcset']
//*** ORNEK: /media/resize/8835031100_LO1_20200429_172646.png/265Wx265H/image.webp 1x, /media/resize/8835031100_LO1_20200429_172646.png/530Wx530H/image.webp 2x  */

/* element
          .getElementsByClassName('prd-body')[0]
          .getElementsByClassName('prd-name')[0]
          .getElementsByClassName('js-prd-name')[0]
          .text */
