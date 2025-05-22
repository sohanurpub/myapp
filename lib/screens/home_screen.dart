import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_services.dart';
import '../widgets/weather_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    if (_controller.text.isEmpty) return;
    
    setState(() => _isLoading = true);

    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      if (mounted) {
        setState(() {
          _weather = weather;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error fetching weather data')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _weather != null
              ? _weather!.description.toLowerCase().contains('rain')
                  ? const LinearGradient(
                      colors: [Colors.grey, Colors.blueGrey],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : _weather!.description.toLowerCase().contains('clear')
                      ? const LinearGradient(
                          colors: [Colors.orangeAccent, Colors.blueAccent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : const LinearGradient(
                          colors: [Colors.grey, Colors.lightBlueAccent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
              : const LinearGradient(
                  colors: [Colors.grey, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 233, 206, 206),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter City Name",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color.fromARGB(109, 104, 100, 100),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(209, 250, 253, 255),
                    foregroundColor: const Color.fromARGB(255, 69, 149, 214),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Get Weather', style: TextStyle(fontSize: 18)),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}