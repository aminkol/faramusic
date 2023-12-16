import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:faramusic/ui/theme/app_theme.dart';

class Alert {

  static ToastificationItem show(
      BuildContext context, String title,
      {Color backgroundColor = AppTheme.primaryColor,
        IconData icon = Icons.notifications_rounded, type = ToastificationType.success}) {

    return Toastification().show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      title: title,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      dragToClose: true,
    );
  }
}

