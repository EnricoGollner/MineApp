import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/core/theme/app_colors.dart';
import 'package:mine_app/src/games_app.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: colorPrimary,
      systemNavigationBarColor: colorPrimary,
      systemNavigationBarDividerColor: colorPrimary,
    ),
  );

  setUpGetIt();

  runApp(const GamesApp());
}
