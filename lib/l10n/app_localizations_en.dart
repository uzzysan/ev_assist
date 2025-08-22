// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EV Charging Assistant';

  @override
  String get calculate => 'Calculate';

  @override
  String get averageConsumption => 'Avg. consumption';

  @override
  String get distance => 'Distance';

  @override
  String get km => 'km';

  @override
  String get miles => 'miles';

  @override
  String get totalBatteryCapacity => 'Total battery capacity';

  @override
  String get net => 'Net';

  @override
  String get gross => 'Gross';

  @override
  String get currentBatteryLevel => 'Current battery level';

  @override
  String get desiredArrivalLevel => 'Desired arrival level';

  @override
  String get resultTitle => 'Result';

  @override
  String get warningTitle => 'Warning';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'To reach your destination with the desired reserve, you need to charge $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'It\'s not possible to reach the destination with the assumed parameters. The required energy ($chargeAmount kWh) exceeds battery capacity.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get language => 'Language';

  @override
  String get consumptionHint => 'kWh/100km or miles';

  @override
  String get distanceHint => 'for avg. consumption';

  @override
  String get destinationDistanceHint => 'e.g. 150 km';

  @override
  String get capacityHint => 'e.g. 77';

  @override
  String get levelHint => 'e.g. 80';
}
