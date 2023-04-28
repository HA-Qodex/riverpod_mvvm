import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_mvvm/models/weather_model.dart';
import 'package:riverpod_mvvm/services/api_service.dart';

abstract class WeatherServices {
  Future<WeatherModel> getWeather(String location);
}

class WeatherService extends WeatherServices {
  @override
  Future<WeatherModel> getWeather(String location) async {
    String url = 'weather?q=$location&appid=$apiKey';
    try {
      final response = await dio().get(url);
      return WeatherModel.fromJson(response.data);
    } on DioError catch (e) {
      // debugPrint("------------------------>> $e");
      throw Exception("Weather error $e");
    }
  }
}
