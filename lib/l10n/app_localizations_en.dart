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
  String get averageConsumption => 'Average consumption';

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
  String get desiredArrivalLevel => 'Expected level on arrival';

  @override
  String get resultTitle => 'Result';

  @override
  String get warningTitle => 'Warning';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'To reach your destination with the assumed reserve, you need to charge $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Reaching the destination with the given parameters is not possible. The required energy ($chargeAmount kWh) exceeds the battery capacity.';
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
  String get distanceHint => 'for what distance';

  @override
  String get destinationDistanceHint => 'distance to next destination';

  @override
  String get capacityHint => 'battery capacity';

  @override
  String get levelHint => 'charge level %';

  @override
  String get supportAuthorButton => 'Support the author';
}
