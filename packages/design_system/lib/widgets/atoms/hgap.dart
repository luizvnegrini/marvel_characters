import 'package:flutter/widgets.dart';

import '../../data/data.dart';

class HGap extends StatelessWidget {
  final double size;

  const HGap({required this.size, super.key});

  /// 4
  const HGap.quarck({super.key}) : size = kSpacingQuarck;

  /// 8
  const HGap.nano({super.key}) : size = kSpacingNano;

  /// 16
  const HGap.xxxs({super.key}) : size = kSpacingXXXS;

  /// 24
  const HGap.xxs({super.key}) : size = kSpacingXXS;

  /// 32
  const HGap.xs({super.key}) : size = kSpacingXS;

  /// 36
  const HGap.sm({super.key}) : size = kSpacingSM;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
