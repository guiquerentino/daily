import 'package:daily/app/modules/goals/pages/goals_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GoalsModule extends Module{

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => GoalsPage());
  }

}