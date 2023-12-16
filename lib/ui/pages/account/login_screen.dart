import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../theme/app_theme.dart';
import '../../ui_helpers/alert.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool  btnLoading = false;
  TextEditingController  phoneInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        width: double.infinity,
        child:ListView(
          children: [
            SizedBox(
              height: 250,
            ),
            Center(child: Text('ورود به اپلیکیشن',
                style: AppTheme.getLargeTextStyle(color: AppTheme.primaryColor))),
            SizedBox(
              height: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextField(
                  controller: phoneInputController,
                  maxLines: 1,
                  maxLength: 11,
                  autofocus: false,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  style: AppTheme.getSmallTextStyle(color: AppTheme.gray,),
                  textAlign: TextAlign.right,
                  decoration: AppTheme.getInputDecoration(hintText: 'شماره همراه',)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20, left: 20 , ),
              child: ElevatedButton(onPressed: () {

                _login();

              }, child: btnLoading ? Image(
                  image: AssetImage('assets/images/loading.gif')) : Text('ورود') ,

                style: AppTheme.buttonStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,),
                    children: <TextSpan>[
                      TextSpan(text: 'ورود به اپلیکیشن به معنی پذیرش'),
                      TextSpan(text: ' قوانین و مقررات ', style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor,fontWeight: FontWeight.bold)),
                      TextSpan(text: 'است'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ) ,
      ),
    );
  }
  _login() async {
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
        context.push("/verify-login");

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



