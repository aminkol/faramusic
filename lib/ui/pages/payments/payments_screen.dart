import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../../models/payment_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool pageIsLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  List<PaymentModel> payments = [

    PaymentModel(id: 23, amount: 30000 , createdAt: '1402/09/12' , status: 'موفق' , trackingCode: '658554556'),
    PaymentModel(id: 24, amount: 60000 , createdAt: '1402/09/12', status: 'موفق' , trackingCode: '12356886'),
    PaymentModel(id: 25, amount: 30000 , createdAt: '1402/09/12' , status: 'موفق' , trackingCode: '33365985'),
    PaymentModel(id: 25, amount: 30000 , createdAt: '1402/09/12' , status: 'موفق' , trackingCode: '33365985'),
    PaymentModel(id: 25, amount: 30000 , createdAt: '1402/09/12' , status: 'موفق' , trackingCode: '33365985'),
  ];
  bool statusColor = true;


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
        title: Text("تاریخچه پرداخت",
          style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),),
      ),
      body:  !pageIsLoaded ? LoadingWidget() :

      ListView.builder(
          shrinkWrap: true,
          itemCount: payments.length ,
          itemBuilder: (context, index) {
            return PaymentWidget(payments[index]);
          },
      ),

    );
  }
  PaymentWidget( PaymentModel model  ){
    return Container(
      margin: EdgeInsets.only(left: 20 , right:20 , top: 10 , bottom: 10),
      decoration: BoxDecoration(
          borderRadius: AppTheme.borderRadiusMedium,
          border: Border.all(width: 1, color: AppTheme.light),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text( model.id!.toString() , style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15 , left: 15 , bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('تاریخ' , style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor)),
                Text(model.createdAt!, style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15 , left: 15 , bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('مبلغ', style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor)),
                Text( model.amount!.toString() + 'تومان', style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15 , left: 15 , bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('کد رهگیری', style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor)),
                Text(model.trackingCode!, style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15 , left: 15 , bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('وضعیت', style: AppTheme.getMediumTextStyle(color: AppTheme.primaryColor)),
                Text(  model.status!,style: AppTheme.getMediumTextStyle(color:statusColor? AppTheme.green : AppTheme.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _getData() async {
    try {
      ApiManager apiManager = ApiManager();

      ApiResponseModel response = ApiResponseModel();
      response.status = "ok";


      if (response.status == 'ok') {

        Future.delayed(const Duration(milliseconds: 3000), () {});

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
}




