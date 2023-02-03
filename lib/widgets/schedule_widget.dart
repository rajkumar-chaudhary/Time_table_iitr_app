import 'package:flutter/material.dart';
import '../models/Schedule.dart';
import 'package:intl/intl.dart';

class ClassWidget extends StatelessWidget {
  // const ClassWidget({super.key});
  final Schedule classObj;
  ClassWidget(this.classObj);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      height: 90,
      child: Card(
        elevation: 6,
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2,
                color: Colors.grey,
              )),
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(
                    '${classObj.startTime.day}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child:
                        Text('${DateFormat.MMM().format(classObj.startTime)}'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      classObj.subName,
                      style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'Proff-> ${classObj.proffName}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Room no.-> ${classObj.roomNo} ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
