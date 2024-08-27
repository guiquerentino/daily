import 'package:daily/app/modules/meditation/pages/meditation_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeditationModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => MeditationHomePage());
  }

}