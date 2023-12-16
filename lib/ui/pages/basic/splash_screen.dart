import 'dart:async';
import 'package:faramusic/ui/pages/account/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:toastification/toastification.dart';
import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../theme/app_theme.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool pageIsLoaded = false;

  @override
  void initState() {
    super.initState();
    _checkData();

    //Timer(Duration(seconds: 3), _checkData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body:  !pageIsLoaded ? LoadingWidget() :
      Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/splash-bg.png'),
          alignment: Alignment.bottomLeft,),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Center(child: Text('logo',style: TextStyle(fontSize: 60),)),
            Spacer(),
          ],
        ),


      ),


    );
  }

  _checkData() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    },));
  }

}

