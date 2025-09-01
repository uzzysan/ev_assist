import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ev_assist/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

// Lightweight Radio group implementation to manage group value from an ancestor.
class RadioGroupScope<T> extends InheritedWidget {
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const RadioGroupScope({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  static RadioGroupScope<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RadioGroupScope<T>>();
  }

  @override
  bool updateShouldNotify(covariant RadioGroupScope<T> oldWidget) {
    return oldWidget.groupValue != groupValue;
  }
}

class RadioOption<T> extends StatelessWidget {
  final T value;
  final Widget title;
  final Widget? subtitle;

  const RadioOption({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final scope = RadioGroupScope.of<T>(context);
    final groupValue = scope?.groupValue;
    final onChanged = scope?.onChanged;

    final selected = groupValue == value;
    return ListTile(
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: title,
      subtitle: subtitle,
      onTap: () => onChanged?.call(value),
    );
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

  runApp(const EvAssistApp());
}

// --- APP ---

class EvAssistApp extends StatelessWidget {
  final Locale? locale;
  final ThemeMode? themeMode;

  const EvAssistApp({super.key, this.locale, this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
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
              Locale('da'), // Danish
              Locale('de'), // German
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('fi'), // Finnish
              Locale('fr'), // French
              Locale('no'), // Norwegian
              Locale('pl'), // Polish
              Locale('se'), // Swedish
            ],
            home: const SplashScreen(),
          );
        },
      ),
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
            itemBuilder: (BuildContext context) {
              final locales = AppLocalizations.supportedLocales;
              const names = {
                'da': 'Dansk',
                'de': 'Deutsch',
                'en': 'English',
                'es': 'Español',
                'fi': 'Suomi',
                'fr': 'Français',
                'no': 'Norsk',
                'pl': 'Polski',
                'se': 'Svenska',
              };
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

              return locales.map((loc) {
                final code = loc.languageCode;
                return PopupMenuItem<Locale>(
                  value: loc,
                  child: Row(
                    children: [
                      Image.asset(
                        flags[code] ?? 'assets/flags/gb.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (_, _, _) =>
                            const SizedBox(width: 24, height: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(names[code] ?? code),
                    ],
                  ),
                );
              }).toList();
            },
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
              // Logo na górze (teraz zależne od motywu)
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: TopLogo(), // Używamy naszego nowego widgetu!
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
              // RadioGroup for capacity selection (modern API)
              RadioGroupScope<CapacityType>(
                groupValue: _capacityType,
                onChanged: (CapacityType? v) => setState(() {
                  if (v != null) _capacityType = v;
                }),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioOption<CapacityType>(
                        value: CapacityType.net,
                        title: Text(l10n.net),
                      ),
                    ),
                    Expanded(
                      child: RadioOption<CapacityType>(
                        value: CapacityType.gross,
                        title: Text(l10n.gross),
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
              const SizedBox(height: 8), // Mały odstęp
              SizedBox(
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    TextButton(
                      onPressed: _launchSupportURL,
                      child: Text(
                        l10n.supportAuthorButton,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  },
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

void _launchSupportURL() async {
  final Uri url = Uri.parse('https://paypal.me/RMaculewicz');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nie można otworzyć linku: ${url.toString()}')),
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
            RadioGroupScope<ThemeMode>(
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? m) {
                if (m != null) themeProvider.setThemeMode(m);
              },
              child: Column(
                children: [
                  RadioOption<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text(l10n.light, style: GoogleFonts.montserrat()),
                  ),
                  RadioOption<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text(l10n.dark, style: GoogleFonts.montserrat()),
                  ),
                  RadioOption<ThemeMode>(
                    value: ThemeMode.system,
                    title: Text(l10n.system, style: GoogleFonts.montserrat()),
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

// --- Splash & TopLogo ---

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Uruchom nawigację do ekranu głównego po 2 sekundach
    Timer(const Duration(seconds: 2), _goToHome);
  }

  void _goToHome() {
    // Użyj pushReplacement, aby użytkownik nie mógł wrócić do ekranu powitalnego
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final image = isDark
        ? 'assets/welcome_dark.png'
        : 'assets/welcome_bright.png';

    // Logowanie do konsoli w celu debugowania
    debugPrint(
      'SplashScreen: Używany motyw to $brightness, ładowany obraz to $image',
    );

    return Scaffold(
      // Ustawienie tła w zależności od motywu
      backgroundColor: isDark
          ? const Color.fromRGBO(45, 48, 51, 1)
          : Colors.white,
      body: Center(
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          // Zabezpieczenie przed błędem, gdyby plik nie istniał
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Błąd ładowania obrazu w SplashScreen: $error');
            return const SizedBox.shrink(); // Pokaż pusty widget w razie błędu
          },
        ),
      ),
    );
  }
}

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final asset = isDark ? 'assets/logo_dark.png' : 'assets/logo_bright.png';

    // Logowanie do konsoli w celu debugowania
    debugPrint(
      'TopLogo: Używany motyw to $brightness, ładowany asset to $asset',
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double logoWidth = constraints.maxWidth * 0.7;
          return Image.asset(
            asset,
            width: logoWidth,
            fit: BoxFit.contain,
            // Zabezpieczenie przed błędem, gdyby plik nie istniał
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Błąd ładowania obrazu w TopLogo: $error');
              return const SizedBox.shrink(); // Pokaż pusty widget w razie błędu
            },
          );
        },
      ),
    );
  }
}
