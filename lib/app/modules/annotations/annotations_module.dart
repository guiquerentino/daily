import 'package:daily/app/modules/annotations/pages/annotations_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnnotationsModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => AnnotationsPage());
  }

}