import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockrates/screens/web_view_stock.dart';

class ShowStats extends StatefulWidget {
  static String id = 'show_stats';
  final stockName;

  ShowStats({@required this.stockName});

  @override
  _ShowStatsState createState() => _ShowStatsState();
}

class _ShowStatsState extends State<ShowStats> {
  @override
  void initState() {
    super.initState();
    getStockData();
  }

  final _firestore = Firestore.instance;

  String previousClose;
  String price;
  String openPrice;
  String change;
  String marketCap;
  String peRatio;
  String eps;
  String beta;
  String yearRange;

  void getStockData() async {
    final stocks = await _firestore.collection('/Stocks List').getDocuments();
    for (var stock in stocks.documents) {
      if (widget.stockName == stock['Name']) {
        setState(() {
          price = stock['Price'];
          yearRange = stock['52 Week Range'];
          change = stock['Change'];
          openPrice = stock['Open Price'];
          marketCap = stock['Market Cap'];
          peRatio = stock['PE Ratio'];
          eps = stock['EPS'];
          beta = stock['Beta'];
        });
        previousClose = stock['Previous Close'];

        print(yearRange);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      getStockData();
    }

    return Scaffold(
      backgroundColor: Color(0xFF24262c),
      appBar: AppBar(
        backgroundColor: Color(0xFF32353e),
        title: Text(
          widget.stockName,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                String nameOfStock =
                    widget.stockName.toString().replaceAll('.NS', '');
                //print(nameOfStock + "Done");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewStock(
                            stockName: nameOfStock,
                          )),
                );
              },
              child: Image.asset('assets/stockchart.png'),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
                child: Text(
              price,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            )),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previous Close',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        previousClose,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Open',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        openPrice,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '52-Week Range',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        yearRange,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Market Cap',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        marketCap,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beta',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        beta,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PE Ratio',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        peRatio,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EPS',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        eps,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blueGrey.shade300,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
