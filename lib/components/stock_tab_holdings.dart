import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/screens/buy_and_sell_module.dart';

class StockTabHolding extends StatelessWidget {
  final name;
  final price;
  final change;
  final quantity;

  StockTabHolding({this.name, this.price, this.change, this.quantity});

  @override
  Widget build(BuildContext context) {
    final changeVal = change.replaceAll(' ()', '');
    final changeValue = change.replaceAll(',', '');
    final priceNoComma = price.replaceAll(',', '');
    final value = (double.parse(priceNoComma) * quantity).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            //'$name'.replaceAll('.NS', ''),
            '$name'.replaceRange(name.length - 3, name.length, ''),
            style: TextStyle(fontSize: 18.0),
            //textAlign: TextAlign.right,
            //textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 50.0,
                child: Text(
                  'Value ',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Container(
                width: 80.0,
                child: Text(
                  '$value',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 80.0,
              ),
              Text(
                'Quantity ',
                style: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
              ),
              SizedBox(
                width: 20.0,
              ),
              Container(
                width: 60.0,
                child: Text(
                  '$quantity',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 50.0,
                child: Text(
                  'LTP ',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Container(
                width: 80.0,
                child: Text(
                  '$price',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),

          Divider(
            color: Colors.blueGrey.shade300,
          ),
          // Container(
          //   width: 80,
          //   // color: double.parse(changeValue) < 0 ? Colors.red : Colors.green,
          //   child: Text(
          //     '$changeVal',
          //     style: TextStyle(
          //       fontSize: 16.0,
          //       color: double.parse(changeValue) < 0
          //           ? Colors.redAccent[400]
          //           : Colors.lightGreenAccent[400],
          //     ),
          //     textAlign: TextAlign.right,
          //   ),
          // ),
        ],
      ),
    );
  }
}
