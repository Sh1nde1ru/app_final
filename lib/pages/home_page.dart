import 'package:app_final/Widgets/my_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyContainer(
              height: 250,
              width: 250,
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
                      style: const TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            MyContainer(
              height: 250,
              width: 250,
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
                      style: const TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
