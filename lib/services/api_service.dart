import 'package:dio/dio.dart';

const String baseUrl = "https://api.openweathermap.org/data/2.5/";
const String apiKey = '2b5614304b0e3b1c732f3322f393e196';

Dio dio() {
  return Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Content-Type': 'application/json'}));
}