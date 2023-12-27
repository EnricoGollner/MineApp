import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/pages/home_page.dart';
import 'package:mine_app/src/core/routes.dart';
import 'package:mine_app/src/core/theme/styles.dart';
import 'package:sizer/sizer.dart';

class GamesApp extends StatelessWidget {
  const GamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.generateRoutes,
          navigatorKey: CustomRouter.navigatorKey,
          theme: Styles.setMaterialTheme3(context),
          home: const HomePage(),
        );
      },
    );
  }
}
