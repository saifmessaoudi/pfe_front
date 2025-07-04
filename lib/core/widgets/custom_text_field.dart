import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

  class CustomTextField extends StatelessWidget {
    final String? label;
    final String? hint;
    final TextEditingController? controller;
    final TextInputType keyboardType;
    final bool obscureText;
    final String? Function(String?)? validator;
    final void Function(String)? onChanged;
    final void Function(String)? onSubmitted;
    final Widget? prefixIcon;
    final Widget? suffixIcon;
    final bool readOnly;
    final bool autofocus;
    final int? maxLines;
    final int? minLines;
    final List<TextInputFormatter>? inputFormatters;
    final FocusNode? focusNode;
    final TextCapitalization textCapitalization;
    final EdgeInsetsGeometry? contentPadding;
    final TextInputAction? textInputAction;
    final bool enabled;

    const CustomTextField({
      super.key,
      this.label,
      this.hint,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.onChanged,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      this.autofocus = false,
      this.maxLines = 1,
      this.minLines,
      this.inputFormatters,
      this.focusNode,
      this.textCapitalization = TextCapitalization.none,
      this.contentPadding,
      this.textInputAction,
      this.enabled = true,
    });

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);

      return TextFormField(
       cursorColor: Color (0xFFEBAC1D),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        readOnly: readOnly,
        autofocus: autofocus,
        maxLines: maxLines,
        minLines: minLines,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        enabled: enabled,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          labelText: label,
          hintText: hint,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5), width: 0.7),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEBAC1D), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
  }
