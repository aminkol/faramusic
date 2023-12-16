
import 'package:flutter/material.dart';

class AppTheme{

    static const Color backgroundColor = Color(0xffE6E9F0);
    static const Color white = Color(0xffffffff);
    static const Color light = Color(0xffA8ABBA);
    static const Color lightGray = Color(0xff7D7E80);
    static const Color darkGray = Color(0xff504E4E);
    static const Color gray = Color(0xff504E4E);
    static const Color darkBlue = Color(0xff23273D);
    static const Color red = Color(0xffF71F1F);
    static const Color green = Color(0xff30B47B);
    static const Color black = Color(0xff000000);

    static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8));
    static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(20));
    static const BorderRadius borderRadiusLarg = BorderRadius.all(Radius.circular(50));


    static const MaterialColor primaryColor = MaterialColor(
        0xFF020D2F,
        <int, Color>{
            50: Color(0xFFE3F2FD),
            100: Color(0xFFBBDEFB),
            200: Color(0xFF90CAF9),
            300: Color(0xFF64B5F6),
            400: Color(0xFF42A5F5),
            500: Color(0xFF42A5F5),
            600: Color(0xFF1E88E5),
            700: Color(0xFF1976D2),
            800: Color(0xFF1565C0),
            900: Color(0xFF0D47A1),
        },
    );


    static final buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: AppTheme.borderRadiusLarg,
            //side: BorderSide(color: AppTheme.primaryColor),
        )
    );

    static final buttonStyleOutline = ElevatedButton.styleFrom(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1, // thickness
                color: AppTheme.primaryColor, // color
            ),
            // border radius
            borderRadius: AppTheme.borderRadiusSmall,
        ),
        elevation: 0,
    );

    static InputDecoration getInputDecoration({required hintText, borderRadius = borderRadiusLarg}){
        return InputDecoration(
            counter: Offstage(),
            hintText: hintText,
            hintStyle: TextStyle(color: AppTheme.lightGray),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.white, width: 2.0, style: BorderStyle.solid),
                borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.white, width: 2.0, style: BorderStyle.solid),
                borderRadius: borderRadius,
            ),
            contentPadding: EdgeInsets.only(top: 24.0, right: 24.0, bottom: 24.0, left: 24.0),
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: ThemeColors.blue, width: 5.0),
            //   borderRadius: BorderRadius.circular(8.0),
            // ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.light.withOpacity(0.5), width: 2.0),
                borderRadius: borderRadius,
            ),
            filled: true,
            fillColor: AppTheme.white);
    }

    static TextStyle getSmallTextStyle({fontSize = 14.0,fontWeight = FontWeight.normal, color= white,fontFamily = 'IRANSansMobile', double height = 1.0}){
        return TextStyle(fontSize: fontSize,fontWeight: fontWeight,fontFamily: fontFamily, color: color, height: height);
    }
    static TextStyle getMediumTextStyle({fontSize = 16.0,fontWeight = FontWeight.normal, color= white,fontFamily = 'IRANSansMobile', double height = 1.0}){
        return TextStyle(fontSize: fontSize,fontWeight: fontWeight, color: color,fontFamily: fontFamily, height: height);
    }
    static TextStyle getLargeTextStyle({fontSize = 25.0,fontWeight = FontWeight.bold, color= darkGray,fontFamily = 'IRANSansMobile', double height = 1.0}){
        return TextStyle(fontSize: fontSize,fontWeight: fontWeight, color: color,fontFamily: fontFamily, height: height);
    }

    static final appTheme = ThemeData(
        primarySwatch: primaryColor,
        useMaterial3: false,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'IRANSansMobile',
    );
}