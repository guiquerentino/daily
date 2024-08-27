import 'package:daily/app/modules/health/pages/health_area/health_area_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HealthModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
      r.child(Modular.initialRoute, child: (context) => HealthAreaPage());
  }

}