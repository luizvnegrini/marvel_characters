import 'package:flutter/material.dart';

import '../../design_system.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool showAppBar;

  const ScaffoldWidget({
    this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.showAppBar = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: showAppBar
            ? AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                title: Image.asset(
                  'assets/images/logo.webp',
                  package: 'design_system',
                  width: 100,
                ),
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
