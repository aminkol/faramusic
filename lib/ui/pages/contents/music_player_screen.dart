import 'package:faramusic/models/comment_model.dart';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/floating_modal.dart';
import 'package:faramusic/ui/ui_helpers/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {

  var btnLoading = false;

  TextEditingController  informationInputController = new TextEditingController();

  List<Comment> comment =[
    Comment(id: 1, title: "محمد بهادری", text: "خیلی آهنگ خوبیه"),
    Comment(id: 1, title: "امین کولیوند", text: "فوق العاده بود"),
  ];

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
        // title: Text("",
        //   style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 390,
            height: 390,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: AppTheme.borderRadiusMedium,
            ),
            child: ClipRRect(
              borderRadius: AppTheme.borderRadiusMedium,
              child: NetworkImageWidget(image: "https://rozmusic.com/wp-content/uploads/2023/09/Ali-Zand-Vakili-Bi-Tafavoti-300x300.jpg",)
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Slider(
              value: 1,
              max: 20,
              onChanged: (value) {

              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("3:38", style: AppTheme.getSmallTextStyle(color: AppTheme.light),),
                Text("0:10", style: AppTheme.getSmallTextStyle(color: AppTheme.light),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20,),
            child: Column(
              children: [
                Text("بی تفاوتی", style: AppTheme.getLargeTextStyle(color: AppTheme.primaryColor),),
                SizedBox(
                  height: 12,
                ),
                Text("علی زند وکیلی", style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w300, fontSize: 14.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/file-download.svg', height: 32,),
                    Container(
                      width: 50,
                      height: 32,
                    ),
                  ],
                ),
                SizedBox(
                    width: 75,
                    height: 75,
                    child: Icon(Icons.pause_circle_filled_rounded,
                      color: AppTheme.primaryColor,size: 75,)
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 22),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/favorite-border.svg', height: 23,),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text("125", style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 35),
                      child: SvgPicture.asset(
                        'assets/icons/subject.svg', height: 32,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("لیست نظرات", style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray),),
                GestureDetector(
                  onTap: (){
                    _registerComment();
                  },
                  child: Text("ثبت نظر", style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),)
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              itemCount: comment.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      getCommentItem(comment[index]),
                    ],
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  Widget getCommentItem(Comment comment) {
    return Material(
      color: AppTheme.backgroundColor,
      child: InkWell(
        onTap: (){
          context.push('');
        },
        highlightColor: AppTheme.backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 12, right: 20, left: 20),
          padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
          decoration: BoxDecoration(
            borderRadius: AppTheme.borderRadiusMedium,
            border: Border.all(width: 1.0, color: AppTheme.light),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.title.toString(),
                style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,),
                child: Text(
                  comment.text.toString(),
                  style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _registerComment() {
    showFloatingModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, state) => Container(
          //height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: TextField(
                            controller: informationInputController,
                            maxLines: 4,
                            autofocus: false,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray,),
                            textAlign: TextAlign.right,
                            decoration: AppTheme.getInputDecoration(hintText: 'متن',borderRadius: AppTheme.borderRadiusMedium)
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        height: 55,
                        child: ElevatedButton(
                          onPressed: (){
                          },
                          style: AppTheme.buttonStyle,
                          child: Center(child: btnLoading == true
                              ? Image.asset('assets/images/loading.gif',width: 50,height: 50,)
                              :   Text('ارسال نظر', style: AppTheme.getSmallTextStyle(),)),
                        ),
                      ),
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
