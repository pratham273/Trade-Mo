import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/screens/buy_and_sell_module.dart';

class StockTab extends StatelessWidget {
  final name;
  final price;
  final change;

  StockTab({this.name, this.price, this.change});

  @override
  Widget build(BuildContext context) {
    final changeVal = change.replaceAll(' ()', '');
    final changeValue = change.replaceAll(',', '');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => BuyModule(
                        stockName: name,
                        stockPrice: price,
                        stockChange: change,
                      ));
            },
            child: Container(
              width: 130.0,
              child: Text(
                name,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // SizedBox(
          //   width: 10.0,
          // ),
          Container(
            width: 110,
            child: Text(
              '$price',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.right,
              //textAlign: TextAlign.left,
            ),
          ),
          Divider(
            color: Colors.blueGrey.shade300,
          ),
          Divider(
            color: Colors.blueGrey.shade300,
          ),

          Container(
            width: 80,
            // color: double.parse(changeValue) < 0 ? Colors.red : Colors.green,
            child: Text(
              '$changeVal',
              style: TextStyle(
                fontSize: 16.0,
                color: double.parse(changeValue) < 0
                    ? Colors.redAccent[400]
                    : Colors.lightGreenAccent[400],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
