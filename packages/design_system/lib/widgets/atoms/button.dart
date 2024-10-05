import 'package:design_system/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../design_system.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final String label;
  final ButtonStyle buttonStyle;

  Button({
    required this.onPressed,
    required this.enabled,
    required this.label,
    super.key,
  }) : buttonStyle = ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return ThemeColors().primary;
            },
          ),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        );

  Button.light({
    required this.onPressed,
    required this.enabled,
    required this.label,
    super.key,
  }) : buttonStyle = ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.blueGrey;
              }
              return Colors.white;
            },
          ),
          elevation: const WidgetStatePropertyAll(0),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.white;
              }
              return ThemeColors().primary;
            },
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: ThemeColors().primary,
              width: 2,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: buttonStyle,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Work Sans',
            package: 'design_system',
            fontSize: kSpacingXXXS,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
