import 'dart:math';

import 'package:easy_flu_widget/listview/extension/smart_list_view_extension.dart';
import 'package:easy_flu_widget/listview/smart_column_row.dart';
import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef ViewPortBuilder = void Function(int firstIndex, int lastIndex);

// class SmartListView extends ListView {
//   SmartListView(
//       {Key? key,
//       required IndexedWidgetBuilder itemBuilder,
//       required int itemCount,
//       double dividerThickness = 0,
//       Color dividerColor = Colors.transparent,
//       double? cacheExtent,
//       bool dividerEnd = false,
//       bool dividerStart = false,
//       Axis scrollDirection = Axis.vertical,
//       IndexedWidgetBuilder? separatorBuilder,
//       ScrollPhysics? physics,
//       bool shrinkWrap = false,
//       ScrollController? scrollController,
//       EdgeInsetsGeometry padding = EdgeInsets.zero,
//       bool reverse = false,
//       bool addAutomaticKeepAlives = true,
//       bool addRepaintBoundaries = true,
//       bool addSemanticIndexes = true,
//       int? semanticChildCount,
//       bool isSliver = false,
//       ItemExtentBuilder? itemExtentBuilder,
//       Widget? prototypeItem,
//       double? itemExtent,
//       ChildIndexGetter? findChildIndexCallback,
//       ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
//           ScrollViewKeyboardDismissBehavior.onDrag})
//       : super.builder(
//             key: key,
//             padding: padding,
//             reverse: reverse,
//             physics: physics,
//             findChildIndexCallback: findChildIndexCallback,
//             itemExtent: itemExtent,
//             prototypeItem: prototypeItem,
//             semanticChildCount: semanticChildCount,
//             itemExtentBuilder: itemExtentBuilder,
//             addAutomaticKeepAlives: addAutomaticKeepAlives,
//             addRepaintBoundaries: addRepaintBoundaries,
//             addSemanticIndexes: addSemanticIndexes,
//             itemCount: _getItemCount(
//                 itemCount,
//                 dividerThickness != 0 || separatorBuilder != null,
//                 dividerStart,
//                 dividerEnd),
//             itemBuilder: (context, index) {
//               {
//                 bool hasDivider =
//                     dividerThickness != 0 || separatorBuilder != null;
//                 if (hasDivider) {
//                   IndexedWidgetBuilder? realSeparatorBuilder = separatorBuilder;
//
//                   realSeparatorBuilder ??= (context, index) {
//                     if (scrollDirection == Axis.vertical) {
//                       return Divider(
//                         color: dividerColor,
//                         thickness: dividerThickness,
//                       );
//                     } else {
//                       return Container(
//                         width: dividerThickness,
//                         color: dividerColor,
//                       );
//                     }
//                   };
//
//                   if (dividerStart && !dividerEnd) {
//                     final int itemIndex = index ~/ 2;
//                     if (index.isOdd) {
//                       return itemBuilder(context, itemIndex);
//                     } else {
//                       return realSeparatorBuilder.call(context, itemIndex);
//                     }
//                   } else if (dividerStart && dividerEnd) {
//                     if (index == 0) {
//                       return realSeparatorBuilder.call(context, index);
//                     }
//                     final int itemIndex = index ~/ 2;
//                     if (index.isOdd) {
//                       return itemBuilder(context, itemIndex);
//                     } else {
//                       return realSeparatorBuilder.call(context, itemIndex);
//                     }
//                   } else {
//                     final int itemIndex = index ~/ 2;
//                     if (index.isEven) {
//                       return itemBuilder(context, itemIndex);
//                     } else {
//                       return realSeparatorBuilder.call(context, itemIndex);
//                     }
//                   }
//                 }
//                 return itemBuilder.call(context, index);
//               }
//             },
//             shrinkWrap: shrinkWrap,
//             scrollDirection: scrollDirection,
//             keyboardDismissBehavior: keyboardDismissBehavior,
//             controller: scrollController,
//             cacheExtent: cacheExtent);
//
//   static int _getItemCount(
//       int itemCount, bool hasDivider, bool dividerStart, bool dividerEnd) {
//     int realItemCount = itemCount;
//     if (itemCount == 0) {
//       return itemCount;
//     }
//     if (hasDivider) {
//       realItemCount = max<int>(0, itemCount * 2 - 1);
//     }
//
//     if (dividerStart) {
//       realItemCount = realItemCount + 1;
//     }
//
//     if (dividerEnd) {
//       realItemCount = realItemCount + 1;
//     }
//     return realItemCount;
//   }
// }

class SmartListView extends StatelessWidget {
  const SmartListView(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      this.dividerThickness = 0,
      this.dividerColor = Colors.transparent,
      this.cacheExtent,
      this.dividerEnd = false,
      this.dividerStart = false,
      this.scrollDirection = Axis.vertical,
      this.separatorBuilder,
      this.physics,
      this.shrinkWrap = false,
      this.scrollController,
      this.padding = EdgeInsets.zero,
      this.reverse = false,
      this.itemExtent,
      this.addAutomaticKeepAlives = true,
      this.addRepaintBoundaries = true,
      this.findChildIndexCallback,
      this.isSliver = false,
      this.useColumnRow = false,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag})
      : super(key: key);



  ///item渲染器
  final IndexedWidgetBuilder itemBuilder;

  ///数据个数
  final int itemCount;

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

  ///是否计算item尺寸
  final bool shrinkWrap;

  ///滑动控制器
  final ScrollController? scrollController;
  final EdgeInsetsGeometry padding;
  final bool reverse;
  final double? itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final ChildIndexGetter? findChildIndexCallback;
  final bool isSliver;
  final bool useColumnRow;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;


  @override
  Widget build(BuildContext context) {
    if(isSliver){
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return handleItemBuilder(index: index, context: context);
        },
            childCount: getItemCount(itemCount, dividerStart, dividerEnd),
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries),
      );
    }else{
      if(useColumnRow){
        return SmartColumnRow(itemBuilder: itemBuilder, itemCount: itemCount);
      }else{
        if(hasDivider()){
          return ListView.separated(
            reverse:reverse,
            physics: physics,
            controller: scrollController,
            itemBuilder: itemBuilder,
            cacheExtent: cacheExtent,
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection,
            separatorBuilder: getIndexedWidgetBuilder(),
            itemCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            keyboardDismissBehavior: keyboardDismissBehavior
          );
        }else{
          return ListView.builder(
              reverse:reverse,
              physics: physics,
              controller: scrollController,
              itemBuilder: itemBuilder,
              cacheExtent: cacheExtent,
              shrinkWrap: shrinkWrap,
              scrollDirection: scrollDirection,
              itemCount: itemCount,
              itemExtent: itemExtent,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              keyboardDismissBehavior: keyboardDismissBehavior
          );
        }
      }
    }
  }
}
