import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'buy_and_sell_module.dart';

class StockTile extends StatelessWidget {
  final String name;
  final String value;
  final String changeValue;
  final bool colorDecider;
  final int index;

  StockTile(
      {this.name, this.value, this.changeValue, this.colorDecider, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => BuyModule(
                stockName: name,
              ),
            );
          },
          child: Container(
            width: 100.0,
            color: Colors.green,
            child: Text(
              '$name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 100.0,
            child: Text(
              '$value',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Container(
          width: 100.0,
          child: Text(
            '$changeValue',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
