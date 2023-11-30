import 'package:app_final/firebase_options.dart';
import 'package:app_final/pages/home_page.dart';
import 'package:app_final/pages/light_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Widget> pages = [
    const HomePage(),
    const LightControlPage(),
  ];

  int _selectedIndex = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: _pageController,
          children: pages,
        ),
        bottomNavigationBar: MoltenBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: (clickedIndex) {
            setState(() {
              _selectedIndex = clickedIndex;
              _pageController.animateToPage(_selectedIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            });
          },
          tabs: [
            MoltenTab(icon: const Icon(Icons.home)),
            MoltenTab(icon: const Icon(Icons.lightbulb)),
          ],
        ),
      ),
    );
  }
}
