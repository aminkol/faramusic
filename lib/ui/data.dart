import 'dart:ui';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class Data {
  static int versionCode = 8;
  static String versionName = "1.1.1";
  static String lastVersionLink = '';
  static String updateIsRequired = '';
  static int sleepMode = 0;
  static String sleepModeReason = '';
  static String uploadFilePath = '';

  static int? currentChatId = null;

  static double deviceWidth = 0;
  static double deviceHeight = 0;


  static String fullname = '';
  static String phone = '';
  static String address = '';
  static String siteLink = 'https://doctorup.ir/';
  static String contactLink = 'https://doctorup.ir/contact';
  static String aboutLink = 'https://doctorup.ir/about';
  static String privacyLink = 'https://doctorup.ir/privacy';
  static String uploadsUrl = 'https://doctorup.ir/uploads/';

  static String token = '';
  static int balance = 0;


  static Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    return token;
  }

  static serverError(BuildContext context) {
    makeSnackBar(context, 'خطایی در ارتباط با سرور رخ داده است');
  }

  static makeSnackBarSuccess(BuildContext context, String message){
      makeSnackBar(context, message, backgroundColor: AppTheme.primaryColor);
  }
  static makeSnackBarError(BuildContext context, String message){
    makeSnackBar(context, message, backgroundColor: AppTheme.red);
  }

  static makeSnackBar(BuildContext context, String message,{backgroundColor = AppTheme.black}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(fontFamily: 'IRANSansMobile'),
        ),
        duration: Duration(seconds: 3)));
  }

  static String beautyPrice(int price, {bool justNumber = false, bool roundNumber = true}) {

    var prefix = '';
    if(price < 0){
      var sss = price.toString();
      prefix = '-';
      sss = sss.substring(1, sss.length);
      price = int.parse(sss);
    }

    if(roundNumber){
      price = roundInt(price);
    }

    var formatter = intl.NumberFormat('###,###,000');
    var priceString = formatter.format(price);
    //priceString = priceString.replaceAll(',', '.');
    if (priceString == '000') {
      priceString = '0';
    }



    if(justNumber){
      return prefix + priceString;
    }
    return  priceString + prefix + ' ریال';
  }

  static redirectToScreen(context, screen, {callBack()?}) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, animation2) => Directionality(
            textDirection: TextDirection.rtl,
            child: screen,
          ),
        )).then((value) {callBack!();});
  }

  static redirectToScreenPush(context, screen, {callBack()?}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, animation2) => Directionality(
            textDirection: TextDirection.rtl,
            child: screen,
          ),
        )).then((value) {callBack!();});
  }

  static beautyNumber(String number) {
    if (number.startsWith('98')) {
      number = number.replaceFirst('98', '0');
    }
    number = number.substring(0, 4) +
        ' ' +
        number.substring(4, 7) +
        ' ' +
        number.substring(7, 11);
    return number;
  }

  static roundInt(int number){


    if(number < 1000){
      return 0;
    }

    var priceString = number.toString();
    if(priceString.length >= 3){

      int length = priceString.length;
      var last3 = priceString[length-3];
      last3 += priceString[length-2];
      last3 += priceString[length-1];

      priceString = priceString.substring(0, length-3);

      int last3Int = int.parse(last3);

      if(last3Int < 500){

        priceString = priceString + '000';
      }
      else if(last3Int > 500){
        priceString = (int.parse(priceString)+ 1).toString() + '000';
      }
      else if(last3Int == 500){
        priceString = priceString + '500';
      }
      number = int.parse(priceString);
      return number;
    }

    return 0;
  }

}
