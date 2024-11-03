import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Weather_Model.dart';

class WeatherRepository {
  final String apiKey = '81cb23ffb2d6b49ba577220f3c73c48d';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final response = await http.get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode} - ${response.body}'); // Log the error for debugging
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> fetchWeatherByCity(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode} - ${response.body}'); // Log the error for debugging
      throw Exception('Failed to load weather data');
    }
  }
}
