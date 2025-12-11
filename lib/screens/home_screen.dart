import 'package:ev_assist/l10n/app_localizations.dart';
import 'package:ev_assist/main.dart'; // For Providers
import 'package:ev_assist/screens/settings_screen.dart';
import 'package:ev_assist/widgets/ad_banner.dart';
import 'package:ev_assist/widgets/custom_button.dart';
import 'package:ev_assist/widgets/custom_input.dart';
import 'package:ev_assist/widgets/custom_radio.dart';
import 'package:ev_assist/widgets/section_card.dart';
import 'package:ev_assist/widgets/status_card.dart';
import 'package:ev_assist/widgets/top_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum CapacityType { net, gross }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _avgConsumptionController = TextEditingController();
  final _avgConsumptionDistanceController = TextEditingController(text: '100');
  final _destinationDistanceController = TextEditingController();
  final _totalCapacityController = TextEditingController();
  final _currentLevelController = TextEditingController();
  final _desiredLevelController = TextEditingController();

  CapacityType _capacityType = CapacityType.net;

  // Result State
  String? _resultTitle;
  String? _resultMessage;
  StatusType? _resultStatus;

  // Calculation Logic
  void _calculate() {
    FocusScope.of(context).unfocus(); // Close keyboard
    
    if (_formKey.currentState!.validate()) {
      try {
        final double avgConsumption = double.parse(_avgConsumptionController.text);
        final double avgConsumptionDistance = double.parse(_avgConsumptionDistanceController.text);
        final double destinationDistance = double.parse(_destinationDistanceController.text);
        final double totalCapacity = double.parse(_totalCapacityController.text);
        final double currentLevel = double.parse(_currentLevelController.text);
        final double desiredLevel = double.parse(_desiredLevelController.text);

        final double cap = _capacityType == CapacityType.gross
            ? totalCapacity - 4.0
            : totalCapacity;
        final double curr = cap * (currentLevel / 100.0);
        final double avg = (avgConsumptionDistance == 100.0)
            ? avgConsumption
            : (avgConsumption * 100.0) / avgConsumptionDistance;
        final double dest = destinationDistance / 100.0;
        final double res = cap * (desiredLevel / 100.0);
        final double chrg = (((avg * dest) + res) - curr) + (avg * 0.2);

        final l10n = AppLocalizations.of(context)!;
        
        setState(() {
          if (chrg > cap) {
            _resultTitle = l10n.warningTitle;
            _resultMessage = l10n.errorMessage(chrg.toStringAsFixed(2));
            _resultStatus = StatusType.warning;
          } else if (chrg + curr > cap) {
            _resultTitle = l10n.warningTitle;
            _resultMessage = l10n.destinationOutOfReach;
             _resultStatus = StatusType.warning;
          } else {
            _resultTitle = l10n.resultTitle;
            _resultMessage = l10n.chargeMessage(chrg.toStringAsFixed(2));
            _resultStatus = StatusType.success;
          }
        });
      } catch (e) {
        // Handle parsing errors gracefully
      }
    }
  }

  void _showSupportOptions() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.supportAuthorButton,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'PayPal',
              icon: Icons.payment,
              onPressed: () {
                Navigator.pop(context);
                _launchSupportURL('https://paypal.me/RMaculewicz');
              },
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              text: 'Buy me a coffee',
              icon: Icons.coffee,
              onPressed: () {
                Navigator.pop(context);
                _launchSupportURL('https://buycoffee.to/uzzy');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _launchSupportURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open link: $urlString')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) => localeProvider.setLocale(locale),
            itemBuilder: (context) {
              const flags = {
                'da': 'assets/flags/dk.png',
                'de': 'assets/flags/de.png',
                'en': 'assets/flags/gb.png',
                'es': 'assets/flags/es.png',
                'fi': 'assets/flags/fi.png',
                'fr': 'assets/flags/fr.png',
                'no': 'assets/flags/no.png',
                'pl': 'assets/flags/pl.png',
                'se': 'assets/flags/se.png',
              };
              return AppLocalizations.supportedLocales.map((loc) {
                return PopupMenuItem(
                  value: loc,
                  child: Row(
                    children: [
                       Image.asset(
                        flags[loc.languageCode] ?? 'assets/flags/gb.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(loc.languageCode.toUpperCase()),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const TopLogo(),
                    const SizedBox(height: 24),
                    
                    // Consumption
                    SectionCard(
                      title: l10n.averageConsumption,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _avgConsumptionController,
                              label: l10n.consumptionHint,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _avgConsumptionDistanceController,
                              label: l10n.distanceHint,
                              suffix: 'km',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
        
                    // Destination & Capacity
                    SectionCard(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _destinationDistanceController,
                            label: l10n.destinationDistanceHint,
                            suffix: 'km',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _totalCapacityController,
                            label: l10n.totalBatteryCapacity,
                            suffix: 'kWh',
                          ),
                          const SizedBox(height: 16),
                          CustomRadioGroup<CapacityType>(
                            groupValue: _capacityType,
                            onChanged: (v) => setState(() => _capacityType = v!),
                            options: [
                              CustomRadioOption(value: CapacityType.net, label: l10n.net),
                              CustomRadioOption(value: CapacityType.gross, label: l10n.gross),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
        
                    // Battery Levels
                    SectionCard(
                      title: 'Battery Levels',
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _currentLevelController,
                              label: l10n.currentBatteryLevel,
                              suffix: '%',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _desiredLevelController,
                              label: l10n.desiredArrivalLevel,
                              suffix: '%',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
        
                    // Actions & Result
                    if (_resultMessage != null) ...[
                      StatusCard(
                        type: _resultStatus!,
                        title: _resultTitle!,
                        content: _resultMessage!,
                        onDismiss: () => setState(() => _resultMessage = null),
                      ),
                      const SizedBox(height: 16),
                    ],
        
                    PrimaryButton(
                      text: l10n.calculate,
                      icon: Icons.calculate_outlined,
                      onPressed: _calculate,
                    ),
                    const SizedBox(height: 16),
                    SecondaryButton(
                      text: l10n.supportAuthorButton,
                      icon: Icons.favorite_border,
                      onPressed: _showSupportOptions,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AdBannerWidget(),
        ],
      ),
    );
  }
}
