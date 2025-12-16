import 'dart:math' as math;

import 'package:flutter/material.dart';

class SmartColumnRow extends StatelessWidget {
  const SmartColumnRow(
      {Key? key,

      ///item渲染器
      required this.itemBuilder,

      ///数据个数
      required this.itemCount,

      ///分割线高度
      this.dividerThickness = 0,

      ///分割线颜色
      this.dividerColor = Colors.transparent,

      ///缓存高度
      this.cacheExtent,

      ///是否包含开头分割线
      this.dividerEnd = false,

      ///是否包含结尾分割线
      this.dividerStart = false,

      ///滑动方向
      this.scrollDirection = Axis.vertical,

      ///分割线渲染器
      this.separatorBuilder,

      ///滑动模式
      this.physics,
      this.scrollController,
      this.itemExtent})
      : super(key: key);

  final double? itemExtent;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  ///分割线高度
  final double dividerThickness;

  ///分割线颜色
  final Color dividerColor;

  ///缓存高度
  final double? cacheExtent;

  ///是否包含开头分割线
  final bool dividerEnd;

  ///是否包含结尾分割线
  final bool dividerStart;

  ///滑动方向
  final Axis scrollDirection;

  ///分割线渲染器
  final IndexedWidgetBuilder? separatorBuilder;

  ///滑动模式
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  bool _hasDivider(
      {double dividerThickness = 0, IndexedWidgetBuilder? separatorBuilder}) {
    return dividerThickness != 0 || separatorBuilder != null;
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return Container();
    }
    int realItemCount = itemCount;
    bool hasDivider = _hasDivider(
        dividerThickness: dividerThickness, separatorBuilder: separatorBuilder);

    if (hasDivider) {
      realItemCount = math.max<int>(0, itemCount * 2 - 1);

      if (dividerStart) {
        realItemCount = realItemCount + 1;
      }

      if (dividerEnd) {
        realItemCount = realItemCount + 1;
      }
    }

    IndexedWidgetBuilder? realSeparatorBuilder = separatorBuilder;

    if (hasDivider && realSeparatorBuilder == null) {
      realSeparatorBuilder = (context, index) {
        if (scrollDirection == Axis.vertical) {
          return Divider(
            color: dividerColor,
            thickness: dividerThickness,
          );
        } else {
          return Container(
            width: dividerThickness,
            color: dividerColor,
          );
        }
      };
    }

    Widget child = Container();

    if (scrollDirection == Axis.horizontal) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            realItemCount,
            (index) => _buildItem(
                index: index,
                context: context,
                hasDivider: hasDivider,
                separatorBuilder: realSeparatorBuilder)),
      );
      if (physics.runtimeType != NeverScrollableScrollPhysics) {
        child = SingleChildScrollView(
          controller: scrollController,
          scrollDirection: scrollDirection,
          child: child,
        );
      }
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            realItemCount,
            (index) => _buildItem(
                index: index,
                context: context,
                hasDivider: hasDivider,
                separatorBuilder: realSeparatorBuilder)),
      );
      if (physics.runtimeType != NeverScrollableScrollPhysics) {
        child = SingleChildScrollView(
          controller: scrollController,
          scrollDirection: scrollDirection,
          child: child,
        );
      }
    }

    return child;
  }

  Widget _buildItem(
      {required BuildContext context,
      required int index,
      required bool hasDivider,
      IndexedWidgetBuilder? separatorBuilder}) {
    if (hasDivider) {
      if (dividerStart && !dividerEnd) {
        final int itemIndex = index ~/ 2;
        if (index.isOdd) {
          return itemBuilder(context, itemIndex);
        } else {
          return separatorBuilder!.call(context, itemIndex);
        }
      } else if (dividerStart && dividerEnd) {
        if (index == 0) {
          return separatorBuilder!.call(context, index);
        }
        final int itemIndex = index ~/ 2;
        if (index.isOdd) {
          return itemBuilder(context, itemIndex);
        } else {
          return separatorBuilder!.call(context, itemIndex);
        }
      } else {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          return itemBuilder(context, itemIndex);
        } else {
          return separatorBuilder!.call(context, itemIndex);
        }
      }
    } else {
      return itemBuilder(context, index);
    }
  }
}
