import 'package:flutter/material.dart';

class SmartScaffold extends StatelessWidget {

  const SmartScaffold({
    Key? key,
    required this.body,
    this.titleText = '',
    this.useAppBar = true,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.titleTextStyle,
    this.flexibleSpace,
    this.resizeToAvoidBottomInset,
    this.padding,
    this.leading,
    this.centerTitle,
    this.bottomNavigationBar,
    this.iconTheme,
    this.title,
    this.toolbarHeight,
    this.appBar,
    this.bottom
  }) : super(key: key);

  final Widget body;
  final Widget? title;
  final String titleText;
  final bool useAppBar;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final TextStyle? titleTextStyle;
  final Widget? flexibleSpace;
  final double? toolbarHeight;
  final bool? resizeToAvoidBottomInset;
  final EdgeInsets? padding;
  final Widget? leading;
  final bool? centerTitle;
  final Widget? bottomNavigationBar;
  final IconThemeData? iconTheme;
  final PreferredSizeWidget? appBar;
  final PreferredSizeWidget? bottom;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: useAppBar? (appBar ?? AppBar(
        title: title ?? Text(
            titleText
        ),
        flexibleSpace: flexibleSpace,
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
        titleTextStyle: titleTextStyle,
        toolbarHeight: toolbarHeight,
        leading: leading,
        centerTitle: centerTitle,
        iconTheme: iconTheme,
        bottom: bottom,
      )) : null,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: body,
      ),
    );
  }
}
