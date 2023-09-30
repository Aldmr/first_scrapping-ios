import 'package:first_scrapping/model/stock_list_model.dart';
import 'package:get/get.dart';

class ScrapController extends GetxController {
  final data = ''.obs;
  final kfifUrl = ''.obs;
  final generallUrl = ''.obs;
  Map<int, StockListModel> allDocs = {};
  late StockListModel stockListModel;
  final isKfifNull = false.obs;

/* --StockModel Değişkenleri-- */
  final symbol = ''.obs;
  final name = ''.obs;
  final stockCode = ''.obs;
  final presentationCurrency = ''.obs;
  final inappropriateActivity = ''.obs;
  final improperPrivilege = ''.obs;
  final revenue = ''.obs;
  final security = ''.obs;
  final allSecurity = ''.obs;
  final debt = ''.obs;
  final allDebt = ''.obs;
  final allLotCount = ''.obs;
  final includeIndex = ''.obs;
  final companyActivity = ''.obs;
  final companySector = ''.obs;

  late double stockPrice;

/* --StocListModel Değişkenleri-- */
  final symbolList = [].obs;
  final nameList = [].obs;
  final codeList = [].obs;
}
