// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Asistente de carga EV';

  @override
  String get calculate => 'Calcular';

  @override
  String get averageConsumption => 'Consumo medio';

  @override
  String get distance => 'Distancia';

  @override
  String get km => 'km';

  @override
  String get miles => 'millas';

  @override
  String get totalBatteryCapacity => 'Capacidad total de la batería';

  @override
  String get net => 'Neto';

  @override
  String get gross => 'Bruto';

  @override
  String get currentBatteryLevel => 'Nivel actual de batería';

  @override
  String get desiredArrivalLevel => 'Nivel esperado al llegar';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get warningTitle => 'Advertencia';

  @override
  String chargeMessage(Object chargeAmount) {
    return 'Para llegar a tu destino con la reserva asumida, necesitas cargar $chargeAmount kWh.';
  }

  @override
  String errorMessage(Object chargeAmount) {
    return 'No es posible llegar al destino con los parámetros dados. La energía requerida ($chargeAmount kWh) excede la capacidad de la batería.';
  }

  @override
  String get ok => 'OK';

  @override
  String get settings => 'Ajustes';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get language => 'Idioma';

  @override
  String get consumptionHint => 'kWh';

  @override
  String get distanceHint => 'para qué distancia';

  @override
  String get destinationDistanceHint => 'distancia al siguiente destino';

  @override
  String get capacityHint => 'capacidad de la batería';

  @override
  String get levelHint => 'nivel de carga %';

  @override
  String get supportAuthorButton => 'Apoya al autor';
}
