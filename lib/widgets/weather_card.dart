import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(113, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Lottie.asset(
            weather.description.toLowerCase().contains('rain')
                ? 'assets/rain.json'
                : weather.description.toLowerCase().contains('clear')
                    ? 'assets/sunny.json'
                    : 'assets/cloudy.json',
            height: 150,
            width: 150,
          ),
          Text(
            weather.cityName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            '${weather.temperature.toStringAsFixed(1)}°C',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            weather.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Humidity: ${weather.humidity}%',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Wind: ${weather.windSpeed.toStringAsFixed(1)}m/s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  Text(
                    'Sunrise',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    formatTime(weather.sunrise),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.nights_stay_outlined, color: Colors.purple),
                  Text(
                    'Sunset',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    formatTime(weather.sunset),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}