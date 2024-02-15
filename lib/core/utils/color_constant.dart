import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray500 = fromHex('#a8a8a8');

  static Color blueGray400 = fromHex('#8c8fa5');

  static Color redA200 = fromHex('#fb576b');

  static Color gray90099 = fromHex('#99172331');

  static Color gray900 = fromHex('#172331');

  static Color black9003f = fromHex('#3f000000');

  static Color blue50 = fromHex('#e6eff9');

  static Color gray100 = fromHex('#f3f4f8');

  static Color black900Dd = fromHex('#dd000000');

  static Color black90099 = fromHex('#99000000');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color blueGray700 = fromHex('#275878');

  static Color black90019 = fromHex('#19000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blueGray40099 = fromHex('#998c8fa5');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
