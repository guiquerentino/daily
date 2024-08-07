import 'package:daily/app/modules/onboarding/pages/age_onboarding/age_onboarding_page.dart';
import 'package:daily/app/modules/onboarding/pages/gender_onboarding/gender_onboarding_page.dart';
import 'package:daily/app/modules/onboarding/pages/meditation_experience_onboarding/meditation_experience_onboarding_page.dart';
import 'package:daily/app/modules/onboarding/pages/objectives_onboarding/objectives_onboarding_page.dart';
import 'package:daily/app/modules/onboarding/pages/name_onboarding/name_onboarding_page.dart';
import 'package:daily/app/modules/onboarding/pages/sucessfull_onboarding/sucecssfull_onboarding_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => NameOnboardingPage());
    r.child('/gender', child: (context) => GenderOnboardingPage());
    r.child('/age', child: (context) => AgeOnboardingPage());
    r.child('/objectives', child: (context) => ObjectivesOnboardingPage());
    r.child('/meditation-experience', child: (context) => MeditationExperienceOnboardingPage());
    r.child('/sucessfull', child: (context) => SucessfullOnboardingPage());
  }

}