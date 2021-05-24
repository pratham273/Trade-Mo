import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:stockrates/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
//    controller =
//        AnimationController(duration: Duration(seconds: 3), vsync: this);
//    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
//        .animate(controller);
//    controller.forward();
//    controller.addListener(() {
//      setState(() {});
//    });
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
//                Hero(
//                  tag: 'logo',
//                  child: Container(
//                    child: Image.asset('images/logo.png'),
//                    height: 60.0,
//                  ),
//                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              buttonText: 'Log In',
              buttonColor: Color(0xFF32353e),
              onPressed: () {
                {
                  Navigator.pushNamed(context, LoginScreen.id);
                }
              },
            ),
            RoundedButton(
              buttonText: 'Register',
              buttonColor: Color(0xFF32353e),
              onPressed: () {
                {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
