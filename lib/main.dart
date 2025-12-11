import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:ev_assist/l10n/app_localizations.dart';
import 'package:ev_assist/screens/home_screen.dart';
import 'package:ev_assist/screens/splash_screen.dart';
import 'package:ev_assist/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

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
  
  // Initialize MobileAds only if not on web, or handle web separately if supported
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }

  // ATT request for iOS 14+
  if (!kIsWeb && Platform.isIOS) {
    AppTrackingTransparency.requestTrackingAuthorization();
  }

  runApp(const EvAssistApp());
}

// --- APP ---

class EvAssistApp extends StatelessWidget {
  final Locale? locale;
  final ThemeMode? themeMode;
  final bool skipSplash;

  const EvAssistApp({
    super.key,
    this.locale,
    this.themeMode,
    this.skipSplash = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final provider = ThemeProvider();
          if (themeMode != null) {
            provider.setThemeMode(themeMode!);
          }
          return provider;
        }),
        ChangeNotifierProvider(create: (_) {
          final provider = LocaleProvider();
          if (locale != null) {
            provider.setLocale(locale!);
          }
          return provider;
        }),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          final effectiveTheme = themeMode ?? themeProvider.themeMode;
          final effectiveLocale = locale ?? localeProvider.locale;

          return MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: effectiveTheme,
            locale: effectiveLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('da'),
              Locale('de'),
              Locale('en'),
              Locale('es'),
              Locale('fi'),
              Locale('fr'),
              Locale('no'),
              Locale('pl'),
              Locale('se'),
            ],
            home: skipSplash ? const HomeScreen() : const SplashScreen(),
          );
        },
      ),
    );
  }
}
