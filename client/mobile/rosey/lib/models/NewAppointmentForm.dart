import 'package:flutter/material.dart';

enum BuildingType {
  apartment,
  house,
}

class NewAppointmentForm {
  String? address;
  DateTime? date;
  TimeOfDay? start;
  TimeOfDay? end;
  BuildingType? type;
  int? quantityOfRooms;
  bool? doTheIroning;
  String? additionalInfo;
}