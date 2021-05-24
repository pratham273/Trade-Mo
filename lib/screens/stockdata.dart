// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// final _firestore = Firestore.instance;
// FirebaseUser loggedInUser;
//
// const url =
//     'https://www.parsehub.com/api/v2/runs/taWEH_r-60dX/data?api_key=tmuQTqsQVPL6&format=json';
//
// class StockData {
//   Future getStockData(int i) async {
//     var response = await http.get(url);
//
//     var array = List(3);
//
//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       array[0] = jsonResponse['stocks'][i]['open'];
//       array[1] = jsonResponse['stocks'][i]['change'];
//     }
//     return array;
//   }
// }
