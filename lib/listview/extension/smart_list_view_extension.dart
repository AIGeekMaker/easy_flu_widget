import 'dart:math';
import 'package:easy_flu_widget/listview/smart_list_view.dart';
import 'package:flutter/material.dart';

extension SmartListViewExtension on SmartListView{

  IndexedWidgetBuilder getIndexedWidgetBuilder(){
    IndexedWidgetBuilder? realSeparatorBuilder = separatorBuilder;

    realSeparatorBuilder ??= (context, index) {
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

    return realSeparatorBuilder;
  }

  bool hasDivider(){
    return dividerThickness != 0 || separatorBuilder != null;
  }

  int getItemCount(
      int itemCount, bool dividerStart, bool dividerEnd) {
    int realItemCount = itemCount;
    if (itemCount == 0) {
      return itemCount;
    }
    if (hasDivider()) {
      realItemCount = max<int>(0, itemCount * 2 - 1);

      if (dividerStart) {
        realItemCount = realItemCount + 1;
      }

      if (dividerEnd) {
        realItemCount = realItemCount + 1;
      }
    }else{
      realItemCount = itemCount;
    }
    return realItemCount;
  }


  Widget handleItemBuilder({required int index, required BuildContext context}){

    if (hasDivider()) {
      IndexedWidgetBuilder? realSeparatorBuilder = getIndexedWidgetBuilder();


      if (dividerStart && !dividerEnd) {
        final int itemIndex = index ~/ 2;
        if (index.isOdd) {
          return itemBuilder(context, itemIndex);
        } else {
          return realSeparatorBuilder.call(context, itemIndex);
        }
      } else if (dividerStart && dividerEnd) {
        if (index == 0) {
          return realSeparatorBuilder.call(context, index);
        }
        final int itemIndex = index ~/ 2;
        if (index.isOdd) {
          return itemBuilder(context, itemIndex);
        } else {
          return realSeparatorBuilder.call(context, itemIndex);
        }
      } else {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          return itemBuilder(context, itemIndex);
        } else {
          return realSeparatorBuilder.call(context, itemIndex);
        }
      }
    }
    return itemBuilder.call(context, index);
  }
}