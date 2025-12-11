import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    this.title,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title!,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: Theme.of(context).cardTheme.shape is RoundedRectangleBorder
                ? (Theme.of(context).cardTheme.shape as RoundedRectangleBorder).borderRadius
                : BorderRadius.circular(20),
            border: Theme.of(context).cardTheme.shape is RoundedRectangleBorder
               ? Border.fromBorderSide((Theme.of(context).cardTheme.shape as RoundedRectangleBorder).side)
               : null,
             boxShadow: Theme.of(context).cardTheme.elevation != null && Theme.of(context).cardTheme.elevation! > 0
                ? [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}
