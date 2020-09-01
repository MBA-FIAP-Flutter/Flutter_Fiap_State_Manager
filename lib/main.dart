import 'package:flutter/material.dart';
import 'package:flutter_fiap_state_manager/listBills.dart';
import 'package:flutter_fiap_state_manager/provider/paymentProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //mobx
      //home: ListAccountsPage(),
      //provider
      home: ChangeNotifierProvider(
        create: (context) => PaymentController(),
        child: ListBills(),
      ),
    );
  }
}

