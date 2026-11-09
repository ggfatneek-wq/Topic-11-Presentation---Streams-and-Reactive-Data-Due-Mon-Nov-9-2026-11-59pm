import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SensorScreen(),
    ),
  );
}

class SensorScreen extends StatefulWidget {
  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  late Stream<int> temperatures;

  @override
  void initState() {
    super.initState();

    // Simulate a sensor sending a reading every second.
    temperatures = Stream<int>.periodic(
      Duration(seconds: 1),
      (tick) => 25 + (tick % 11),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Sensor Monitor'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: temperatures,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Unable to read sensor.');
            }

            if (!snapshot.hasData) {
              return Text('Waiting for sensor...');
            }

            int temperature = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Temperature: $temperature C',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  temperature > 30
                      ? 'Warning: temperature too high!'
                      : 'Temperature is normal.',
                  style: TextStyle(
                    color: temperature > 30
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
