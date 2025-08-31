// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'EV Ladeassistent';

  @override
  String get calculate => 'Berechnen';

  @override
  String get averageConsumption => 'Durchschnittlicher Verbrauch';

  @override
  String get distance => 'Entfernung';

  @override
  String get km => 'km';

  @override
  String get miles => 'Meilen';

  @override
  String get totalBatteryCapacity => 'Gesamtkapazität der Batterie';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Aktueller Batteriestand';

  @override
  String get desiredArrivalLevel => 'Erwarteter Stand bei Ankunft';

  @override
  String get resultTitle => 'Ergebnis';

  @override
  String get warningTitle => 'Warnung';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'Um Ihr Ziel mit der angenommenen Reserve zu erreichen, müssen Sie $chargeAmount kWh laden.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Das Erreichen des Ziels mit den angegebenen Parametern ist nicht möglich. Die benötigte Energie ($chargeAmount kWh) übersteigt die Batteriekapazität.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Einstellungen';

  @override
  String get theme => 'Thema';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get system => 'System';

  @override
  String get language => 'Sprache';

  @override
  String get consumptionHint => 'kWh/100km oder Meilen';

  @override
  String get distanceHint => 'für welche Entfernung';

  @override
  String get destinationDistanceHint => 'Entfernung zum nächsten Ziel';

  @override
  String get capacityHint => 'Batteriekapazität';

  @override
  String get levelHint => 'Ladestand %';
}
