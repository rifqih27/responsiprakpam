import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// Event
abstract class MealEvent {}

class FetchMealsEvent extends MealEvent {
  final String category;

  FetchMealsEvent(this.category);
}

// State
abstract class MealState {}

class MealInitialState extends MealState {}

class MealLoadingState extends MealState {}

class MealLoadedState extends MealState {
  final List<Map<String, dynamic>> meals;

  MealLoadedState(this.meals);
}

class MealErrorState extends MealState {
  final String error;

  MealErrorState(this.error);
}

// Bloc
class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealInitialState());

  @override
  Stream<MealState> mapEventToState(MealEvent event) async* {
    if (event is FetchMealsEvent) {
      yield MealLoadingState();
      try {
        final response = await http.get(Uri.parse('https://your-api-url/meals?category=${event.category}'));
        final List<Map<String, dynamic>> meals = List.from(json.decode(response.body));
        yield MealLoadedState(meals);
      } catch (e) {
        yield MealErrorState('Failed to fetch meals');
      }
    }
  }
}
