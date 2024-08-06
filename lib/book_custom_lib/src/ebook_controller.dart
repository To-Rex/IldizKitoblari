import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EBookController extends ChangeNotifier {
  // shrift hajmi
  double fontSize = 18.0.sp;

  changFontSize(double fontSize) {
    this.fontSize = fontSize;
    notifyListeners();
  }
  
}
