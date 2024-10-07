import 'package:flutter/material.dart';

import '../../design_system.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final bool showAppBar;
  final EdgeInsetsGeometry? padding;

  const ScaffoldWidget({
    this.body,
    this.backgroundColor,
    this.showAppBar = true,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: showAppBar
            ? AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Image.asset(
                  'assets/images/logo.webp',
                  package: 'design_system',
                  width: 100,
                ),
              )
            : null,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(kSpacingXXXS),
            child: body,
          ),
        ),
      );
}
