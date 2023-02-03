import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  static const routeName = '/admin-page';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  DateTime _pickedDate = DateTime(2020);
  TimeOfDay _pickedTIme = TimeOfDay(hour: 0, minute: 3);
  final _formKey = GlobalKey<FormState>();
  String _subName = '';
  String _proffName = '';
  String _roomNo = '';
  String _date = '';
  String _time = '';

  Future _selectDate() async {
    Future<DateTime?> picked = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((value) {
      if (value != null) {
        setState(() {
          _pickedDate = value;
        });
        debugPrint('ok date printed');
      }
    });
  }

  Future _selectTime() async {
    Future<TimeOfDay?> picked = showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 0, minute: 0))
        .then((value) {
      if (value != null) {
        setState(() {
          _pickedTIme = value;
        });
      }
    });
  }

  void _submitForm() async {
    final _isValid = _formKey.currentState!.validate();
    final _isTimeSubmited = _pickedTIme != TimeOfDay(hour: 0, minute: 3);
    final _isDateSubmited = _pickedDate != DateTime(2020);

    // if (!_isValid || _isTimeSubmited || _isDateSubmited) {
    //   return;
    // }
    _formKey.currentState!.save();

    await FirebaseFirestore.instance
        .collection('schedules')
        .doc(DateTime.now().toString())
        .set({
      'subName': _subName,
      'proffName': _proffName,
      'date': _pickedDate.toIso8601String(),
      'time': _pickedTIme.toString(),
      'roomNo': _roomNo,
      // 'userName': userName,
    });
    print('ok ok ok pk ojsondos ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin only')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                  color: Colors.grey,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Subject Name'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide Value';
                        }
                      },
                      onSaved: ((newValue) {
                        _subName = newValue!;
                      }),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Proff Name'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide Value';
                        }
                      },
                      onSaved: ((newValue) {
                        _proffName = newValue!;
                      }),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Room No.'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide Value';
                        }
                      },
                      onSaved: ((newValue) {
                        _roomNo = newValue!;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2,
                color: Colors.grey,
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      'Select Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _selectDate,
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  _pickedDate == DateTime(2020)
                      ? const Text('No date Choosen!')
                      : Text('Date: ${DateFormat.yMd().format(_pickedDate)}'),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                  color: Colors.grey,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.access_time_sharp),
                      label: Text(
                        'Slelect Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _selectTime,
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    _pickedTIme == TimeOfDay(hour: 0, minute: 3)
                        ? const Text('No Time Choosen!')
                        : Text('Time: ${_pickedTIme.format(context)}'),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
