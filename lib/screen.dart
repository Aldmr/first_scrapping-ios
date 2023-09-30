import 'package:first_scrapping/controller.dart';
import 'package:first_scrapping/locator.dart';
import 'package:first_scrapping/services_combine/get_katilim_list.dart';
import 'package:first_scrapping/services_combine/services_combine.dart';
import 'package:first_scrapping/services_combine/test_combine.dart';
import 'package:first_scrapping/services_scrapping/stock_scrapping_servives.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final ScrapController controller = Get.put(ScrapController());
  final ServicesCombine _stockServiceCombine = locator<ServicesCombine>();
  final StockScrappingServices _scrappingServices =
      locator<StockScrappingServices>();
  final TestService _testService = locator<TestService>();
  final GetKatilimList _getKatilimList = locator<GetKatilimList>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SCRAPPING'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Obx(() => Text(
                    controller.data.value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
              ElevatedButton(
                  onPressed: () {
                    _getKatilimList.getKatilimList();
                  },
                  child: const Text('Katılım Tüm listesini güncelle')),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    _testService.testScrapAndWriteDB();
                  },
                  child: const Text(
                      'Test - sadece "allDocs[0]" hissesi bilgileri güncelle.')),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    _stockServiceCombine.scrapAndWriteDB();
                  },
                  child: const Text(
                      'Katılım Listesindeki Tüm Hisse Bilgilerini Güncelle')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
