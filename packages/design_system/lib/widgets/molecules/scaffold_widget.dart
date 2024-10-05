import 'package:flutter/material.dart';

import '../../design_system.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool showAppBar;
  final Text? title;

  const ScaffoldWidget({
    this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.showAppBar = true,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: showAppBar
            ? AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: title,
              )
            : null,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kSpacingXXXS),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      );
}
