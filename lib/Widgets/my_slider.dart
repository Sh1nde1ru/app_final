import 'package:flutter/material.dart';
import 'package:interactive_slider/interactive_slider.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int lastValue = 0;
  var sliderController = InteractiveSliderController.new;
  @override
  Widget build(BuildContext context) {
    return const InteractiveSlider(
      unfocusedHeight: 50,
      focusedHeight: 70,
      unfocusedOpacity: 1,
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 17, 10, 116),
        Color.fromARGB(255, 255, 121, 4),
        Color.fromARGB(255, 255, 247, 0),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      startIcon: RotatedBox(quarterTurns: 1, child: Icon(Icons.lightbulb)),
      endIcon: RotatedBox(
          quarterTurns: 1, child: Icon(Icons.lightbulb_circle_rounded)),
      min: 0,
      max: 100,
    );
  }
}
