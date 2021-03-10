import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: const NetworkImage(
                'https://static.wixstatic.com/media/96ebd6_a922a9d47bc848429ba6b'
                '549dc01aa6a~mv2.jpg/v1/fill/w_250,h_250,al_c,q_80,usm_0.66_'
                '1.00_0.01/Logo_Suggestedchanges_JPG.webp'),
            height: Screen.height(context) / 4,
          ),
          Center(
              child: NeuButton('Assembly', Colors.orange[800],
                  () => Nav.router.navigateTo(context, '/assembly'))),
          Center(
              child: NeuButton('Songs & Bhajans', Colors.red[700],
                  () => Nav.router.navigateTo(context, '/bhajans'))),
          Center(
              child: NeuButton(
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

class NeuButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() cb;

  NeuButton(this.text, this.color, this.cb);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cb,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Screen.borderRadius)),
        margin: EdgeInsets.symmetric(horizontal: Screen.marginX(context)),
        color: color,
        child: Container(
          padding: EdgeInsets.symmetric(
            // TODO: Normalize vertical padding when Songs are ready
            vertical: text != 'Shlokams\nComing Soon'
                ? Screen.height(context) / 17
                : Screen.height(context) / 17 - 16.75,
            horizontal: Screen.marginX(context),
          ),
          width: Screen.width(context) / 3 * 2.5,
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
}