import 'package:daily/app/core/domain/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'app/modules/app_module.dart';
import 'app/modules/app_widget.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AccountProvider(),
      child: ModularApp(module: AppModule(), child: AppWidget())));
}
