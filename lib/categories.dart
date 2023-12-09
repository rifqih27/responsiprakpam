import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'meal_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MealsPage()));
          },
          child: Text('Go to Meals'),
        ),
      ),
    );
  }
}

class MealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailPage()));
          },
          child: Text('Go to Meal Detail'),
        ),
      ),
    );
  }
}

class MealDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: Center(
        child: Text('Meal Detail Page'),
      ),
    );
  }
}

class meal_bloc extends StatelessWidget {
  final MealBloc mealBloc = MealBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealInitialState) {
            return Center(child: Text('Select a category to see meals.'));
          } else if (state is MealLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealLoadedState) {
            return ListView.builder(
              itemCount: state.meals.length,
              itemBuilder: (context, index) {
                final meal = state.meals[index];
                return ListTile(
                  title: Text(meal['name']),
                  subtitle: Text(meal['description']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealDetailPage()),
                    );
                  },
                );
              },
            );
          } else if (state is MealErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

