import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockrates/constants.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockrates/screens/login_screen.dart';
import 'package:stockrates/screens/welcome_screen.dart';
import 'home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stockrates/components/alert_dialog_box.dart';

FirebaseUser loggedInUser;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  bool showSpinner = false;

  String userId;
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        userId = loggedInUser.uid;
        return userId;
      }
    } catch (e) {
      print(e);
    }
  }

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
//                child: Hero(
//                  tag: 'logo',
//                  child: Container(
//                    height: 200.0,
//                    child: Image.asset('images/logo.png'),
//                  ),
//                ),
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter  your email',
                ),
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
                buttonText: 'Register',
                buttonColor: Color(0xFF32353e),
                onPressed: () async {
                  {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, HomePage.id);
                        print(email);
                        final usrI = await getCurrentUser();

                        final CollectionReference postsRef =
                            Firestore.instance.collection('/$usrI/wallet/wat');

                        String postID = usrI;
                        Map<String, dynamic> data = {"Wallet Money": 200000};
                        postsRef.document(postID).setData(data);

//                        _firestore
//                            .collection('/$usrI/wallet/wat')
//                            .add({'Wallet Money': 20000});
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      createAlertDialog(context, "Account already registered",
                          WelcomeScreen.id);
                      //Navigator.pushNamed(context, RegistrationScreen.id);
                      //print(e);
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
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
