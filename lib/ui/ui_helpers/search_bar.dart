import 'package:flutter/material.dart';
import 'package:faramusic/ui/theme/app_theme.dart';


class searchBar{
  static getSearchBar(context, {enableBack = false}) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {

          },
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 60,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: AppTheme.borderRadiusLarg,
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 28, color: AppTheme.lightGray,),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text("نام آهنگ یا خواننده", style: AppTheme.getSmallTextStyle(color: AppTheme.lightGray),),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  static IconData? icon(IconData search) {}
}