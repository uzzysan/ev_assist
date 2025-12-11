import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum StatusType { info, success, warning }

class StatusCard extends StatelessWidget {
  final StatusType type;
  final String title;
  final String content;
  final VoidCallback? onDismiss;

  const StatusCard({
    super.key,
    required this.type,
    required this.title,
    required this.content,
    this.onDismiss,
  });

  Color _getBackgroundColor(BuildContext context, bool isDark) {
    if (isDark) {
      switch (type) {
        case StatusType.info:
          return const Color(0xFF0C4A6E).withOpacity(0.5); // Sky-900
        case StatusType.success:
          return const Color(0xFF064E3B).withOpacity(0.5); // Emerald-900
        case StatusType.warning:
          return const Color(0xFF451A03).withOpacity(0.5); // Amber/Orange-900 derivative
      }
    } else {
      switch (type) {
        case StatusType.info:
          return const Color(0xFFE0F2FE); // Sky-100
        case StatusType.success:
          return const Color(0xFFD1FAE5); // Emerald-100
        case StatusType.warning:
          return const Color(0xFFFEF3C7); // Amber-100
      }
    }
  }

  Color _getBorderColor(BuildContext context, bool isDark) {
    if (isDark) {
      switch (type) {
        case StatusType.info:
          return const Color(0xFF0EA5E9); // Sky-500
        case StatusType.success:
          return const Color(0xFF10B981); // Emerald-500
        case StatusType.warning:
          return const Color(0xFFF59E0B); // Amber-500
      }
    } else {
      switch (type) {
        case StatusType.info:
          return const Color(0xFFBAE6FD); // Sky-200
        case StatusType.success:
          return const Color(0xFFA7F3D0); // Emerald-200
        case StatusType.warning:
          return const Color(0xFFFDE68A); // Amber-200
      }
    }
  }

  Color _getTextColor(BuildContext context, bool isDark) {
    if (isDark) return Colors.white;
    switch (type) {
      case StatusType.info:
        return const Color(0xFF0369A1); // Sky-700
      case StatusType.success:
        return const Color(0xFF047857); // Emerald-700
      case StatusType.warning:
        return const Color(0xFFB45309); // Amber-700
    }
  }

  IconData _getIcon() {
    switch (type) {
      case StatusType.info:
        return Icons.info_outline_rounded;
      case StatusType.success:
        return Icons.check_circle_outline_rounded;
      case StatusType.warning:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = _getBackgroundColor(context, isDark);
    final borderColor = _getBorderColor(context, isDark);
    final textColor = _getTextColor(context, isDark);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_getIcon(), color: textColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const Spacer(),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(Icons.close, size: 18, color: textColor.withOpacity(0.7)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: textColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
