import 'package:faramusic/models/singer_model.dart';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:faramusic/ui/ui_helpers/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';


class SingersScreen extends StatefulWidget {
  const SingersScreen({super.key});

  @override
  State<SingersScreen> createState() => _SingersScreenState();
}

class _SingersScreenState extends State<SingersScreen> {
  bool pageIsLoaded = false;
  @override
  void initState() {

    super.initState();
    ///////////////////////////////////////////////////////////////
    _getData();
  }
  List<SingerModel> singer =[
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Roozbeh-Bemani-Bala-Boland-300x300.jpg",
        title: "روزبه بمانی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/09/Ali-Zand-Vakili-Bi-Tafavoti-300x300.jpg",
        title: "علی زند وکیلی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/10/Ali-Lohrasbi-Heyfeh-300x300.jpg",
        title: "علی لهراسبی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Hamed-Homayoun-Ghole-Mardoone-300x300.jpg",
        title: "حامد همایون"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Roozbeh-Bemani-Bala-Boland-300x300.jpg",
        title: "روزبه بمانی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/09/Ali-Zand-Vakili-Bi-Tafavoti-300x300.jpg",
        title: "علی زند وکیلی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/10/Ali-Lohrasbi-Heyfeh-300x300.jpg",
        title: "علی لهراسبی"),
    SingerModel(id: 1, image: "https://rozmusic.com/wp-content/uploads/2023/11/Hamed-Homayoun-Ghole-Mardoone-300x300.jpg",
        title: "حامد همایون"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: searchBar.getSearchBar(context),
      body:  !pageIsLoaded ? LoadingWidget() :
      ListView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
          itemCount: singer.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  getSingerItem(singer[index]),
                ],
              ),
            );
          }
      ),
    );
  }
  _getData() async {
    try {
      ApiManager apiManager = ApiManager();

      ApiResponseModel response = ApiResponseModel();
      response.status = "ok";


      if (response.status == 'ok') {

        await  Future.delayed(const Duration(milliseconds: 3000), () {});

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

  Widget getSingerItem(SingerModel singer) {
    return Material(
      color: AppTheme.backgroundColor,
      child: InkWell(
        onTap: (){
          context.push('/singer-profile');
        },
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
                          borderRadius: AppTheme.borderRadiusLarg,
                        ),
                        child: ClipRRect(
                          borderRadius: AppTheme.borderRadiusLarg,
                          child: NetworkImageWidget(image: singer.image!,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 15),
                        child: Text(
                          singer.title.toString(),
                          style: AppTheme.getSmallTextStyle(color: AppTheme.darkBlue, fontWeight: FontWeight.w400,),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/icons/queue_music.svg",),
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
    );
  }



}
