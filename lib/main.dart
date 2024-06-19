import 'package:daily/app/core/domain/providers/account_provider.dart';
import 'package:daily/app/core/domain/providers/bottom_navigation_bar_provider.dart';
import 'package:daily/app/core/domain/providers/calendar_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'app/modules/app_module.dart';
import 'app/modules/app_widget.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => CalendarDateProvider())
      ],
      child: ModularApp(module: AppModule(), child: AppWidget())));
}
