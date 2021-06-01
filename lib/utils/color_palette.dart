import 'dart:core';

import 'package:flutter/cupertino.dart';

enum ColorPalette{
  blue, blueGreen, green, greenAccent, lightGreen
}

extension ColorPaletteExt on ColorPalette{
    Color get colorPalette{
      switch (this) {
        case ColorPalette.blue:
          return Color(0xFF205072);
        case ColorPalette.blueGreen:
          return Color(0xFF329D9C);
        case ColorPalette.blueGreen:
          return Color(0xFF56C596);
        case ColorPalette.blueGreen:
          return Color(0xFF7BE495);
        case ColorPalette.blueGreen:
          return Color(0xFFCFF4D2);
        default:
          return null;
      }
    }
}