import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/util/constant_value.dart';
import 'package:flutter_news_app/core/util/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final constantColor = ConstantColor();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final widthScreen = mediaQueryData.size.width;
    return Scaffold(
      backgroundColor: constantColor.primaryColor500,
      body: Center(
        child: SvgPicture.asset(
          AssetSvg.logoFlutterNewsRectangle,
          width: widthScreen / 2,
        ),
      ),
    );
  }
}
