import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? suffix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.suffix,
    this.validator,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: '0',
            suffixText: suffix,
            suffixStyle: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (double.tryParse(value) == null) {
              return 'Invalid number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
