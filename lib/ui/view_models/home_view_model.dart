import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mvvm/models/weather_model.dart';
import 'package:riverpod_mvvm/services/weather_service.dart';

final homeProvider = Provider<HomeViewModel>((ref) => HomeViewModel());

class HomeViewModel {
  Future<WeatherModel> getWeather({required String location}) async {
    return await WeatherService().getWeather(location);
  }
}
