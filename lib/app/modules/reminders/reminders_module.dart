import 'package:daily/app/modules/reminders/pages/reminders_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RemindersModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => RemindersPage());
  }

}