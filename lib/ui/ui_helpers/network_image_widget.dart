import 'package:flutter/material.dart';

import '../data.dart';

class NetworkImageWidget extends StatelessWidget {
  String image;
  NetworkImageWidget({required this.image,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: Data.uploadFilePath + image,
      fit: BoxFit.fill,
      placeholder:
      'assets/images/placeholder.gif',
    );
  }
}
