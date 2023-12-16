import 'package:faramusic/models/music_model.dart';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';


class MusicListScreen extends StatefulWidget {
  const MusicListScreen({super.key});

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  bool pageIsLoaded = false;
  String sortBy = "latest";
  @override
  void initState() {

    super.initState();
    _getData();

  }


  List<Music> music =[
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Roozbeh-Bemani-Bala-Boland-300x300.jpg",
        title: "بالا بلند", name: "روزبه بمانی", likeCount: "700"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/09/Ali-Zand-Vakili-Bi-Tafavoti-300x300.jpg",
        title: "بی تفاوتی", name: "علی زند وکیلی", likeCount: "650"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/10/Ali-Lohrasbi-Heyfeh-300x300.jpg",
        title: "حیفه", name: "علی لهراسبی", likeCount: "780"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Hamed-Homayoun-Ghole-Mardoone-300x300.jpg",
        title: "قول مردونه", name: "حامد همایون", likeCount: "400"),
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
        title: Text("لیست آهنگ های پاپ",
          style: AppTheme.getSmallTextStyle(color: AppTheme.primaryColor),),
      ),
      body: !pageIsLoaded ? LoadingWidget() : ListView(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.only(right: 20, left: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ChoiceChip(
                      backgroundColor: Color(0xff98a2bf),
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: sortBy == "latest" ? AppTheme.getSmallTextStyle(color: AppTheme.white, fontSize: 13.0, fontWeight: FontWeight.w300) : AppTheme.getSmallTextStyle(color: AppTheme.primaryColor, fontSize: 13.0, fontWeight: FontWeight.w300),
                      labelPadding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
                      label: Text("جدیدترین"),
                      selected: sortBy == "latest" ? true : false,
                      onSelected: (val){
                        setState(() {
                          sortBy = "latest";
                          //todo: update from server
                        });
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ChoiceChip(
                      backgroundColor: Color(0xff98a2bf),
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: sortBy == "oldest" ? AppTheme.getSmallTextStyle(color: AppTheme.white, fontSize: 13.0, fontWeight: FontWeight.w300) : AppTheme.getSmallTextStyle(color: AppTheme.primaryColor, fontSize: 13.0, fontWeight: FontWeight.w300),
                      labelPadding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
                      label: Text("قدیمی ترین"),
                      selected: sortBy == "oldest" ? true : false,
                      onSelected: (newboolvalue){
                        setState(() {
                          sortBy = "oldest";
                          //todo: update from server
                        });
                      }
                  ),
                ),
                ChoiceChip(
                    backgroundColor: Color(0xff98a2bf),
                    selectedColor: AppTheme.primaryColor,
                    labelStyle: sortBy == "popular" ? AppTheme.getSmallTextStyle(color: AppTheme.white, fontSize: 13.0, fontWeight: FontWeight.w300) : AppTheme.getSmallTextStyle(color: AppTheme.primaryColor, fontSize: 13.0, fontWeight: FontWeight.w300),
                    labelPadding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
                    label: Text("محبوب ترین"),
                    selected: sortBy == "popular" ? true : false,
                    onSelected: (newboolvalue){
                      setState(() {
                        sortBy = "popular";
                        //todo: update from server
                      });
                    }
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              itemCount: music.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      getMusicListItem(music[index]),
                    ],
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  Widget getMusicListItem(Music music) {
    return GestureDetector(
      onTap: () {
        context.push('');
      },
      child: Material(
        color: AppTheme.backgroundColor,
        child: InkWell(
          onTap: (){},
          highlightColor: AppTheme.backgroundColor,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 0,),
            padding: EdgeInsets.only(top: 12, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: AppTheme.borderRadiusSmall,
                          ),
                          child: ClipRRect(
                            borderRadius: AppTheme.borderRadiusSmall,
                            child: NetworkImageWidget(image: music.image!,)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 15),
                          child: Text(
                            music.title.toString(),
                            style: AppTheme.getSmallTextStyle(color: AppTheme.darkBlue, fontWeight: FontWeight.w400,),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset("assets/icons/favorite.svg",),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(music.likeCount.toString(), style: AppTheme.getSmallTextStyle(color: AppTheme.light),),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 0),
                  child:Divider(height: 0.5, color: AppTheme.light.withOpacity(0.3),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _getData() async {
    try {
      ApiManager apiManager = ApiManager();

      ApiResponseModel response = ApiResponseModel();
      response.status = "ok";


      if (response.status == 'ok') {

        await Future.delayed(const Duration(milliseconds: 3000), () {});

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
