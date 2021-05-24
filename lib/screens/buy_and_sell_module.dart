import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:stockrates/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockrates/screens/Show_Stats.dart';
import 'package:stockrates/screens/home_page.dart';
import 'package:stockrates/screens/welcome_screen.dart';
import 'package:stockrates/components/alert_dialog_box.dart';

FirebaseUser loggedInUser;
double wallet;

int stockQuantity;

class BuyModule extends StatefulWidget {
  final String stockName;
  final String stockPrice;
  final String stockChange;

  BuyModule({this.stockName, this.stockPrice, this.stockChange});

  @override
  _BuyModuleState createState() => _BuyModuleState();
}

class _BuyModuleState extends State<BuyModule> {
  String wall;
  @override
  void initState() {
    super.initState();
    getWalletAmount();
    getStocksWatchList(widget.stockName);
  }

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

  var format = NumberFormat.currency(locale: 'HI');

  int timesAdded = 0;

  void getStocksWatchList(String name) async {
    final usrI =
        await getCurrentUser(); //userId is assigned so that each user portfolio and watchlist can be managed
    final stocks =
        await _firestore.collection('/$usrI/wat/watchmystocks').getDocuments();
    for (var stock in stocks.documents) {
      if (name == stock['StockName']) {
        timesAdded = 1;
        print(stock['StockName']);
      }
    }
  }

