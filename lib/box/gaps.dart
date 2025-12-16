import 'package:easy_flu_widget/utils/win_media.dart';
import 'package:flutter/cupertino.dart';

/// 间隔
class Gaps {
  /// 自定义垂直间隔
  static Widget getVertical(double height) {
    return SizedBox(
      height: getHeight(height),
    );
  }

  /// 自定义水平间隔
  static Widget getHorizontal(double width) {
    return SizedBox(
      width: getWidth(width),
    );
  }
}
