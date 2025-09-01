// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Assistant de recharge EV';

  @override
  String get calculate => 'Calculer';

  @override
  String get averageConsumption => 'Consommation moyenne';

  @override
  String get distance => 'Distance';

  @override
  String get km => 'km';

  @override
  String get miles => 'miles';

  @override
  String get totalBatteryCapacity => 'Capacité totale de la batterie';

  @override
  String get net => 'Net';

  @override
  String get gross => 'Brut';

  @override
  String get currentBatteryLevel => 'Niveau actuel de la batterie';

  @override
  String get desiredArrivalLevel => 'Niveau attendu à l\'arrivée';

  @override
  String get resultTitle => 'Résultat';

  @override
  String get warningTitle => 'Avertissement';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'Pour atteindre votre destination avec la réserve supposée, vous devez charger $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Il n\'est pas possible d\'atteindre la destination avec les paramètres donnés. L\'énergie requise ($chargeAmount kWh) dépasse la capacité de la batterie.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Paramètres';

  @override
  String get theme => 'Thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get language => 'Langue';

  @override
  String get consumptionHint => 'kWh/100km ou miles';

  @override
  String get distanceHint => 'pour quelle distance';

  @override
  String get destinationDistanceHint => 'distance jusqu\'à la prochaine destination';

  @override
  String get capacityHint => 'capacité de la batterie';

  @override
  String get levelHint => 'niveau de charge %';

  @override
  String get supportAuthorButton => 'Soutenir l\'auteur';
}
