import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseUser loggedInUser;
double wallet;
String marginValue;

var format = NumberFormat.currency(locale: 'HI');

class Margin extends StatefulWidget {
  @override
  _MarginState createState() => _MarginState();
}

class _MarginState extends State<Margin> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
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

  // void getWalletAmount() async {
  //   final usrI = await getCurrentUser();
  //   final walletAmount =
  //       await _firestore.collection('/$usrI/wallet/wat').getDocuments();
  //   for (var wallet in walletAmount.documents) {
  //     print(wallet['Wallet Money']);
  //   }
  // }

  void getWalletAmount() async {
    final usrI = await getCurrentUser();
    final walletAmount =
        await _firestore.collection('/$usrI/wallet/wat').getDocuments();

    setState(() {
      for (var walletAmt in walletAmount.documents) {
        if (walletAmt['Wallet Money'] > 0) {
          // To check if numeric
          String w = walletAmt['Wallet Money'].toString();
          wallet = double.parse(w);
          print(walletAmt['Wallet Money']);
          print(format.format(wallet));
          marginValue = format.format(wallet);
        }
      }
    });
  }

  @override
  void initState() {
    getWalletAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      appBar: AppBar(
        backgroundColor: Color(0xFF32353e),
        title: Text("Margin",
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "Adjusted Margin Value: ",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              getWalletAmount();
            },
            child: Text(
              marginValue,
              style: TextStyle(fontSize: 25.0),
            ),
          )
        ],
      )),
    );
  }
}
