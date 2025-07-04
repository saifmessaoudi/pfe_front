import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: textColor ?? theme.colorScheme.onPrimary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: theme.colorScheme.onPrimary.withOpacity(0.6),
        ),
        child: isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: textColor ?? theme.colorScheme.onPrimary,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textColor ?? theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
