// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Asystent ładowania EV';

  @override
  String get calculate => 'Oblicz';

  @override
  String get averageConsumption => 'Średnie zużycie';

  @override
  String get distance => 'Dystans';

  @override
  String get km => 'km';

  @override
  String get miles => 'mile';

  @override
  String get totalBatteryCapacity => 'Całkowita pojemność baterii';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Obecny poziom baterii';

  @override
  String get desiredArrivalLevel => 'Oczekiwany poziom po dotarciu';

  @override
  String get resultTitle => 'Wynik';

  @override
  String get warningTitle => 'Ostrzeżenie';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'Aby dotrzeć do celu z zakładaną rezerwą, musisz doładować $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Osiągnięcie celu z zadanymi parametrami nie jest możliwe. Wymagana energia ($chargeAmount kWh) przekracza pojemność baterii.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Ustawienia';

  @override
  String get theme => 'Motyw';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get system => 'Systemowy';

  @override
  String get language => 'Język';

  @override
  String get consumptionHint => 'kWh/100km lub mil';

  @override
  String get distanceHint => 'dla średniego zużycia';

  @override
  String get destinationDistanceHint => 'np. 150 km';

  @override
  String get capacityHint => 'np. 77';

  @override
  String get levelHint => 'np. 80';
}
