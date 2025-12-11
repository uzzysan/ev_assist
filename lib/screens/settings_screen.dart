import 'package:ev_assist/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ev_assist/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.theme,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                   _ThemeOption(
                    title: l10n.light,
                    value: ThemeMode.light,
                    groupValue: themeProvider.themeMode,
                    icon: Icons.light_mode_outlined,
                    onChanged: (v) => themeProvider.setThemeMode(v!),
                  ),
                  const Divider(height: 1),
                  _ThemeOption(
                    title: l10n.dark,
                    value: ThemeMode.dark,
                    groupValue: themeProvider.themeMode,
                    icon: Icons.dark_mode_outlined,
                    onChanged: (v) => themeProvider.setThemeMode(v!),
                  ),
                  const Divider(height: 1),
                  _ThemeOption(
                    title: l10n.system,
                    value: ThemeMode.system,
                    groupValue: themeProvider.themeMode,
                    icon: Icons.settings_system_daydream_outlined,
                    onChanged: (v) => themeProvider.setThemeMode(v!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final ThemeMode value;
  final ThemeMode groupValue;
  final ValueChanged<ThemeMode?> onChanged;
  final IconData icon;

  const _ThemeOption({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
        ],
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
