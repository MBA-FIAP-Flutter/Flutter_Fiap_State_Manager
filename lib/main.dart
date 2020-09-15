import 'package:flutter/material.dart';
import 'package:flutter_fiap_state_manager/listBills.dart';
import 'package:flutter_fiap_state_manager/mobx/paymentController.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  GetIt.I.registerSingleton<PaymentController>(PaymentController());
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
      home: ListBills(),
      //provider
      /*home: ChangeNotifierProvider(
        create: (context) => PaymentController(),
        child: ListBills(),
      ),*/
    );
  }
}

