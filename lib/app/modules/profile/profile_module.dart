import 'package:daily/app/modules/profile/pages/profile_page.dart';
import 'package:daily/app/modules/profile/pages/profile_settings_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module{

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const ProfilePage());
    r.child('/settings', child: (context) => ProfileSettingsPage());
  }

}