import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final List<CustomRadioOption<T>> options;

  const CustomRadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final isSelected = groupValue == option.value;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(option.value),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).disabledColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    option.label,
                    style: GoogleFonts.inter(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CustomRadioOption<T> {
  final T value;
  final String label;

  CustomRadioOption({required this.value, required this.label});
}
