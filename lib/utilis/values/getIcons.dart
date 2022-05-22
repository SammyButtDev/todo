import 'package:flutter/widgets.dart';
import 'package:todo/utilis/values/iconss.dart';

List<Icon> getIcons() {

  return const [
    Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: pink,
    ),
    Icon(
      IconData(workIcon, fontFamily: 'MaterialIcons'),
      color: deepPink,
    ),
    Icon(
      IconData(movieIcon, fontFamily: 'MaterialIcons'),
      color: green,
    ),
    Icon(
      IconData(sportsIcon, fontFamily: 'MaterialIcons'),
      color: yellow,
    ),
    Icon(
      IconData(travelIcon, fontFamily: 'MaterialIcons'),
      color: lightBlue,
    ),
    Icon(
      IconData(shopIcon, fontFamily: 'MaterialIcons'),
      color: blue,
    ),
  ];
}


const purple = Color(0xff756bfc);
const pink = Color(0xfff1a39a);
const deepPink = Color(0xfffa63c6);
const green = Color(0xff41cf9f);
const yellow = Color(0xffeec38e);
const lightBlue = Color(0xff42a5f5);
const blue = Color(0xff2860e6);
