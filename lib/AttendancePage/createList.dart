import 'package:flutter/material.dart';
// import 'package:mec_attendance/redirection.dart';yy
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Widgets/widgets.dart';

// This function uses created data and makes a list of widgets, each corresponding to a subject.
// This data is shown as the attendane information
returnListOfAttendanceInfo(
    studentattendance,
    subjectAndLastUpdated,
    length,
    noOfClassesList,
    gradientWhenUnder1,
    gradientWhenUnder2,
    attendaneGradient1,
    attendaneGradient2,
    fontName,
    context) {
  // print(noOfClassesList);
  var widgetList = <Widget>[];

  for (int i = 0; i < length - 1; i++) {
    var attendance;
    var elective = 0;
    if (double.tryParse(studentattendance[i + 1]) != null)
      attendance = double.parse(studentattendance[i + 1]);
    else {
      attendance = 0.0;
      elective = 1;
    }
    var totalNoOfClasses = noOfClassesList[i];
    var attented = (attendance * totalNoOfClasses) / 100;
    attented = attented.round() + 0.0;
    var canCut = 0.0;
    var canCutText = '';

    if (attendance == 75.0) {
      canCutText = 'Perfectly Balanced As All Things Should Be !';
    } else if (attendance > 75.0) {
      canCut = (4 * attented - 3 * totalNoOfClasses) / 3;
      canCutText = 'Can Cut ' + canCut.floor().toString() + ' Classes';
    } else if ((attendance == 0.0 && totalNoOfClasses == 0) ||
        (elective == 1)) {
      canCutText = '-------';
    } else {
      canCut = 3 * totalNoOfClasses - 4 * attented;
      // print(canCut);
      canCutText = 'Have to Attend ' + canCut.round().toString() + ' Classes';
    }
    var attn = '';
    if (attendance == 0.0)
      attn = '- -';
    else
      attn = attendance.toString() + '%';
    // Getting Subject Name
    var subname = subjectAndLastUpdated[i][0].toString();
    var subarray = subname.split(' ');
    // If first word of subject name contains numbers, its propably the course code so removes it.
    if (subarray[0].contains('0') ||
        subarray[0].contains('1') ||
        subarray[0].contains('2') ||
        subarray[0].contains('3') ||
        subarray[0].contains('4')) subarray.removeAt(0);
    subname = subarray.join(' ');

    // Tries to convert student name to Lowercase.
    try {
      subname = subname
          .trim()
          .toLowerCase()
          .split(' ')
          .map((s) => s[0].toUpperCase() + s.substring(1))
          .join(' ');
    } catch (_) {}
    // print(subname);
    //Convert date to no of days
    var lastupdated = subjectAndLastUpdated[i][1];

    // Takes last updated value, splits to day, month & year.
    // Takes device date & finds difference in number of days.
    int luday, lumonth, luyear, difference = -1;
    try {
      luday = int.parse(lastupdated.substring(0, 2));
      lumonth = int.parse(lastupdated.substring(3, 5));
      luyear = int.parse(lastupdated.substring(6, 10));
      var now = new DateTime.now();
      var dateupdated = new DateTime.utc(luyear, lumonth, luday);
      difference = now.difference(dateupdated).inDays;
    } catch (_) {}
    // Sets Last Updated
    var lastupdatedstring;
    if (difference == 0)
      lastupdatedstring = 'Today';
    else if (difference == 1)
      lastupdatedstring = 'Yesterday';
    else if (difference == -999)
      lastupdatedstring = subjectAndLastUpdated[i][1];
    else
      lastupdatedstring = difference.toString() + ' Days Ago';

    // Returns the small thing to display data in popup
    Widget _popupElement(t1, t2) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.1,
                0.9
              ],
              colors: [
                (attendance >= 75 ||
                        (attendance == 0 && totalNoOfClasses == 0) ||
                        elective == 1)
                    ? attendaneGradient1
                    : gradientWhenUnder1,
                (attendance >= 75 ||
                        (attendance == 0 && totalNoOfClasses == 0) ||
                        elective == 1)
                    ? attendaneGradient2
                    : gradientWhenUnder2,
              ]),
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              t1,
              style: TextStyle(
                  fontFamily: fontName, color: Colors.white, fontSize: 12),
            ),
            Text(
              t2,
              style: TextStyle(
                  fontFamily: fontName, color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      );
    } // End of the popup element