  void getStocksPortfolio() async {
    final usrI =
        await getCurrentUser(); //userId is assigned so that each user portfolio and watchlist can be managed
    final stocks =
        await _firestore.collection('/$usrI/port/portfolio').getDocuments();
    for (var stock in stocks.documents) {
      print(stock['StockName']);
    }
  }

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
        }
      }
    });
  }

  // createAlertDialog(BuildContext context, String text) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(text),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.pushNamed(context, HomePage.id);
  //               },
  //               child: Text(
  //                 'Okay',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF363840),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Quantity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 140.0,
                child: TextField(
                  onChanged: (value) {
                    stockQuantity = int.parse(value);
                  },
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
//          SizedBox(
//            height: 100.0,
//          ),
          Flexible(
            child: FlatButton(
              onPressed: () async {
                final usrI = await getCurrentUser();
                getStocksWatchList(widget.stockName);
                final walletAmount = await _firestore
                    .collection('/$usrI/wallet/wat')
                    .getDocuments();

                String stockP = widget.stockPrice.replaceAll(",", "");
                print(stockP);

                if (stockQuantity == 0) {
                  createAlertDialog(
                      context, 'Quantity cannot be 0', HomePage.id);
                } else {
                  double priceOfStock = double.parse(stockP);
                  double totalAmount = priceOfStock * stockQuantity;
                  print(priceOfStock);
                  print(totalAmount);

                  if (totalAmount <= wallet) {
                    setState(() {
                      wallet = wallet - totalAmount;
                      wall = wallet.toStringAsFixed(2).replaceAll(",", "");
                      wallet = double.parse(wall);
                    });

                    print(wallet);

                    final CollectionReference postsRef =
                        Firestore.instance.collection('/$usrI/wallet/wat');

                    String postID = usrI;
                    Map<String, dynamic> data = {"Wallet Money": wallet};
                    postsRef.document(postID).setData(data);

                    final stocks = await _firestore
                        .collection('/$usrI/port/portfolio')
                        .getDocuments();
                    for (var stock in stocks.documents) {
                      if (widget.stockName == stock['StockName']) {
                        print(stock['StockName']);
                        print(stock['StockQuantity']);
                        stockQuantity += stock['StockQuantity'];
                      }
                    }

                    final CollectionReference postsRefPortfolio =
                        Firestore.instance.collection('/$usrI/port/portfolio');

                    String postIDPortfolio = widget.stockName;
                    Map<String, dynamic> dataPortfolio = {
                      'StockName': widget.stockName,
                      'StockPrice': widget.stockPrice,
                      'StockChange': widget.stockChange,
                      'StockQuantity': stockQuantity,
                    };
                    postsRefPortfolio
                        .document(postIDPortfolio)
                        .setData(dataPortfolio);
                    //createAlertDialog(context, widget.stockName + '  bought');
                    createAlertDialog(
                        context, widget.stockName + ' bought', HomePage.id);
                  } else {
                    //createAlertDialog(context, 'Funds Insufficient');
                    createAlertDialog(
                        context, 'Funds Insufficient', HomePage.id);
                  }
                }
              },
              color: Colors.lightGreen,
              child: Text(
                'Buy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Text(
            'OR',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),

          FlatButton(
            onPressed: () async {
              final usrI = await getCurrentUser();

              String stockP = widget.stockPrice.replaceAll(",", "");
              print(stockP);

              double priceOfStock = double.parse(stockP);

              double totalAmount = priceOfStock * stockQuantity;

              int quantitySell = 0;
              final stocks = await _firestore
                  .collection('/$usrI/port/portfolio')
                  .getDocuments();
              for (var stock in stocks.documents) {
                if (widget.stockName == stock['StockName']) {
                  if (stockQuantity <= stock['StockQuantity']) {
                    print(stock['StockQuantity']);
                    quantitySell = stock['StockQuantity'] - stockQuantity;
                    stockQuantity = quantitySell;
                    final CollectionReference postsRefPortfolio =
                        Firestore.instance.collection('/$usrI/port/portfolio');

                    String postIDPortfolio = widget.stockName;
                    Map<String, dynamic> dataPortfolio = {
                      'StockName': widget.stockName,
                      'StockPrice': widget.stockPrice,
                      'StockChange': widget.stockChange,
                      'StockQuantity': stockQuantity,
                    };
                    postsRefPortfolio
                        .document(postIDPortfolio)
                        .setData(dataPortfolio);
                    setState(() {
                      wallet = wallet + totalAmount;
                      wall = wallet.toStringAsFixed(2).replaceAll(",", "");
                      wallet = double.parse(wall);
                    });

                    final CollectionReference postsRef =
                        Firestore.instance.collection('/$usrI/wallet/wat');

                    String postID = usrI;
                    Map<String, dynamic> data = {"Wallet Money": wallet};
                    postsRef.document(postID).setData(data);
                    //createAlertDialog(context, widget.stockName + '  sold');
                    createAlertDialog(
                        context, widget.stockName + ' sold', HomePage.id);
                  } else {
                    //createAlertDialog(context, 'Not enough holding');
                    createAlertDialog(
                        context, 'Not enough holding', HomePage.id);
                    print(
                        "Stock not in portfolio or Quantity of stock is less");
                  }
                }
              }
            },
            color: Colors.redAccent,
            child: Text(
              'Sell',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            onPressed: () async {
//              String stockPrice =
//                  (stockName[widget.stockIndex].value).replaceAll(',', '');
              final usrI = await getCurrentUser();

              final CollectionReference postsRefWatchlist =
                  Firestore.instance.collection('/$usrI/wat/watchmystocks');

              String postIDWatchlist = widget.stockName;
              Map<String, dynamic> dataWatchlist = {
                'StockName': widget.stockName,
                'StockPrice': widget.stockPrice,
                'StockChange': widget.stockChange,
              };
              postsRefWatchlist
                  .document(postIDWatchlist)
                  .setData(dataWatchlist);

              //createAlertDialog(context, "Added to watchlist");
              createAlertDialog(context, "Added to WatchList", HomePage.id);
            },
            color: Color(0xFF4099DC),
            child: Text(
              'Add to Watchlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),

          SizedBox(
            height: 40.0,
          ),
//          GestureDetector(
//              onTap: () async {
//                final usrI = await getCurrentUser();
//                final walletAmount = await _firestore
//                    .collection('/$usrI/wallet/wat')
//                    .getDocuments();
//                setState(() {
//                  for (var walletAmt in walletAmount.documents) {
//                    wallet = walletAmt['Wallet Amount'];
//                    print(walletAmt['Wallet Amount']);
//                  }
//                });
//              },
//              child: Text(
//                'Wallet Amount : $wallet',
//                style: TextStyle(
//                  color: Colors.black,
//                  fontSize: 25.0,
//                ),
//              )),
          Container(
            child: Text(
              'Wallet Amount : ${format.format(wallet)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, ShowStats.id);
                //Navigator.push(context, ShowStats(stockName: widget.stockName));
                print(widget.stockName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowStats(
                            stockName: widget.stockName,
                          )),
                );
              },
              child: Text(
                'Show Stats',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
