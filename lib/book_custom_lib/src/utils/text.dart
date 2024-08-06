import 'package:flutter/material.dart';

class TextUtil {
  /// Matn balandligini oling
  static double calculateTextHeight(String value, double fontSize,
      {required double fontHeight, required double maxWidth, required EdgeInsetsGeometry padding}) {
    TextPainter painter = TextPainter(
        locale: WidgetsBinding.instance.window.locale,
        textDirection: TextDirection.ltr,
        maxLines: 1000,
        strutStyle: StrutStyle(forceStrutHeight: true, fontSize: fontSize, height: fontHeight),
        text: TextSpan(
          text: value,
          style: TextStyle(
            height: fontHeight,
            fontSize: fontSize,
          ),
        ),
        textAlign: TextAlign.center);
    painter.layout(maxWidth: maxWidth - padding.horizontal);
    return painter.size.height;
  }

  /// Bir qatordagi belgilarning maksimal sonini oling
  static int calculateTextMaxTextPos(
    String value,
    double fontSize, {
    required double fontHeight,
    required double maxWidth,
    required EdgeInsetsGeometry padding,
    int maxLines = 3,
  }) {
    final TextPainter painter = TextPainter(
      locale: WidgetsBinding.instance.window.locale,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      strutStyle: StrutStyle(
        forceStrutHeight: true,
        fontSize: fontSize,
        height: fontHeight,
      ),
      text: TextSpan(
        text: value,
        style: TextStyle(
          height: fontHeight,
          fontSize: fontSize,
        ),
      ),
      textAlign: TextAlign.center,
    );
    painter.layout(maxWidth: maxWidth - padding.horizontal);
    final didExceedMaxLines = painter.didExceedMaxLines;
    // print('$didExceedMaxLines maksimal satrdan oshib ketganmi');
    if (didExceedMaxLines) {
      final position = painter.getPositionForOffset(Offset(
        painter.width,
        painter.height,
      ));
      /// Agar keyingi sahifa paragraf boshidan boshlansa, birinchi qator uzilishi va boʻsh qator koʻrsatilishiga yoʻl qoʻymaslik uchun +2.
      if (value.substring(position.offset).startsWith('\n')) {
        return position.offset + 2;
      }
      return position.offset;
    }
    return 0;
  }
}
