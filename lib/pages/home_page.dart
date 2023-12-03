import 'package:app_final/Widgets/my_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic temperature;
  dynamic outputTemp;
  dynamic humidity;
  dynamic outputHum;
  double initValue = 0;

  @override
  void initState() {
    loadData();
    DatabaseReference tempRef =
        FirebaseDatabase.instance.ref("DATA/Temperature");
    Stream<DatabaseEvent> streamTemp = tempRef.onValue;
    streamTemp.listen((event) {
      temperature = event.snapshot.value;
      setState(() {
        outputTemp = temperature;
      });
    });

    DatabaseReference humRef = FirebaseDatabase.instance.ref("DATA/Humidity");
    Stream<DatabaseEvent> streamHum = humRef.onValue;
    streamHum.listen((event) {
      humidity = event.snapshot.value;
      setState(() {
        outputHum = humidity;
      });
    });
    super.initState();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      initValue = prefs.getDouble('initValue') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer(
                  height: 150,
                  width: 150,
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 255, 121, 4),
                    Color.fromARGB(241, 255, 247, 0),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Teplota:",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "$temperature°C",
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                MyContainer(
                  height: 150,
                  width: 150,
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 4, 50, 255),
                    Color.fromARGB(240, 0, 213, 255),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vlhkost:",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "$outputHum%",
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: MyContainer(
                    height: 150,
                    width: 150,
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 26, 239, 26),
                      Color.fromARGB(255, 142, 233, 31),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Zapnutí: ",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 40,
                                  childDelegate:
                                      ListWheelChildLoopingListDelegate(
                                    children: List<Widget>.generate(
                                      24,
                                      (index) => Text(
                                        '$index',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onSelectedItemChanged: (value) => playSound(),
                                ),
                              ),
                              const SizedBox(
                                height: 45,
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 40,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate:
                                      ListWheelChildLoopingListDelegate(
                                    children: List<Widget>.generate(
                                      60,
                                      (index) => Text(
                                        '$index',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // onSelectedItemChanged: (value) => playSound(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: MyContainer(
                    height: 150,
                    width: 150,
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 239, 33, 26),
                      Color.fromARGB(255, 239, 86, 26),
                    ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Vypnutí: ",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 40,
                                  childDelegate:
                                      ListWheelChildLoopingListDelegate(
                                    children: List<Widget>.generate(
                                      24,
                                      (index) => Text(
                                        '$index',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  //onSelectedItemChanged: (value) => playSound(),
                                ),
                              ),
                              const SizedBox(
                                height: 45,
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 40,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate:
                                      ListWheelChildLoopingListDelegate(
                                    children: List<Widget>.generate(
                                      60,
                                      (index) => Text(
                                        '$index',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // onSelectedItemChanged: (value) => playSound(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SleekCircularSlider(
              initialValue: initValue,
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
              onChange: (double value) {
                setState(() {
                  storeStartValue(value);
                });
              },
            )
          ],
        ),
      ]),
    );
  }

  void storeStartValue(double value) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("LightValue");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ref.set(value.round());
      prefs.setDouble('initValue', value);
    });
  }

  void playSound() async {
    AudioPlayer().play(AssetSource('sounds/click_sound.wav'));
  }
}
