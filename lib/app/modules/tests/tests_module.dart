import 'package:daily/app/modules/tests/pages/details_test_page.dart';
import 'package:daily/app/modules/tests/pages/test_results_page.dart';
import 'package:daily/app/modules/tests/pages/tests_page.dart';
import 'package:daily/app/modules/tests/pages/tests_start_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TestsModule extends Module{
  
  @override
  void binds(Injector i) {
    super.binds(i);
  }
  
  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => TestsPage());
    r.child('/details', child: (context) => DetailsTestPage(test: r.args.data));
    r.child('/results', child: (context) => TestResultsPage(results: r.args.data, testType: r.args.queryParams['testType'] ?? ''));
    r.child('/start', child: (context) => TestsStartPage(test: r.args.data));
  }
  
}