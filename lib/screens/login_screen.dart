import 'package:flutter/material.dart';
import 'package:stockrates/components/alert_dialog_box.dart';
import 'package:stockrates/components/rounded_button.dart';
import 'package:stockrates/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockrates/screens/registration_screen.dart';
import 'package:stockrates/screens/welcome_screen.dart';
import 'home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stockrates/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//              Flexible(
////                child: Hero(
////                  tag: 'logo',
////                  child: Container(
////                    height: 200.0,
////                    child: Image.asset('images/logo.png'),
////                  ),
////                ),
//              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),

              RoundedButton(
                buttonText: 'Log In',
                buttonColor: Color(0xFF32353e),
                onPressed: () async {
                  {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, HomePage.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      createAlertDialog(
                          context, "   Wrong password", WelcomeScreen.id);
                      print(e);
                    }
                  }
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ),
              // Text(
              //   'OR',
              //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(
              //   height: 24.0,
              // ),
              //SignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
