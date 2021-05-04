import 'package:flutter/services.dart';

const EventChannel CHANNEL = EventChannel("com.destinyed.event_channel");

class EventChannelData {
  //x Axis
  final double x;

  //y Axis
  final double y;

  //Z
  final double z;

  double getZ() => this.z;

  EventChannelData(this.x, this.y, this.z);

  @override
  String toString() => "[EventChannelData (x: $x, y: $y, z: $z)]";
}

EventChannelData _listOfValues(List<double> data) {
  return EventChannelData(data[0], data[1], data[2]);
}

Stream<EventChannelData> _magneticEvent;

Stream<EventChannelData> get eventData {
  if (_magneticEvent == null) {
    _magneticEvent = CHANNEL
        .receiveBroadcastStream()
        .map((event) => _listOfValues(event.cast<double>()));
  }
  return _magneticEvent;
}
