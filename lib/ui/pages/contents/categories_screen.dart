import 'package:faramusic/models/category_model.dart';
import 'package:faramusic/ui/theme/app_theme.dart';
import 'package:faramusic/ui/ui_helpers/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:faramusic/ui/ui_helpers/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../api/api_manager.dart';
import '../../../api/api_response_model.dart';
import '../../ui_helpers/alert.dart';
import '../../ui_helpers/loading_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool pageIsLoaded = false;

  @override
  void initState() {

    super.initState();
    _getData();

  }

  List<Category> category =[
    Category(id: 1, image: "https://gilaro.com/store/1017/file/205.jpg",
      title: "پاپ",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/03/848dba99-5e00-49d2-a666-5d827178dcca.jpg",
      title: "سنتی",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/04/f-Shocking-Benefits-of-Listening-to-Classical-Music-750x450.webp",
      title: "کلاسیک",),
    Category(id: 1, image: "https://setare.com/files/fa/news/1397/6/4/178990_184.jpg",
      title: "رپ",),
    Category(id: 1, image: "https://worldofmusic.ir/upls/media/202308/mt3d20hcdc.jpg",
      title: "راک",),
    Category(id: 1, image: "https://packmusic.ir/wp-content/uploads/2021/11/yanni-1.jpg",
      title: "بی کلام",),
    Category(id: 1, image: "https://gilaro.com/store/1017/file/205.jpg",
      title: "پاپ",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/03/848dba99-5e00-49d2-a666-5d827178dcca.jpg",
      title: "سنتی",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/04/f-Shocking-Benefits-of-Listening-to-Classical-Music-750x450.webp",
      title: "کلاسیک",),
    Category(id: 1, image: "https://setare.com/files/fa/news/1397/6/4/178990_184.jpg",
      title: "رپ",),
    Category(id: 1, image: "https://worldofmusic.ir/upls/media/202308/mt3d20hcdc.jpg",
      title: "راک",),
    Category(id: 1, image: "https://packmusic.ir/wp-content/uploads/2021/11/yanni-1.jpg",
      title: "بی کلام",),
    Category(id: 1, image: "https://gilaro.com/store/1017/file/205.jpg",
      title: "پاپ",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/03/848dba99-5e00-49d2-a666-5d827178dcca.jpg",
      title: "سنتی",),
    Category(id: 1, image: "https://notefa.ir/wp-content/uploads/2022/04/f-Shocking-Benefits-of-Listening-to-Classical-Music-750x450.webp",
      title: "کلاسیک",),
    Category(id: 1, image: "https://setare.com/files/fa/news/1397/6/4/178990_184.jpg",
      title: "رپ",),
    Category(id: 1, image: "https://worldofmusic.ir/upls/media/202308/mt3d20hcdc.jpg",
      title: "راک",),
    Category(id: 1, image: "https://packmusic.ir/wp-content/uploads/2021/11/yanni-1.jpg",
      title: "بی کلام",),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: searchBar.getSearchBar(context),
      body:  !pageIsLoaded ? LoadingWidget() :
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: category.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              mainAxisSpacing: 9.5,
              crossAxisSpacing: 2.8,
            ),
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
        ),
      ),
    );
  }

  Widget getCategoryItem(Category category) {
    return Container(
      width: 175,
      margin: EdgeInsets.only(left: 8, right: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppTheme.borderRadiusSmall,
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 85,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: AppTheme.borderRadiusSmall,
            ),
            child: ClipRRect(
              borderRadius: AppTheme.borderRadiusSmall,
              child: NetworkImageWidget(image: category.image!,)
            ),
          ),
          Material(
            color: AppTheme.black.withOpacity(0.4),
            borderRadius: AppTheme.borderRadiusSmall,
            child: InkWell(
              onTap: (){
                context.push("/music-list");
              },
              highlightColor: AppTheme.black,
              borderRadius: AppTheme.borderRadiusSmall,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                decoration: BoxDecoration(
                  color: AppTheme.black.withOpacity(0.4),
                  borderRadius: AppTheme.borderRadiusSmall,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 33),
            child: Center(
              child: Text(
                category.title.toString(),
                style: AppTheme.getSmallTextStyle(color: AppTheme.white, fontWeight: FontWeight.w400),
              ),
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
