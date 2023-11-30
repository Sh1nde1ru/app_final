import 'dart:math';

import 'package:app_final/Widgets/my_slider.dart';
import 'package:flutter/material.dart';

class LightControlPage extends StatefulWidget {
  const LightControlPage({super.key});

  @override
  State<LightControlPage> createState() => _LightControlPageState();
}

class _LightControlPageState extends State<LightControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Light Control"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(angle: 270 * pi / 180, child: const MySlider()),
          ],
        ),
      ),
    );
  }
}
