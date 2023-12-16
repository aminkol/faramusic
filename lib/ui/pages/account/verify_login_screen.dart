import 'package:faramusic/ui/pages/account/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';
import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../theme/app_theme.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../ui_helpers/alert.dart';




class VerifyLoginScreen extends StatefulWidget {
  const VerifyLoginScreen({super.key});

  @override
  State<VerifyLoginScreen> createState() => _VerifyLoginScreenState();
}

class _VerifyLoginScreenState extends State<VerifyLoginScreen> {
  bool btnLoading = false;

  bool counterIsComplete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: ListView(
        children: [
          Center(child: Column(
           children: [
             SizedBox(
               height: 250,
             ),
             Text('فعالسازی حساب کاربری',style: AppTheme.getLargeTextStyle(color: AppTheme.primaryColor)),
             SizedBox(
               height: 50,
             ),
             Text('لطفا کد ارسالی به شماره را وارد کنید',
                 style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray)),
             SizedBox(
               height: 25,
             ),
             Text('09300015250',style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor)),
             SizedBox(
               height: 40,
             ),
             PinputExample(

             ),
             SizedBox(
               height: 30,
             ),
             counterIsComplete ? TextButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return LoginScreen();
               },));

             }, child: Text('ارسال مجدد')) : Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 CircularCountDownTimer(
                   width: 25,
                   height: 30,
                   duration: 90,
                   textFormat: "ss",
                   isReverse: true,
                   isReverseAnimation: true,
                   fillColor: AppTheme.backgroundColor,
                   ringColor:AppTheme.backgroundColor,
                   textStyle: TextStyle(
                       color: AppTheme.primaryColor
                   ),
                   onComplete: () {
                     counterIsComplete = true;
                     setState(() {

                     });
                   },
                 ),
                 Text('ثانیه تا ارسال مجدد کد',
                     style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray)),
                 SizedBox(
                   width: 3,
                 ),
               ],
             ),
             SizedBox(
               height: 50,
             ),
             Container(
               height: 55,
               width: double.infinity,
               margin: EdgeInsets.only(right: 85, left: 85 , ),
               child: ElevatedButton(
                 onPressed: () {
                   _verifyLogin();
                 },
                 child: btnLoading ? Image(
                     image: AssetImage('assets/images/loading.gif')) : Text('تایید') ,
                 style: AppTheme.buttonStyle,
               ),
             )
           ],
          )),
        ],
      ),
    );
  }
  _verifyLogin() async {
    try {

      if(btnLoading){
        return;
      }
      btnLoading = true;
      setState((){});

      ApiManager apiManager = ApiManager();

      ApiResponseModel response = ApiResponseModel();
      response.status = "ok";


      if (response.status == 'ok') {

        await Future.delayed(const Duration(milliseconds: 3000), () {});
        //context.push("/verify-login");
        context.push("/main-wrapper");


      } else{

        Alert.show(context, response.error!,type: ToastificationType.error);
      }

      btnLoading = false;
      setState(() {});
    } catch (e) {
      btnLoading = false;
      setState(() {});
      print(e.toString());
      Alert.show(context, 'خطا - ' + e.toString(),type: ToastificationType.error);
    }
  }
}


class PinputExample extends StatefulWidget {
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppTheme.lightGray;
    const fillColor = Colors.white;
    const borderColor = AppTheme.backgroundColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
              AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 10),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
              },

              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),

              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),


          /*
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              formKey.currentState!.validate();
            },
            child: const Text('Validate'),
          ),
           */

        ],
      ),
    );
  }

}
