import 'package:daily/app/modules/may/pages/chat_whit_may_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MayModule extends Module{

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => ChatWithMayPage());
  }

}