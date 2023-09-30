import 'package:first_scrapping/api/collect_api.dart';
import 'package:first_scrapping/services_combine/get_katilim_list.dart';
import 'package:first_scrapping/services_combine/services_combine.dart';
import 'package:first_scrapping/services_combine/test_combine.dart';
import 'package:first_scrapping/services_firebase/stock_firebase_service.dart';
import 'package:first_scrapping/services_scrapping/stock_scrapping_servives.dart';
import 'package:first_scrapping/tools/tools.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();
void setupLocator() {
  locator.registerLazySingleton(() => StockFirebaseService());
  locator.registerLazySingleton(() => StockScrappingServices());
  locator.registerLazySingleton(() => ServicesCombine());
  locator.registerLazySingleton(() => Tools());
  locator.registerLazySingleton(() => CollectApi());
  locator.registerLazySingleton(() => TestService());
  locator.registerLazySingleton(() => GetKatilimList());
}
