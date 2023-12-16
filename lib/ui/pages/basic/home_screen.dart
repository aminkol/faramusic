import 'package:carousel_slider/carousel_slider.dart';
import 'package:faramusic/models/category_model.dart';
import 'package:faramusic/models/music_model.dart';
import 'package:faramusic/models/slide_model.dart';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:faramusic/ui/ui_helpers/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool pageIsLoaded = false;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Slide> slides = [
    Slide(banner: "https://istanbulconcerts.org/wp-content/uploads/2022/01/maxresdefault-11.jpg"),
    Slide(banner: "https://asrghanoon.ir/wp-content/uploads/2023/03/talischi.jpg"),
    Slide(banner: "https://static2.honaronline.ir/servev2/DlG38fMjvAYz/Oat4d8LqIa8,/9212E9EA-52FC-47AB-A3B6-DE6D360C598B.jpeg"),
  ];

  List<Music> music =[
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Roozbeh-Bemani-Bala-Boland-300x300.jpg",
        title: "بالا بلند", name: "روزبه بمانی"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/09/Ali-Zand-Vakili-Bi-Tafavoti-300x300.jpg",
        title: "بی تفاوتی", name: "علی زند وکیلی"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/10/Ali-Lohrasbi-Heyfeh-300x300.jpg",
        title: "حیفه", name: "علی لهراسبی"),
    Music(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Hamed-Homayoun-Ghole-Mardoone-300x300.jpg",
        title: "قول مردونه", name: "حامد همایون"),
  ];

  List<Category> category =[
    Category(id: 1, image: "https://gilaro.com/store/1017/file/205.jpg",
        title: "پاپ",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/03/848dba99-5e00-49d2-a666-5d827178dcca.jpg",
        title: "سنتی",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/04/f-Shocking-Benefits-of-Listening-to-Classical-Music-750x450.webp",
        title: "کلاسیک",),
    Category(id: 1, image: "https://setare.com/files/fa/news/1397/6/4/178990_184.jpg",
        title: "رپ",),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: searchBar.getSearchBar(context),
      body:  !pageIsLoaded ? LoadingWidget() :
      ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16/9,
                enableInfiniteScroll: false,
                autoPlay: true,
                viewportFraction: .9,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: slides.map((e) => GestureDetector(
                onTap: () async{
                  if(e.type == 'link'){
                    launchUrl(Uri.parse(e.link!),mode: LaunchMode.externalApplication);
                  }

                },
                child: Container(
                    margin: EdgeInsets.all(0),
                    child:  ClipRRect(
                      borderRadius: AppTheme.borderRadiusMedium,
                      child: FadeInImage.assetNetwork(
                        image: e.banner!,
                        fit: BoxFit.cover,
                        height: 180,
                        placeholder:
                        'assets/images/placeholder.gif',
                      ),
                    )
                ),
              )
              ).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 30),
            child: Text("برگزیده ها", style: AppTheme.getMediumTextStyle(color: AppTheme.darkGray),),
          ),
          Container(
              height: 230,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: music.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Column(
                        children: [
                          getMusicItem(music[index]),
                        ],
                      ),
                    );
                  }
              )
          ),

          Container(
              height: 70,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Column(
                        children: [
                          getCategoryItem(category[index]),
                        ],
                      ),
                    );
                  }
              )
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20, top: 30),
            child: Text("جدیدترین ها", style: AppTheme.getMediumTextStyle(color: AppTheme.darkGray),),
          ),
          Container(
              height: 230,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: music.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Column(
                        children: [
                          getMusicItem(music[index]),
                        ],
                      ),
                    );
                  }
              )
          ),
        ],
      ),
    );
  }

  Widget getMusicItem(Music music) {
    return GestureDetector(
      onTap: () {
        context.push("");
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderRadiusSmall,
        ),
        child: Column(
          children: [
            Container(
              height: 150,
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
              padding: const EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                    music.title.toString(),
                    style: AppTheme.getSmallTextStyle(color: AppTheme.darkGray, fontWeight: FontWeight.w400)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                    music.name.toString(),
                    style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray, fontWeight: FontWeight.w300)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        context.push("");
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(left: 8, right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderRadiusSmall,
        ),
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: AppTheme.borderRadiusSmall,
              ),
              child: ClipRRect(
                borderRadius: AppTheme.borderRadiusSmall,
                child: NetworkImageWidget(image: category.image!,)
              ),
            ),
            Container(
              width: 150,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.black.withOpacity(0.4),
                borderRadius: AppTheme.borderRadiusSmall,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 28),
              child: Center(
                child: Text(
                    category.title.toString(),
                    style: AppTheme.getSmallTextStyle(color: AppTheme.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
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