// Percentage Indicator
    Widget percentIndicator() {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 7, 5),
        child: CircularPercentIndicator(
          radius: 78.0,
          lineWidth: 1.3,
          percent: attendance / 100,
          center: Text(
            attn.toString(),
            style: TextStyle(fontFamily: fontName, fontSize: 16),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          reverse: true,
          animation: true,
          animationDuration: 2000,
          backgroundColor: Color(0x11000000),
          maskFilter: MaskFilter.blur(BlurStyle.solid, 0),
          linearGradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              (attendance >= 75 ||
                      (attendance == 0 && totalNoOfClasses == 0) ||
                      elective == 1)
                  ? attendaneGradient1
                  : gradientWhenUnder1,
              (attendance >= 75 ||
                      (attendance == 0 && totalNoOfClasses == 0) ||
                      elective == 1)
                  ? attendaneGradient2
                  : gradientWhenUnder2,
            ],
          ),
        ),
      );
    } // End of Percentage Indicator

// Each list Item starts here............
// Change here to change how the details of subjects change.

    widgetList.add(
      InkWell(
        onTap: () {
          // When a card is presses, The following pop up comes up.
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: Text(
                  subname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: fontName,
                      shadows: [
                        BoxShadow(
                          color: Color(0x88000000),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        )
                      ]),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: percentIndicator(),
                      ),
                      FadeIn(
                        0.2,
                        _popupElement('Classes Attended',
                            ': ' + attented.toStringAsFixed(0)),
                      ),
                      FadeIn(
                        0.3,
                        _popupElement('Total No. of Classes',
                            ': ' + totalNoOfClasses.toString()),
                      ),
                      FadeIn(
                        0.4,
                        _popupElement('Last Updated', lastupdatedstring),
                      ),
                      FadeIn(
                        0.5,
                        _popupElement(
                            'Updated Date', subjectAndLastUpdated[i][1]),
                      ),
                      SizedBox(height: 10),
                      FadeIn(
                        .7,
                        Center(
                            child: Text(
                          canCutText,
                          style: TextStyle(
                              fontFamily: fontName,
                              color: Colors.black54,
                              fontSize: 12,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x88000000),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                )
                              ]),
                        )),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FadeIn(
                    .7,
                    FlatButton(
                      child: Text(
                        "Close",
                        style: TextStyle(
                            fontFamily: fontName,
                            color: attendaneGradient2,
                            fontSize: 12,
                            shadows: [
                              BoxShadow(
                                color: Color(0x885555ff),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: FadeIn(
          i / 2.0,
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                // gradient: LinearGradient(
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomLeft,
                //     stops: [0.1, 0.9],
                //     colors: [Colors.indigo, Colors.cyan]),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              subname,
                              style: TextStyle(
                                  fontFamily: fontName,
                                  color: Color(0xFF555555),
                                  fontSize: 16.0),
                            ),
                          ),

                          // The line under subject title.
                          SizedBox(height: 10),

                          //Have to Attend / Cut
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                // margin: EdgeInsets.only(left: 10.0),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  // color: Color(0xFF2680C1),
                                  borderRadius: BorderRadius.circular(50.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [
                                        0.1,
                                        0.9
                                      ],
                                      colors: [
                                        (attendance >= 75 ||
                                                (attendance == 0 &&
                                                    totalNoOfClasses == 0) ||
                                                elective == 1)
                                            ? attendaneGradient1 //Blue Left
                                            : gradientWhenUnder1, // Red
                                        (attendance >= 75 ||
                                                (attendance == 0 &&
                                                    totalNoOfClasses == 0) ||
                                                elective == 1)
                                            ? attendaneGradient2 // Blue Right
                                            : gradientWhenUnder2,
                                      ]),
                                ),
                                child: Text(
                                  canCutText,
                                  style: TextStyle(
                                      fontFamily: fontName,
                                      color: Colors.white,
                                      fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 4,
                          ),

                          //Last Updated
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Text(
                              'Last Updated : ' + lastupdatedstring,
                              // subjectAndLastUpdated[i][1],
                              style: TextStyle(
                                fontFamily: fontName,
                                color: Color(0xFF777777),
                                fontSize: 12,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                  ),
                  percentIndicator(),
                ],
              )),
        ),
      ),
    );
  }
  return widgetList;
}
