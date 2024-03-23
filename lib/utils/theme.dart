import 'package:flutter/material.dart';

class DeepBreathColors {
  static const Color background = Color(0xFFFAFAFA);
  static const Color searchBarBackground = Color(0xF1FFFAFF);
  static const Color searchBarShadow = Color(0x66000000);
  static const Color cardBackground = Color(0xFF505050);
  static const Color cardBorder = Color(0x0D000000);
  static Color appBarBackground = Colors.white.withAlpha(200);
}

class DeepBreathPaddings {
  static const double mainAxis = 16;
  static const EdgeInsets mainEndPadding = EdgeInsets.fromLTRB(0, 0, mainAxis, 0);
  static const EdgeInsets mainHorizontalPadding = EdgeInsets.symmetric(horizontal: mainAxis);
  static const EdgeInsets mainAllPadding = EdgeInsets.all(mainAxis);
  static const EdgeInsets dataPadding = EdgeInsets.fromLTRB(mainAxis, mainAxis / 2, mainAxis, mainAxis / 2);
  static const EdgeInsets searchBarOuterPadding = EdgeInsets.fromLTRB(mainAxis, 0, mainAxis, mainAxis);
  static const MaterialStatePropertyAll<EdgeInsets> searchBarInnerPadding =
  MaterialStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(horizontal: mainAxis)
  );
  static const EdgeInsets smallHorizontalPadding = EdgeInsets.symmetric(horizontal: mainAxis / 2);
  static const EdgeInsets smallBottomPadding = EdgeInsets.fromLTRB(0, 0, 0, mainAxis / 2);
}

class DeepBreathTextStyles {
  static const TextStyle title = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
  );
  static const TextStyle subtitle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle mediumHeader = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold
  );
  static const TextStyle smallHeader = TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.bold
  );
  static const TextStyle bigCaption = TextStyle(fontSize: 16);
  static const TextStyle mediumCaption = TextStyle(fontSize: 12);
}

class DeepBreathTextShapes {
  static const ShapeBorder cardBorder = RoundedRectangleBorder(
      side: BorderSide(width: 1, color: DeepBreathColors.cardBorder),
      borderRadius: BorderRadius.all(Radius.circular(12))
  );
}