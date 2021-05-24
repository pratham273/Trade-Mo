// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:stockrates/screens/buy_and_sell_module.dart';
//
// final _firestore = Firestore.instance;
// final _auth = FirebaseAuth.instance;
// String userId;
//
// Future getCurrentUser() async {
//   try {
//     final user = await _auth.currentUser();
//     if (user != null) {
//       loggedInUser = user;
//       userId = loggedInUser.uid;
//       return userId;
//     }
//   } catch (e) {
//     print(e);
//   }
// }
//
// String stockName;
//
// Future getDataFromStocksList() async {
//   try {
//     final user = await _auth.currentUser();
//     // final stocksList =
//     //     await _firestore.collection('/Stocks List').getDocuments();
//     final stocks =
//         await _firestore.collection('/$user/port/portfolio').getDocuments();
//     for (var stock in stocks.documents) {
//       if (stock['StockQuantity'] > 0) {
//         final sto = await _firestore
//             .collection('Stocks List')
//             .document(stock['StockName']);
//         stock['StockPrice'] = sto['Price'];
//       }
//     }
//     final CollectionReference postsRefPortfolio =
//         Firestore.instance.collection('/$user/port/portfolio');
//
//     String postIDPortfolio = stockName;
//     Map<String, dynamic> dataPortfolio = {
//       'StockName': widget.stockName,
//       'StockPrice': widget.stockPrice,
//       'StockChange': widget.stockChange,
//       'StockQuantity': stockQuantity,
//     };
//     postsRefPortfolio.document(postIDPortfolio).setData(dataPortfolio);
//   } catch (e) {}
// }
