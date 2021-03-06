import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Loading Page Gradient
var gradient1 = Color(0xff2c9fc0);
var gradient2 = Color(0xff3464BB);

class Redirect extends StatefulWidget {
  Redirect();

  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  getDetailsFromStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var classname = pref.getString('class');
    var rollno2 = pref.getString('rollno');
    if (classname == null || rollno2 == null)
      Navigator.pushReplacementNamed(context, '/choose');
    else
      Navigator.pushReplacementNamed(context, '/attendance');
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getDetailsFromStorage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.9],
              colors: [gradient1, gradient2]),
        ),
        child: Center(
          child: Image(
            image: AssetImage('assets/mec.png'),
            width: 225,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
