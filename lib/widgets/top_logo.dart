import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final asset = isDark ? 'assets/logo_dark.png' : 'assets/logo_bright.png';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading logo: $error');
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
