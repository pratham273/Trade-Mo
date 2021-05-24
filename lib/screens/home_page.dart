import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/components/stock_tab.dart';
import 'package:stockrates/screens/holdings.dart';
import 'package:stockrates/screens/margin.dart';
import 'package:stockrates/screens/stock_tile.dart';
import 'package:stockrates/screens/welcome_screen.dart';
import 'stockdata.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockrates/components/bottom_bar.dart';

String dropdownValue = "One";

double wallet;

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  var arr = List(2);
  int j;

  List<String> choices = ['Name', 'SignOut'];

  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    //getData();
    getWalletAmount();
    getCurrentUser();
    getStocks();
  }

  String userId;
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

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Holdings()),
      );
    } else if (choice == Constants.SecondItem) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Margin()),
      );
    } else if (choice == Constants.ThirdItem) {
      Navigator.popAndPushNamed(context, WelcomeScreen.id);
    }
  }

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

  void getStocks() async {
    final usrI = await getCurrentUser();
    final stocks = await _firestore.collection('/Stock Prices').getDocuments();
    for (var stock in stocks.documents) {}
  }

  String _uid;
  String _email;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email;

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFF24262c),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF32353e),
        title: Title(
          color: Colors.white,
          child: Text(
            'TradeMo',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          //Padding(padding: EdgeInsets.only(top: 400)),
          // IconButton(
          //   icon: Icon(Icons.account_circle),
          //   onPressed: () {
          //     Container(
          //       child: DropdownButton<String>(
          //         isExpanded: true,
          //         value: _chosenValue,
          //         //elevation: 5,
          //         style: TextStyle(color: Colors.black, fontSize: 20),
          //
          //         items: <String>[
          //           'Available',
          //           'Busy',
          //           'At School',
          //           'At the movies',
          //           'At work',
          //           'Battery About To Die',
          //           'Cant talk, SafeChat only',
          //           'In a meeting',
          //           'At the gym',
          //           'Sleeping',
          //           'Urgent Calls only'
          //         ].map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         hint: Text(
          //           "Please select a status",
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 20,
          //               fontWeight: FontWeight.w600),
          //         ),
          //         onChanged: (String value) {
          //           setState(() {
          //             _chosenValue = value;
          //           });
          //         },
          //       ),
          //     );
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => Holdings()),
          //     // );
          //     //_auth.signOut();
          //     //Navigator.pushNamed(context, WelcomeScreen.id);
          //   },
          // ),
//          PopupMenuButton<String>(
//            itemBuilder: (BuildContext context) {
//              return choices;
//            },
//          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              'NIFTY 50',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
//                SizedBox(
//                  width: 25,
//                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'NAME',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  width: 120.0,
                ),
                Text(
                  'VALUE',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 60.0,
                ),
                Text(
                  'CHANGE',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            FutureBuilder(
                future: getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('/Stocks List')
                          //.where('NoOfTimesAdded', isEqualTo: 1)
//                          .orderBy('StockName', descending: false)
                          .snapshots(),
                      //.where('userId', isEqualTo: userId)

                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final stocks = snapshot.data.documents;
                        List<StockTab> stockTabs = [];
                        for (var stock in stocks) {
                          final stockName = stock['Name'];
                          final stockPrice = stock['Price'];
                          final stockChange = stock['Change'];

                          final stockTab = StockTab(
                            name: stockName,
                            price: stockPrice,
                            change: stockChange,
                          );
                          stockTabs.add(stockTab);
                        }
                        return Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(8.0),
                            children: stockTabs,
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                    height: 0.0,
                    width: 0.0,
                  );
                }),
            SizedBox(
              height: 25.0,
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

class Constants {
  static const String FirstItem = 'Holdings';
  static const String SecondItem = 'Margin';
  static const String ThirdItem = 'Sign Out';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
  ];
}
