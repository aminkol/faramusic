
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';

class EditProfileScreen extends StatefulWidget {
  bool fromLogin;
  EditProfileScreen({this.fromLogin = false,super.key});


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState(fromLogin);
}


class _EditProfileScreenState extends State<EditProfileScreen> {
  bool pageIsLoaded = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }


  _EditProfileScreenState(this.fromLogin);

  bool fromLogin;

  List<String> cars = [
    'z24',
    'nd28',
    'p',
    'p+',
    'pk+',
    'lx',
    'h20',
  ];

  TextEditingController  fullnameInputController = new TextEditingController();
  TextEditingController  dateInputController = new TextEditingController();
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        toolbarHeight: 70,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: SvgPicture.asset(
                  'assets/icons/arrow_back.svg', height: 28,)
            );
          },
        ),
        title: Text("ویرایش اطلاعات کاربری",
          style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),),
      ),
      body: !pageIsLoaded ? LoadingWidget() :
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
                controller: fullnameInputController,
                maxLines: 1,
                maxLength: 11,
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.name,
                style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,),
                textAlign: TextAlign.right,
                decoration: AppTheme.getInputDecoration(hintText: 'نام و نام خانوادگی')
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
                controller: dateInputController,
                maxLines: 1,
                maxLength: 11,
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.datetime,
                style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,),
                textAlign: TextAlign.right,
                decoration: AppTheme.getInputDecoration(hintText: 'تاریخ تولد')
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: EdgeInsets.only(right: 20, left: 20),
            height: 55,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: AppTheme.borderRadiusLarg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text("جنسیت", style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray),)
                ),
                Icon(Icons.chevron_right, color: AppTheme.lightGray,),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            height: 55,
            child: ElevatedButton(
              onPressed: (){
                _editProfile();
              },
              style: AppTheme.buttonStyle,
              child: Center(child: btnLoading == true
                  ? Image.asset('assets/images/loading.gif',width: 50,height: 50,)
                  :   Text('ثبت', style: AppTheme.getSmallTextStyle(color: AppTheme.white),)),
            ),
          ),
        ],
      )
    );
  }
  _getData() async {
    try {
      ApiManager apiManager = ApiManager();

      ApiResponseModel response = ApiResponseModel();
      response.status = "ok";


      if (response.status == 'ok') {

         await Future.delayed(const Duration(milliseconds: 3000), () {

        });


      } else{

        Alert.show(context, response.error!,type: ToastificationType.error);
      }

      pageIsLoaded = true;
      setState(() {});
    } catch (e) {
      pageIsLoaded = true;
      setState(() {});
      print(e.toString());
      Alert.show(context, 'خطا - ' + e.toString(),type: ToastificationType.error);
    }
  }
  _editProfile() async {
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
        Alert.show(context, 'تغییرات با موفقیت ثبت شد');
        Navigator.pop(context);

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
