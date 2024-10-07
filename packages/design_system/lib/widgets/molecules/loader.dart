import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? context.colors.secondary,
      ),
    );
  }
}
