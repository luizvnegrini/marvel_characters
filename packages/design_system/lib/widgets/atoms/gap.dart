import 'package:flutter/widgets.dart';

import '../../data/data.dart';

class VGap extends StatelessWidget {
  final double size;

  const VGap({required this.size, super.key});
  const VGap.quarck({super.key}) : size = kSpacingQuarck;
  const VGap.nano({super.key}) : size = kSpacingNano;
  const VGap.xxxs({super.key}) : size = kSpacingXXXS;
  const VGap.xxs({super.key}) : size = kSpacingXXS;
  const VGap.xs({super.key}) : size = kSpacingXS;
  const VGap.sm({super.key}) : size = kSpacingSM;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
