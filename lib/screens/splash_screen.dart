import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends GetView{
  const Splash({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
   return  SafeArea(
     child: Scaffold(
       body: Center(
         child: Column(mainAxisSize: MainAxisSize.min,
           children: [
             SizedBox(
               height: Get.height*0.2,
               width: Get.height*0.2,
               child:const  Image(image:  AssetImage("assets/logo.png"),),
             ),
             SizedBox(
               height: Get.height*0.03,
             ),

             AnimatedTextKit(
               animatedTexts: [
                 TyperAnimatedText(
                   'MAKE YOUR DAY',
                   textStyle: GoogleFonts.macondo(fontSize: 32,fontWeight: FontWeight.w600,color: Colors.black),speed: Duration(milliseconds: 100),
                 ),
               ],totalRepeatCount: 1,onFinished: ()async{
                 await Get.offNamed("/home");
             },
             ),
           ],
         ),
       ),
     ),
   );
  }

}