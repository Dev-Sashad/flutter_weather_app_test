import 'package:get_it/get_it.dart';
import 'package:weather_app/services/dialog_service.dart';
import 'package:weather_app/services/weather_services.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => WeatherService());
  locator.registerLazySingleton(() => DialogService());
}
