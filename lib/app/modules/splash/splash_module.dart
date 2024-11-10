import 'package:daily/app/modules/splash/pages/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  
  @override
  List<Module> get imports => [
  ];
  
  @override
  void binds(Injector i) {
    super.binds(i);
  }
  
  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
  }
  
}