import 'package:flutter_bloc/flutter_bloc.dart';
import '../Weather_Model.dart';
import '../weather_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      Weather weather = await weatherRepository.fetchWeatherByCity(event.city);
      emit(WeatherLoaded(weather: weather));
    } catch (_) {
      emit(WeatherError());
    }
  }
}
