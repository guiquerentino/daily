import 'package:daily/app/modules/auth/auth_module.dart';
import 'package:daily/app/modules/emotions/emotions_module.dart';
import 'package:daily/app/core/pages/splash_page.dart';
import 'package:daily/app/modules/onboarding/onboarding_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => SplashPage());
    r.module('/auth', module: AuthModule());
    r.module('/emotions', module: EmotionsModule());
    r.module('/onboarding', module: OnboardingModule());
    }
}
