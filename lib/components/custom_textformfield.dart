import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class CustomTextFormField extends StatelessWidget {
  final bool? obscure;
  final void Function(String?)? onSubmitted;
  final TextEditingController input;
  final String hint;
  final String? Function(String?) validator;

  const CustomTextFormField({
    required this.input,
    required this.hint,
    required this.validator,
    this.onSubmitted,
    this.obscure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onSubmitted,
      obscureText: (obscure == null) ? false : obscure!,
      controller: input,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2.0), // default underline thickness
        ),
        hintText: hint,
        hintStyle: ThemeText.hintStyle1,
      ),
    );
  }
}
