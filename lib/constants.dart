import 'package:flutter/material.dart';
import 'screens/stockname.dart';

List<StockName> stockName = [
  StockName(equityName: 'RELIANCE'),
  StockName(equityName: 'HINDUNILVR'),
  StockName(equityName: 'SUNPHARMA'),
  StockName(equityName: 'BRITANNIA'),
  StockName(equityName: 'BHARTIARTL'),
  StockName(equityName: 'TCS'),
  StockName(equityName: 'COALINDIA'),
  StockName(equityName: 'POWERGRID'),
  StockName(equityName: 'NESTLEIND'),
  StockName(equityName: 'TATAMOTORS'),
  StockName(equityName: 'BAJAJ-AUTO'),
  StockName(equityName: 'DRREDDY'),
  StockName(equityName: 'WIPRO'),
  StockName(equityName: 'CIPLA'),
  StockName(equityName: 'EICHERMOT'),
  StockName(equityName: 'INFY'),
  StockName(equityName: 'BPCL'),
  StockName(equityName: 'HEROMOTOCO'),
  StockName(equityName: 'IOC'),
  StockName(equityName: 'HINDALCO'),
  StockName(equityName: 'ITC'),
  StockName(equityName: 'MARUTI'),
  StockName(equityName: 'ASIANPAINT'),
  StockName(equityName: 'BAJFINANCE'),
  StockName(equityName: 'ZEEL'),
  StockName(equityName: 'GRASIM'),
  StockName(equityName: 'M&M'),
  StockName(equityName: 'NTPC'),
  StockName(equityName: 'BAJAJFINSV'),
  StockName(equityName: 'LT'),
  StockName(equityName: 'HCLTECH'),
  StockName(equityName: 'ULTRACEMCO'),
  StockName(equityName: 'KOTAKBANK'),
  StockName(equityName: 'UPL'),
  StockName(equityName: 'VEDL'),
  StockName(equityName: 'HDFCBANK'),
  StockName(equityName: 'TATASTEEL'),
  StockName(equityName: 'SHREECEM'),
  StockName(equityName: 'SBIN'),
  StockName(equityName: 'TECHM'),
  StockName(equityName: 'ONGC'),
  StockName(equityName: 'JSWSTEEL'),
  StockName(equityName: 'ADANIPORTS'),
  StockName(equityName: 'TITAN'),
  StockName(equityName: 'INFRATEL'),
  StockName(equityName: 'HDFC'),
  StockName(equityName: 'ICICIBANK'),
  StockName(equityName: 'INDUSINDBK'),
  StockName(equityName: 'GAIL'),
  StockName(equityName: 'AXISBANK'),
];

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.black, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
