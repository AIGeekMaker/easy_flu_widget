import 'dart:async';

import 'package:easy_flu_widget/utils/win_media.dart';
import 'package:flutter/material.dart';

class SmartContainer extends StatefulWidget {
  const SmartContainer(
      {Key? key,
      this.visible = true,
      this.constraints,
      this.userClip = false,
      this.alignment,
      this.onTap,
      this.onLongPress,
      this.isCircle = false,
      this.borderWidth = 0,
      this.backgroundColor,
      this.child,
      this.padding = EdgeInsets.zero,
      this.borderColor = Colors.transparent,
      this.margin,
      this.borderRadius,
      this.height,
      this.width,
      this.behavior = HitTestBehavior.opaque,
      this.boxShadow,
      this.replacement = const SizedBox.shrink(),
      this.hasSizeWhenUnVisible = false,
      this.radius,
      this.verRadius,
      this.topRadius,
      this.topRightRadius,
      this.topLeftRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.bottomRadius,
      this.horRadius,
      this.leftRadius,
      this.rightRadius,
      this.image,
      this.useSafeArea = false,
      this.gradient,
      this.isSquare = false,
      this.border,
      this.debounceTapDuration})
      : super(key: key);

  ///圆角
  final BorderRadius? borderRadius;
  final double? radius;

  final double? verRadius;
  final double? topRadius;
  final double? bottomRadius;

  final double? horRadius;
  final double? leftRadius;
  final double? rightRadius;

  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;

  final Widget? child;
  final bool? visible;
  final BoxConstraints? constraints;
  final bool userClip;
  final AlignmentGeometry? alignment;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool isCircle;
  final double borderWidth;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final HitTestBehavior behavior;
  final List<BoxShadow>? boxShadow;
  final Widget replacement;
  final DecorationImage? image;
  final bool useSafeArea;
  final Gradient? gradient;
  final bool isSquare;
  final BoxBorder? border;
  final bool hasSizeWhenUnVisible;

  final Duration? debounceTapDuration;

  @override
  State<StatefulWidget> createState() => _SmartContainerState();
}

class _SmartContainerState extends State<SmartContainer> {
  bool _canClick = true;

  void handleTap(BuildContext context) {
    if (widget.debounceTapDuration != null) {
      if (_canClick) {
        _canClick = false;
        widget.onTap?.call();
        Timer(widget.debounceTapDuration!, () {
          _canClick = true;
        });
      }
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child ?? Container();
    Color? realBackgroundColor = widget.backgroundColor;

    if (widget.gradient != null && widget.backgroundColor == null) {
      realBackgroundColor = null;
    }

    ///设置圆角角度
    BorderRadiusGeometry mRadius = BorderRadius.zero;
    if (widget.borderRadius != null) {
      mRadius = widget.borderRadius!;
    } else {
      if (widget.radius != null) {
        mRadius = BorderRadiusDirectional.all(_getRadius(widget.radius));
      } else if (widget.verRadius != null) {
        mRadius = BorderRadiusDirectional.vertical(
            top: _getRadius(widget.verRadius),
            bottom: _getRadius(widget.verRadius));
      } else if (widget.topRadius != null || widget.bottomRadius != null) {
        mRadius = BorderRadiusDirectional.vertical(
            top: _getRadius(widget.topRadius),
            bottom: _getRadius(widget.bottomRadius));
      } else if (widget.horRadius != null) {
        mRadius = BorderRadiusDirectional.horizontal(
            start: _getRadius(widget.horRadius),
            end: _getRadius(widget.horRadius));
      } else if (widget.leftRadius != null || widget.rightRadius != null) {
        mRadius = BorderRadiusDirectional.horizontal(
            start: _getRadius(widget.leftRadius),
            end: _getRadius(widget.rightRadius));
      } else if (widget.topLeftRadius != null ||
          widget.topRightRadius != null ||
          widget.bottomLeftRadius != null ||
          widget.bottomRightRadius != null) {
        mRadius = BorderRadiusDirectional.only(
            topStart: _getRadius(widget.topLeftRadius),
            topEnd: _getRadius(widget.topRightRadius),
            bottomStart: _getRadius(widget.bottomLeftRadius),
            bottomEnd: _getRadius(widget.bottomRightRadius));
      }
    }

    double? realWidth;
    double? realHeight;

    if (widget.width != null) {
      realWidth = getWidth(widget.width!);
    }

    if (widget.height != null) {
      if (widget.isSquare) {
        realHeight = getWidth(widget.height!);
      } else {
        realHeight = getHeight(widget.height!);
      }
    }

    BoxBorder? border;

    if (widget.border != null) {
      border = widget.border;
    } else if (widget.borderWidth > 0) {
      border = Border.all(color: widget.borderColor, width: widget.borderWidth);
    }

    if (widget.userClip && !widget.isCircle) {
      child = ClipRRect(
        borderRadius: mRadius,
        child: Container(
          constraints: widget.constraints,
          width: realWidth,
          height: realHeight,
          padding: widget.padding,
          alignment: widget.alignment,
          decoration: BoxDecoration(
              gradient: widget.gradient,
              color: realBackgroundColor,
              border: border,
              boxShadow: widget.boxShadow),
          child: child,
        ),
      );
      if (widget.margin != null) {
        child = Container(
          margin: widget.margin,
          child: child,
        );
      }
    } else {
      child = Container(
        constraints: widget.constraints,
        width: realWidth,
        height: realHeight,
        margin: widget.margin,
        padding: widget.padding,
        alignment: widget.alignment,
        decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: widget.isCircle ? null : mRadius,
            color: realBackgroundColor,
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            border: border,
            boxShadow: widget.boxShadow,
            image: widget.image),
        child: child,
      );
    }

    child = GestureDetector(
      behavior: widget.onTap != null ? widget.behavior : null,
      onTap: widget.onTap != null
          ? () {
              handleTap(context);
            }
          : null,
      onLongPress: widget.onLongPress,
      child: child,
    );

    if (widget.visible != null) {
      child = Visibility(
        maintainSize: widget.hasSizeWhenUnVisible,
        maintainAnimation: widget.hasSizeWhenUnVisible,
        maintainState: widget.hasSizeWhenUnVisible,
        visible: widget.visible!,
        replacement: widget.replacement,
        child: child,
      );
    }

    if (widget.useSafeArea) {
      child = SafeArea(
        child: child,
      );
    }
    return child;
  }

  Radius _getRadius(double? radius) {
    if (radius != null) {
      return Radius.circular(getRadius(radius));
    } else {
      return Radius.zero;
    }
  }
}
