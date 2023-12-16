import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:faramusic/ui/ui_helpers/search_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: searchBar.getSearchBar(context),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 25, bottom: 25, right: 7),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
            ),
            child: Column(
              children: [
                Text("محمد عزیز خوش آمدید", style: AppTheme.getMediumTextStyle(color: AppTheme.gray, fontSize: 18.0)),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: (){
                      _subscriptionBottomSheet();
                    },
                    child: RichText(
                      text: TextSpan(
                        style: AppTheme.getSmallTextStyle(color: AppTheme.light,),
                        children: <TextSpan>[
                          TextSpan(text: 'اشتراک فعالی ندارید'),
                          TextSpan(text: ' خرید اشتراک ', style: AppTheme.getSmallTextStyle(color: AppTheme.red,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 7),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
            ),
            child: Material(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      context.push("/payment");
                    },
                    leading: SvgPicture.asset("assets/icons/credit_card.svg",),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                    title: new Text(
                        "تاریخچه خرید",
                        style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                    ),
                  ),
                  Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                  ListTile(
                    onTap: (){
                      context.push("/edit-profile");
                    },
                    leading: SvgPicture.asset("assets/icons/Group_53.svg",),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                    title: new Text(
                        "ویرایش اطلاعات کاربری",
                        style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                    ),
                  ),
                  Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                  ListTile(
                    leading: SvgPicture.asset("assets/icons/verified_user.svg",),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                    title: new Text(
                      "قوانین و مقررات",
                      style: AppTheme.getSmallTextStyle(color: AppTheme.gray),
                    ),
                    onTap: (){},
                  ),
                  Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                  ListTile(
                    leading: SvgPicture.asset("assets/icons/info.svg",),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray),
                    title: new Text(
                      "درباره ما",
                      style: AppTheme.getSmallTextStyle(color: AppTheme.gray),
                    ),
                    onTap: (){},
                  ),
                  Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                  ListTile(
                    leading: SvgPicture.asset("assets/icons/call.svg",),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray),
                    title: new Text(
                      "تماس با ما",
                      style: AppTheme.getSmallTextStyle(color: AppTheme.gray),
                    ),
                    onTap: (){},
                  ),
                  Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _subscriptionBottomSheet() {
    showFloatingModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, state) => Container(
          //height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20, right: 16, bottom: 10),
                      child: Text('انتخاب اشتراک',style: AppTheme.getMediumTextStyle(color: AppTheme.lightGray),)
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: (){},
                        trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                        title: new Text(
                            "یک ماهه - 30 هزار تومان",
                            style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                        ),
                      ),
                      Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                      ListTile(
                        onTap: (){},
                        trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                        title: new Text(
                            "سه ماهه - 80 هزار تومان",
                            style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                        ),
                      ),
                      Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                      ListTile(
                        onTap: (){},
                        trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                        title: new Text(
                            "شش ماهه - 130 هزار تومان",
                            style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                        ),
                      ),
                      Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                      ListTile(
                        onTap: (){},
                        trailing: Icon(Icons.chevron_right, color: AppTheme.lightGray,),
                        title: new Text(
                            "یک ساله - 220 هزار تومان",
                            style: AppTheme.getSmallTextStyle(color: AppTheme.gray)
                        ),
                      ),
                      Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
