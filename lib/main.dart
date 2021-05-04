import 'dart:async';

import 'package:event_channel/listener.dart';
import 'package:flutter/material.dart';

import 'dart:math' as maths;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventChannel(),
    );
  }
}

class EventChannel extends StatefulWidget {
  @override
  _EventChannelState createState() => _EventChannelState();
}

class _EventChannelState extends State<EventChannel> {
  StreamSubscription _streamSubscription;

  List<double> sensorValues;

  @override
  void initState() {
    sensorValues = <double>[];

    _streamSubscription = eventData.listen((event) {
      setState(() {
        sensorValues = <double>[event.x, event.y, event.z];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double angle = maths.atan2(sensorValues[1], sensorValues[0]);
    return Scaffold(
      appBar: AppBar(title: Text("Event app")),
      body: Center(
        child: Transform.rotate(
            angle: maths.pi / 2 - angle,
            child: Image.asset("assets/compass.png")),
      ),
    );
  }
}
