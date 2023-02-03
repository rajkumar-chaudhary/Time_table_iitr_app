import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/schedule_widget.dart';
import '../widgets/appDrawer.dart';

class ClassesListScreen extends StatefulWidget {
  // const ClassesListScreen({super.key});

  @override
  State<ClassesListScreen> createState() => _ClassesListScreenState();
}

class _ClassesListScreenState extends State<ClassesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TImeTable'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ClassWidget(
            ScheduleProvider().items[index],
          );
        },
        itemCount: ScheduleProvider().items.length,
      ),
    );
  }
}
