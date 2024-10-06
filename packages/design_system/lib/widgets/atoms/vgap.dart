import 'package:flutter/widgets.dart';

import '../../data/data.dart';

class VGap extends StatelessWidget {
  final double size;

  const VGap({required this.size, super.key});

  /// 4
  const VGap.quarck({super.key}) : size = kSpacingQuarck;

  /// 8
  const VGap.nano({super.key}) : size = kSpacingNano;

  /// 16
  const VGap.xxxs({super.key}) : size = kSpacingXXXS;

  /// 24
  const VGap.xxs({super.key}) : size = kSpacingXXS;

  /// 32
  const VGap.xs({super.key}) : size = kSpacingXS;

  /// 36
  const VGap.sm({super.key}) : size = kSpacingSM;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
