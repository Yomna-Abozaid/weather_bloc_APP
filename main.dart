import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled42/weather_repository.dart';
import 'bloc/bloc_bloc.dart';
import 'bloc/bloc_event.dart';
import 'bloc/bloc_state.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
     home: BlocProvider<WeatherBloc>(
       create: (context)=>WeatherBloc(WeatherRepository()),
       child: WeatherPage(),

     ),

    );
  }
}
class WeatherPage extends StatelessWidget{
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Light blue background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search), // Search icon
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text;
                if (city.isNotEmpty) {
                  context.read<WeatherBloc>().add(FetchWeather(city));
                }
              },
              child: Text('Search'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange.shade900, // Button color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Image.network(
                        'http://openweathermap.org/img/wn/10d@2x.png',

                        height: 100,
                      ),
                      Text(
                        '${state.weather.temperature}°C',
                        style: TextStyle(fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.weather.description,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  );
                }
                else if (state is WeatherError) {
                  return Text(
                    'Failed to fetch weather data',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  );
                }
               return SizedBox();

              },
            ),
          ],
        ),
      ),
    );
  }
}
