import 'package:flutter/material.dart';
import 'package:stockrates/screens/home_page.dart';
import 'package:stockrates/screens/portfolio.dart';
import 'package:stockrates/screens/watchlist.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      color: Color(0xFF32353e),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Text(
              'WATCHLIST',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Watchlist.id);
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomePage.id);
            },
            child: Text(
              'HOME',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Portfolio.id);
            },
            child: Text(
              'PORTFOLIO',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
