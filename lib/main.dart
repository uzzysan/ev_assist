import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ev_assist/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

// --- AD BANNER WIDGET ---
class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // W testach widgetowych zwracaj pusty widget
    if (const bool.fromEnvironment('FLUTTER_TEST')) {
      return const SizedBox.shrink();
    }
    // ...normalny kod reklamy...
    return _AdBannerWidgetImpl();
  }
}

class _AdBannerWidgetImpl extends StatefulWidget {
  const _AdBannerWidgetImpl();

  @override
  State<_AdBannerWidgetImpl> createState() => _AdBannerWidgetImplState();
}

class _AdBannerWidgetImplState extends State<_AdBannerWidgetImpl> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3287491879097224/8588219186',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded) {
      return SizedBox(
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

// --- CUSTOM WIDGETS ---

class RadioGroup<T> extends StatelessWidget {
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

// --- PROVIDERS ---

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

// --- MAIN ---

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // ATT request for iOS 14+
  if (Platform.isIOS) {
    AppTrackingTransparency.requestTrackingAuthorization();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const EvAssistApp(),
    ),
  );
}

// --- APP ---

class EvAssistApp extends StatelessWidget {
  const EvAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pl'), // Polish
      ],
      home: const HomeScreen(),
    );
  }
}

// --- SCREENS ---

enum CapacityType { net, gross }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _avgConsumptionController = TextEditingController();
  final _avgConsumptionDistanceController = TextEditingController(text: '100');
  final _destinationDistanceController = TextEditingController();
  final _totalCapacityController = TextEditingController();
  final _currentLevelController = TextEditingController();
  final _desiredLevelController = TextEditingController();

  CapacityType _capacityType = CapacityType.net;

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      // Parse values
      final double avgConsumption = double.parse(
        _avgConsumptionController.text,
      );
      final double avgConsumptionDistance = double.parse(
        _avgConsumptionDistanceController.text,
      );
      final double destinationDistance = double.parse(
        _destinationDistanceController.text,
      );
      final double totalCapacity = double.parse(_totalCapacityController.text);
      final double currentLevel = double.parse(_currentLevelController.text);
      final double desiredLevel = double.parse(_desiredLevelController.text);

      // --- Calculation Logic ---
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
      // --- Display Result ---
      if (chrg > cap) {
        _showResultDialog(
          title: l10n.warningTitle,
          content: l10n.errorMessage(chrg.toStringAsFixed(2)),
        );
      } else {
        _showResultDialog(
          title: l10n.resultTitle,
          content: l10n.chargeMessage(chrg.toStringAsFixed(2)),
        );
      }
    }
  }

  void _showResultDialog({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              localeProvider.setLocale(locale);
            },
            icon: const Icon(Icons.language),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('pl'),
                child: Text('Polski'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo na górze
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double logoWidth = constraints.maxWidth * 0.7;
                        return Image.asset(
                          'assets/logo.png',
                          width: logoWidth,
                          fit: BoxFit
                              .contain, // zachowuje proporcje, wysokość automatyczna
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildSectionTitle(l10n.averageConsumption),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _avgConsumptionController,
                      label: l10n.consumptionHint,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      controller: _avgConsumptionDistanceController,
                      label: l10n.distanceHint,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(l10n.destinationDistanceHint),
              _buildTextField(
                controller: _destinationDistanceController,
                label: l10n.destinationDistanceHint,
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(l10n.totalBatteryCapacity),
              _buildTextField(
                controller: _totalCapacityController,
                label: l10n.capacityHint,
              ),
              // Naprawiony RadioGroup
              RadioGroup<CapacityType>(
                groupValue: _capacityType,
                onChanged: (CapacityType? value) {
                  setState(() {
                    _capacityType = value!;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<CapacityType>(
                        title: Text(l10n.net),
                        value: CapacityType.net,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<CapacityType>(
                        title: Text(l10n.gross),
                        value: CapacityType.gross,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(l10n.currentBatteryLevel),
              _buildTextField(
                controller: _currentLevelController,
                label: l10n.levelHint,
                suffix: '%',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(l10n.desiredArrivalLevel),
              _buildTextField(
                controller: _desiredLevelController,
                label: l10n.levelHint,
                suffix: '%',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(l10n.calculate, style: GoogleFonts.montserrat()),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 50,
        child: const AdBannerWidget(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? suffix,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

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
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.theme,
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioGroup<ThemeMode>(
              groupValue: themeProvider.themeMode,
              onChanged: (mode) => themeProvider.setThemeMode(mode!),
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.light, style: GoogleFonts.montserrat()),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.dark, style: GoogleFonts.montserrat()),
                    value: ThemeMode.dark,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.system, style: GoogleFonts.montserrat()),
                    value: ThemeMode.system,
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
