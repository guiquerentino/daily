import 'package:daily/app/modules/annotations/annotations_module.dart';
import 'package:daily/app/modules/articles/articles_modules.dart';
import 'package:daily/app/modules/auth/auth_module.dart';
import 'package:daily/app/modules/chat/chat_module.dart';
import 'package:daily/app/modules/emotions/emotions_module.dart';
import 'package:daily/app/modules/splash/pages/splash_page.dart';
import 'package:daily/app/modules/goals/goals_module.dart';
import 'package:daily/app/modules/health/health_module.dart';
import 'package:daily/app/modules/may/may_module.dart';
import 'package:daily/app/modules/meditation/meditation_module.dart';
import 'package:daily/app/modules/onboarding/onboarding_module.dart';
import 'package:daily/app/modules/profile/profile_module.dart';
import 'package:daily/app/modules/reminders/reminders_module.dart';
import 'package:daily/app/modules/splash/splash_module.dart';
import 'package:daily/app/modules/tests/tests_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: SplashModule());
    r.module('/auth', module: AuthModule());
    r.module('/emotions', module: EmotionsModule());
    r.module('/onboarding', module: OnboardingModule());
    r.module('/health', module: HealthModule());
    r.module('/reminders', module: RemindersModule());
    r.module('/annotations', module: AnnotationsModule());
    r.module('/articles', module: ArticlesModule());
    r.module('/meditation', module: MeditationModule());
    r.module('/profile', module: ProfileModule());
    r.module('/may', module: MayModule());
    r.module('/goals', module: GoalsModule());
    r.module('/tests', module: TestsModule());
    r.module('/chat', module: ChatModule());
    }
}
