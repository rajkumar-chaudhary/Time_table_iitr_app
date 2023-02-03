import 'package:flutter/material.dart';
import '../models/Schedule.dart';
import 'package:provider/provider.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _items = [
    Schedule(
      id: 'a1',
      proffName: 'PK',
      roomNo: 'APJAKB-207',
      startTime: DateTime.now(),
      date: DateTime.now(),
      subName: 'Quality Managment',
    ),
    Schedule(
      id: 'a2',
      proffName: 'IDS',
      roomNo: 'APJAKB-207',
      startTime: DateTime.now(),
      date: DateTime.now(),
      subName: 'Operations Managment',
    ),
    Schedule(
      id: 'a3',
      proffName: 'AD',
      roomNo: 'APJAKB-207',
      startTime: DateTime.now(),
      date: DateTime.now(),
      subName: 'Concurrent Engineering',
    ),
  ];

  List<Schedule> get items {
    return [..._items];
  }

  String userName = 'Unknown user';

  void setUserName(String usrname) {
    userName = usrname;
    notifyListeners();
  }

  String get getUserName {
    // notifyListeners();
    return userName;
  }
}
