import 'package:easy_flu_widget/box/smart_container.dart';
import 'package:easy_flu_widget/utils/win_media.dart';
import 'package:flutter/material.dart';

class SmartText extends StatelessWidget {
  const SmartText(
      {Key? key,
      this.text,
      this.textStyle,
      this.strutStyle,
      this.maxLines,
      this.fontSize,
      this.color,
      this.hideIfEmpty = false,
      this.margin,
      this.textAlign,
      this.fontWeight,
      this.overflow,
      this.padding,
      this.onTap,
      this.height,
      this.fontFamily})
      : super(key: key);

  final String? text;
  final TextStyle? textStyle;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  final bool hideIfEmpty;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final GestureTapCallback? onTap;
  final double? height;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = this.textStyle;
    String realText = text ?? '';
    if (overflow == TextOverflow.ellipsis && maxLines == 1) {
      realText = _breakWord(realText);
    }

    if (textStyle == null) {
      // 获取主题样式
      textStyle = Theme.of(context).textTheme.bodyMedium;
      textStyle = textStyle ?? Theme.of(context).textTheme.bodySmall;

      // 如果主题样式还是null，创建基础样式（通常不会发生）
      textStyle = textStyle ?? const TextStyle();

      // 只覆盖用户明确传入的属性，保持主题属性
      textStyle = textStyle.copyWith(
        fontSize: fontSize != null ? getSp(fontSize!) : null,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );
    } else {
      // 用户传入了textStyle，合并用户参数
      double? finalFontSize;
      if (fontSize != null) {
        finalFontSize = getSp(fontSize!);
      } else if (textStyle.fontSize != null) {
        finalFontSize = getSp(textStyle.fontSize!);
      }

      textStyle = textStyle.copyWith(
        color: color ?? textStyle.color,
        fontSize: finalFontSize,
        fontWeight: fontWeight ?? textStyle.fontWeight,
        height: height ?? textStyle.height,
        fontFamily: fontFamily ?? textStyle.fontFamily,
      );
    }

    Widget child = Text(
      realText,
      style: textStyle,
      strutStyle: strutStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
    if (onTap != null || margin != null || hideIfEmpty || padding != null) {
      child = SmartContainer(
        margin: margin,
        padding: padding,
        onTap: onTap,
        visible: hideIfEmpty ? (text != null && text!.isNotEmpty) : true,
        child: child,
      );
    }
    return child;
  }

  ///正确截断字符
  String _breakWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = '';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}
