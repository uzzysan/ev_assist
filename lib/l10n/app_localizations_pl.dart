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
  String get destinationOutOfReach => 'Cel jest poza zasięgiem przy obecnym poziomie baterii i danych warunkach.';

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
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'na jakim dystansie';

  @override
  String get destinationDistanceHint => 'odległość do następnego celu';

  @override
  String get capacityHint => 'pojemność baterii';

  @override
  String get levelHint => 'poziom naładowania %';

  @override
  String get supportAuthorButton => 'Wesprzyj autora';
}
