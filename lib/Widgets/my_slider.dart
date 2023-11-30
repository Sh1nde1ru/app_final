import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 300,
        startAngle: 180,
        angleRange: 180,
        customWidths: CustomSliderWidths(
          trackWidth: 50,
          shadowWidth: 0,
          progressBarWidth: 50,
        ),
        customColors: CustomSliderColors(
            gradientStartAngle: 180,
            gradientEndAngle: 360,
            progressBarColors: [
              Colors.blue.shade900,
              Colors.deepOrange,
              Colors.yellow
            ]),
      ),
      min: 0,
      max: 100,
      initialValue: 0,
      onChange: (double value) {
        print(value);
      },
    );
  }
}
