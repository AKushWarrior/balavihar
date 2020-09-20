import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../business/page.dart';
import '../business/multipage.dart';
import '../business/general.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search.dart';

class HomePage extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 75,
            child: NeumorphicText('Peninsula Balvihar',
                textStyle: NeumorphicTextStyle(
                    fontFamily: GoogleFonts.oswald().fontFamily, fontSize: 48),
                style: NeumorphicStyle(color: Colors.white)),
            alignment: Alignment.center,
          ),
          Center(
              child: getNeuButton('Assembly', Colors.orange[800], () => Get.toNamed('/assembly'))),
          Center(
              child: getNeuButton('Patriotic', Colors.red[700],
                  () => Get.offAndToNamed('/patriotic'))),
          Center(
              child: getNeuButton('Bhajans', Colors.purple[700],
                  () => Get.offAndToNamed('/bhajans'))),
          Center(
              child: getNeuButton('Shlokams', Colors.indigo[700],
                  () => Get.offAndToNamed('/shlokams'))),
        ],
      ),
      floatingActionButton: NeumorphicButton(
        boxShape: NeumorphicBoxShape.circle(),
        child: Icon(
          Icons.search,
          size: iconSize,
        ),
        onPressed: () {},
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          lightSource: LightSource.top,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

Widget getNeuButton(String text, Color color, void Function() cb) {
  return NeumorphicButton(
      onPressed: cb,
      padding: EdgeInsets.symmetric(
          vertical: paddingHeight, horizontal: paddingWidth),
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          lightSource: LightSource.top,
          color: color,
          depth: 0.1),
      child: Container(
          width: 110,
          alignment: Alignment.center,
          child: Text(text,
              style: GoogleFonts.oswaldTextTheme()
                  .headline2
                  .copyWith(color: Colors.white, fontSize: 24))));
}

double get paddingHeight => Get.height / 14;

double get paddingWidth => Get.width / 3.35;

double get iconSize => Get.height / 20;
