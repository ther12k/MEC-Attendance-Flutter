import 'package:flutter/material.dart';

returnsList(studentattendance, subjectAndLastUpdated, length, context) {
  var widgetList = <Widget>[];
  for (int i = 0; i < length - 1; i++) {
    widgetList.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.blue,),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Text(
                subjectAndLastUpdated[i][0].toString().substring(5),
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white,),
              child: Text(
                studentattendance[i + 1] + ' %',
                style: TextStyle(color: Color(0xFF555555), fontSize: 20.0),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ]),
      ),
    );
  }
  return widgetList;
}
