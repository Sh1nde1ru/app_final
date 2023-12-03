import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:app_final/utils/shared_preferences/prefs.dart';

class LightControlPage extends StatefulWidget {
  const LightControlPage({super.key});
  @override
  State<LightControlPage> createState() => _LightControlPageState();
}

class _LightControlPageState extends State<LightControlPage> {
  late double initValue = 0;
  @override
  void initState() {
    Prefs.ensureInitialized().then((_) {
      setState(() {
        initValue = Prefs.startValue!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Light Control"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SleekCircularSlider(
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
                    ],
                    trackColor: Colors.grey.shade500),
              ),
              min: 0,
              max: 100,
              initialValue: initValue,
              onChangeEnd: (double value) {
                setState(() {
                  storeStartValue(value);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void storeStartValue(double value) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("LightValue");

    setState(() {
      Prefs.startValue = value;
      ref.set(value.round());
    });
  }
}
