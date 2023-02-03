import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Schedule {
  final String id;
  final String subName;
  final DateTime startTime;
  final DateTime date;
  // final DateTime endTime;
  final String roomNo;
  final String proffName;

  Schedule({
    //  required this.endTime,
    required this.id,
    required this.proffName,
    required this.roomNo,
    required this.startTime,
    required this.date,
    required this.subName,
  });
}
