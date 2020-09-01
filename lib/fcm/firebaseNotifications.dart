import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiap_state_manager/model/payment.dart';
import 'package:flutter_fiap_state_manager/provider/paymentProvider.dart';
import 'package:provider/provider.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  PaymentController controller;

  FirebaseNotifications(BuildContext context){
    //fazendo uso do changenotifier somente no modo edição
    controller = Provider.of<PaymentController>(context, listen: false);
  }

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("token: $token");
    });

    _firebaseMessaging.configure(
      //responde quando o app está em foreground
      onMessage: (Map<String, dynamic> message) async {
        debugPrint("chegou mensagem ");
        debugPrint("chegou mensagem $message");
        Payment payment = Payment.fromJson(message);
        debugPrint("chegou mensagem $payment");
        controller.add(payment);
      },
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}