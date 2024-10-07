import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.onFieldSubmitted,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      onChanged: (value) => onChanged?.call(value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Icon(Icons.search),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
        ),
      ),
      onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    );
  }
}
