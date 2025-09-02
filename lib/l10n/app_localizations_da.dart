// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'EV Opladningsassistent';

  @override
  String get calculate => 'Beregn';

  @override
  String get averageConsumption => 'Gennemsnitligt forbrug';

  @override
  String get distance => 'Afstand';

  @override
  String get km => 'km';

  @override
  String get miles => 'mil';

  @override
  String get totalBatteryCapacity => 'Batteriets samlede kapacitet';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Nuværende batteriniveau';

  @override
  String get desiredArrivalLevel => 'Forventet niveau ved ankomst';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get warningTitle => 'Advarsel';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'For at nå din destination med den antagede reserve skal du oplade $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Det er ikke muligt at nå destinationen med de givne parametre. Den krævede energi ($chargeAmount kWh) overstiger batteriets kapacitet.';
  }

  @override
  String get destinationOutOfReach => 'Destinationen kan ikke nås med det nuværende batteriniveau og de givne betingelser.';

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Indstillinger';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get system => 'System';

  @override
  String get language => 'Sprog';

  @override
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'for hvilken afstand';

  @override
  String get destinationDistanceHint => 'afstand til næste destination';

  @override
  String get capacityHint => 'batterikapacitet';

  @override
  String get levelHint => 'opladningsniveau %';

  @override
  String get supportAuthorButton => 'Støt forfatteren';
}
