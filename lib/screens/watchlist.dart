import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockrates/components/bottom_bar.dart';
import 'package:stockrates/components/stock_tab.dart';

FirebaseUser loggedInUser;

class Watchlist extends StatefulWidget {
  static String id = 'watchlist';
  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
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

  void getStocks() async {
    final usrI = await getCurrentUser();
    final stocks =
        await _firestore.collection('/$usrI/wat/watchmystocks').getDocuments();
    for (var stock in stocks.documents) {
      print(stock['StockName']);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF32353e),
        title: Text(
          'Watchlist',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Stocks Added',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
                future: getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('/$userId/wat/watchmystocks')
                          //.where('NoOfTimesAdded', isEqualTo: 1)
                          //.orderBy('StockName', descending: false)
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
                          final stockName = stock.data['StockName'];
                          final stockPrice = stock.data['StockPrice'];
                          final stockChange = stock.data['StockChange'];
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
