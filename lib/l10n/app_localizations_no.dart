// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get appTitle => 'EV Ladeassistent';

  @override
  String get calculate => 'Beregn';

  @override
  String get averageConsumption => 'Gjennomsnittlig forbruk';

  @override
  String get distance => 'Distanse';

  @override
  String get km => 'km';

  @override
  String get miles => 'mil';

  @override
  String get totalBatteryCapacity => 'Total batterikapasitet';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Nåværende batterinivå';

  @override
  String get desiredArrivalLevel => 'Forventet nivå ved ankomst';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get warningTitle => 'Advarsel';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'For å nå destinasjonen med antatt reserve må du lade $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Det er ikke mulig å nå destinasjonen med de gitte parametrene. Den nødvendige energien ($chargeAmount kWh) overstiger batterikapasiteten.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Innstillinger';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get system => 'System';

  @override
  String get language => 'Språk';

  @override
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'for hvilken distanse';

  @override
  String get destinationDistanceHint => 'distanse til neste destinasjon';

  @override
  String get capacityHint => 'batterikapasitet';

  @override
  String get levelHint => 'ladningsnivå %';

  @override
  String get supportAuthorButton => 'Støtt forfatteren';
}
