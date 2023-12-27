
import 'package:flutter/material.dart';
import 'package:mine_app/src/Authentication/pages/authentication_page.dart';
import 'package:mine_app/src/Authentication/pages/register_page.dart';
import 'package:mine_app/src/Games/pages/home_page.dart';

///Classe de gerenciamento de rotas da aplicação
const String login = "/login";
const String register = "/register";
const String home = '/homePage';

class CustomRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    ///Dados passados para a rota (arguments no Navigator)
    // dynamic data;
    // if (settings.arguments != null) {
    //   data = settings.arguments;
    // }

    switch (settings.name) {
      case login:
        return MaterialPageRoute(settings: settings, builder: (_) => const AuthenticationPage());
      case register:
        return MaterialPageRoute(settings: settings, builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(settings: settings, builder: (_) => const HomePage());
    }
    return null;
  }
}
