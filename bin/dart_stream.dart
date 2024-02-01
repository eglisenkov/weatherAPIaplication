// connecting libraries

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Configuring Requests
  final apiKey = '0ea998d67f8bfc5520c58685dc21187b'; // Замените на ваш ключ API
  final cities = {
    'Москва': '524901',
    'Санкт-Петербург': '498817',
    'Новосибирск': '1496747',
  };

  // Working with queries

  for (var city in cities.entries) {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?id=${city.value}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    // if the code returns 200 (everything works well), then we output the received data

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperature = data['main']['temp'];
      final weatherDescription = data['weather'][0]['description'];
      final pressure = data['main']['pressure'];
      final windSpeed = data['wind']['speed'];

      print('Температура в ${city.key}: $temperature°C');
      print('Описание погоды в ${city.key}: $weatherDescription');
      print('Давление в городе ${city.key}: $pressure');
      print('Скорость ветра в городе ${city.key}: $windSpeed');

      // If we get an error, we output it and continue working
    } else {
      print(
          'Ошибка при получении данных для ${city.key}: ${response.statusCode}');
    }
  }
}
