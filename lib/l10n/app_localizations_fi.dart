// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'EV Latausavustaja';

  @override
  String get calculate => 'Laske';

  @override
  String get averageConsumption => 'Keskikulutus';

  @override
  String get distance => 'Etäisyys';

  @override
  String get km => 'km';

  @override
  String get miles => 'mailia';

  @override
  String get totalBatteryCapacity => 'Akun kokonaiskapasiteetti';

  @override
  String get net => 'Netto';

  @override
  String get gross => 'Brutto';

  @override
  String get currentBatteryLevel => 'Nykyinen akun taso';

  @override
  String get desiredArrivalLevel => 'Odotettu taso saapuessa';

  @override
  String get resultTitle => 'Tulos';

  @override
  String get warningTitle => 'Varoitus';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'Saadaksesi määränpäähän oletetulla varauksella, sinun tulee ladata $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'Määränpäähän pääseminen annetuilla parametreilla ei ole mahdollista. Tarvittava energia ($chargeAmount kWh) ylittää akun kapasiteetin.';
  }

  @override
  String get destinationOutOfReach => 'Määränpää on saavuttamattomissa nykyisellä akun tasolla ja annetuissa olosuhteissa.';

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Asetukset';

  @override
  String get theme => 'Teema';

  @override
  String get light => 'Vaalea';

  @override
  String get dark => 'Tumma';

  @override
  String get system => 'Järjestelmä';

  @override
  String get language => 'Kieli';

  @override
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'mille etäisyydelle';

  @override
  String get destinationDistanceHint => 'etäisyys seuraavaan kohteeseen';

  @override
  String get capacityHint => 'akun kapasiteetti';

  @override
  String get levelHint => 'lataustaso %';

  @override
  String get supportAuthorButton => 'Tue kirjoittajaa';
}
