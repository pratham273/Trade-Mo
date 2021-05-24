import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/components/bottom_bar.dart';
import 'package:stockrates/components/stock_tab.dart';
import 'package:stockrates/components/stock_tab_holdings.dart';

import 'buy_and_sell_module.dart';

class Holdings extends StatefulWidget {
  @override
  _HoldingsState createState() => _HoldingsState();
}

class _HoldingsState extends State<Holdings> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String userId;
  List<dynamic> stockNamesList = [];
  List<dynamic> stockQuantityList = [];
  Map<dynamic, dynamic> stockData;

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

  Future getStockDetails() async {
    try {
      final usrI = await getCurrentUser();
      final stocks =
          await _firestore.collection('/$usrI/port/portfolio').getDocuments();
      for (var stock in stocks.documents) {
        if (stock['StockQuantity'] > 0) {
          //print(stock['StockName']);
          stockNamesList.add(stock['StockName']);
          stockQuantityList.add(stock['StockQuantity']);
        }
      }
      // final CollectionReference postsRefPortfolio =
      // Firestore.instance.collection('/$usrI/port/portfolio');
      //
      //
      //
      // for( var stock in stockNamesList)
      // {
      //   final stocksList = await _firestore.collection('/Stocks List/{$stock}');
      // String postIDPortfolio = stock;
      // Map<String, dynamic> dataPortfolio = {
      //   'StockName': stock,
      //   'StockPrice': stocksList.document(),
      //   'StockChange': widget.stockChange,
      //   'StockQuantity': stockQuantity,
      // };
      // postsRefPortfolio
      //     .document(postIDPortfolio)
      //     .setData(dataPortfolio);
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getStockDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      appBar: AppBar(
        backgroundColor: Color(0xFF32353e),
        title: Text(
          'Holdings',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // GestureDetector(
            //   onTap: () {
            //     for (int i = 0; i < stockNamesList.length; i++) {
            //       print(stockNamesList[i]);
            //       print(stockQuantityList[i]);
            //     }
            //   },
            //   child: Text('Tap Me'),
            // ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
                future: getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('/$userId/port/portfolio')
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
                        //final stocksListForPrice = snapshot.data.documents;
                        List<StockTabHolding> stockTabsHolding = [];

                        for (var stock in stocks) {
                          //if (stock['StockQuantity'] > 0) {
                          //if(stockNamesList.con){}

                          final stockName = stock.data['StockName'];
                          final stockPrice = stock.data['StockPrice'];
                          final stockChange = stock.data['StockChange'];
                          final quantity = stock.data['StockQuantity'];
                          final stockTabHolding = StockTabHolding(
                            name: stockName,
                            price: stockPrice,
                            change: stockChange,
                            quantity: quantity,
                          );
                          if (quantity > 0) {
                            stockTabsHolding.add(stockTabHolding);
                          }

                          //}
                        }
                        return Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(8.0),
                            children: stockTabsHolding,
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
