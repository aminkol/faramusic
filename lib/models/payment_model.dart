import 'package:flutter/material.dart';

class PaymentModel {
  int ? id , amount;
  String ? status , trackingCode ,createdAt;

  PaymentModel({
    this.id,
    this.amount,
    this.status,
    this.trackingCode,
    this.createdAt

});

}