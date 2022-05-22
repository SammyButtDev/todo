import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardCust extends StatelessWidget {
  final String image;
  final String title;
  final String detail;
  OnBoardCust(
      {Key? key,
        required this.image,
        required this.detail,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Image(
            image: AssetImage(
              image,
            ),filterQuality: FilterQuality.high,
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
          Text(
            title,
            style:  const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              detail,
              textAlign: TextAlign.center,
              style:  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}

class IndicatorBar extends GetView {
  int currentIndex;
  late int index;
  IndicatorBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                  3,
                      (index) => Padding(
                    padding:  EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.blueGrey
                            : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
            ),
            TextButton(
              onPressed: () {
                Get.offNamed("/login");
              },
              child: Text(
                currentIndex == 2 ? "Get Start" : "Skip",
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

