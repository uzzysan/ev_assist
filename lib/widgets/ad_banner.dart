import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob configuration based on build mode (debug/release)
class AdMobConfig {
  // Test AdMob IDs for development
  static const String _testAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const String _testBannerId = 'ca-app-pub-3940256099942544/6300978111';

  // Production AdMob IDs
  static const String _prodAppId = 'ca-app-pub-3287491879097224~2214382527';
  static const String _prodBannerId = 'ca-app-pub-3287491879097224/8588219186';

  /// Returns appropriate AdMob App ID based on build mode
  static String get appId => kDebugMode ? _testAppId : _prodAppId;

  /// Returns appropriate AdMob Banner ID based on build mode
  static String get bannerId => kDebugMode ? _testBannerId : _prodBannerId;

  /// Returns true if we're using test ads
  static bool get isTestMode => kDebugMode;
}

class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        const bool.fromEnvironment('FLUTTER_TEST') || 
        const bool.fromEnvironment('IS_TEST') ||
        (!kIsWeb && kDebugMode && Platform.environment.containsKey('FLUTTER_TEST'))) {
      return const SizedBox.shrink();
    }
    return const _AdBannerWidgetImpl();
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
      adUnitId: AdMobConfig.bannerId,
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
