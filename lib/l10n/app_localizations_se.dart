// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Northern Sami (`se`).
class AppLocalizationsSe extends AppLocalizations {
  AppLocalizationsSe([String locale = 'se']) : super(locale);

  @override
  String get appTitle => 'EV Laddningsassistent';

  @override
  String get calculate => 'Beräkna';

  @override
  String get averageConsumption => 'Genomsnittlig förbrukning';

  @override
  String get distance => 'Avstånd';

  @override
  String get km => 'km';

  @override
  String get miles => 'mil';

  @override
  String get totalBatteryCapacity => 'Total batterikapacitet';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Nuvarande batterinivå';

  @override
  String get desiredArrivalLevel => 'Förväntad nivå vid ankomst';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get warningTitle => 'Varning';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'För att nå din destination med antagen reserv måste du ladda $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Det är inte möjligt att nå destinationen med de angivna parametrarna. Den nödvändiga energin ($chargeAmount kWh) överstiger batterikapaciteten.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Inställningar';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Ljus';

  @override
  String get dark => 'Mörk';

  @override
  String get system => 'System';

  @override
  String get language => 'Språk';

  @override
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'för vilket avstånd';

  @override
  String get destinationDistanceHint => 'avstånd till nästa destination';

  @override
  String get capacityHint => 'batterikapacitet';

  @override
  String get levelHint => 'laddningsnivå %';

  @override
  String get supportAuthorButton => 'Stöd författaren';
}
