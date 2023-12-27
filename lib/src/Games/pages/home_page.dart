import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/pages/about_page.dart';
import 'package:mine_app/src/Games/Mine/pages/mine_page.dart';
import 'package:mine_app/src/core/theme/app_colors.dart';
import 'package:mine_app/src/core/theme/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController _pageController;

  void _setCurrentPage(int pageIndex) {
    setState(() => currentPage = pageIndex);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: CustomRouter.generateRoutes,
      theme: Styles.setMaterialTheme3(context),
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _setCurrentPage,
          children: const [
            MinePage(),
            AboutPage(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: colorPrimary,
          color: colorSecondary,
          items: const [
            Icon(Icons.gamepad, size: 30),
            Icon(Icons.home, size: 30),
          ],
          onTap: (index) {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
      ),
    );
  }
}
