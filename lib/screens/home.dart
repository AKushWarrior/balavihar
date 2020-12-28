import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: NetworkImage(
                'https://static.wixstatic.com/media/96ebd6_a922a9d47bc848429ba6b'
                '549dc01aa6a~mv2.jpg/v1/fill/w_250,h_250,al_c,q_80,usm_0.66_'
                '1.00_0.01/Logo_Suggestedchanges_JPG.webp'),
            height: Get.height / 4,
          ),
          Center(
              child: getNeuButton('Assembly', Colors.orange[800],
                  () => Get.toNamed('/assembly'))),
          Center(
              child: getNeuButton('Songs & Bhajans', Colors.red[700],
                  () => Get.toNamed('/bhajans'))),
          Center(
              child: getNeuButton(
                  'Shlokams\nComing Soon', Colors.green[700], null)),
        ],
      ),
      /* Floating Action Button for Search | TODO implement search feature
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
      */
    );
  }
}

Widget getNeuButton(String text, Color color, void Function() cb) {
  return GestureDetector(
    onTap: cb,
    child: Neumorphic(
      padding: EdgeInsets.symmetric(
        // TODO: Normalize vertical padding when Songs are ready
        vertical: text != 'Shlokams\nComing Soon'
            ? paddingHeight
            : doubleTextPaddingHeight,
        horizontal: paddingWidth,
      ),
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
      style: NeumorphicStyle(
        color: color,
      ),
      child: Container(
        width: Get.width / 3 * 2.5,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.oswaldTextTheme()
              .headline2
              .copyWith(color: Colors.white, fontSize: 25),
        ),
      ),
    ),
  );
}

double get paddingHeight => Get.height / 15;

double get doubleTextPaddingHeight => paddingHeight - Get.height / 60;

double get paddingWidth => Get.width / 27;

double get iconSize => Get.height / 20;
