import 'package:faramusic/ui/pages/account/profile_screen.dart';
import 'package:faramusic/ui/pages/basic/home_screen.dart';
import 'package:faramusic/ui/pages/contents/singers_screen.dart';
import 'package:faramusic/ui/pages/contents/categories_screen.dart';
import 'package:faramusic/ui/pages/contents/singers_screen.dart';
import 'package:flutter/material.dart';
import 'package:faramusic/ui/theme/app_theme.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  final PageController _pageController = PageController();
  List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    SingersScreen(),
    ProfileScreen(),
  ];

  int selectIndex = 0;
  void onPageChanged(int index){
    setState(() {
      selectIndex = index;
    });
  }

  void onItemTap(int selectedItems){
    _pageController.jumpToPage(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22.0), topRight: Radius.circular(22.0), ),
        child: SizedBox(
          height: 65,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,
                color: selectIndex==0?AppTheme.white:AppTheme.light,),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.toc_rounded,
                color: selectIndex==1?AppTheme.white:AppTheme.light,),
                label: 'دسته بندی',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note_rounded,
                color: selectIndex==2?AppTheme.white:AppTheme.light,),
                label: 'خواننده ها',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded,
                color: selectIndex==3?AppTheme.white:AppTheme.light,),
                label: 'حساب کاربری',
              ),
            ],
            currentIndex: selectIndex,
            onTap: onItemTap,
            type: BottomNavigationBarType.fixed,
            iconSize: 25,
            selectedLabelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: "IRANSansMobile",
              color: AppTheme.white,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: "IRANSansMobile",
              color: AppTheme.light,
            ),
            unselectedItemColor: AppTheme.light,
            selectedItemColor: AppTheme.white,
            backgroundColor: AppTheme.primaryColor,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
