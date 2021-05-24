import 'package:flutter/material.dart';
import 'package:stockrates/screens/Show_Stats.dart';
import 'package:stockrates/screens/login_screen.dart';
import 'package:stockrates/screens/portfolio.dart';
import 'package:stockrates/screens/registration_screen.dart';
import 'package:stockrates/screens/watchlist.dart';
import 'package:stockrates/screens/web_view_stock.dart';
import 'package:stockrates/screens/welcome_screen.dart';
import 'screens/home_page.dart';
import 'screens/Show_Stats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Watchlist.id: (context) => Watchlist(),
        Portfolio.id: (context) => Portfolio(),
        ShowStats.id: (context) => ShowStats(),
        //WebViewStock.id: (context) => WebViewStock(),
      },
    );
  }
}
