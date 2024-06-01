import 'package:daily/app/modules/emotions/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EmotionsModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(HomePage.ROUTE_NAME, child: (context) => HomePage(user: r.args.data));
  }
}
