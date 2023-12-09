import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Meal {
  String name;
  String description;

  Meal(this.name, this.description);
}

class Category {
  String name;
  List<Meal> meals;

  Category(this.name, this.meals);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data
    var pasta = Meal("Spaghetti", "Delicious pasta with tomato sauce");
    var pizza = Meal("Margherita Pizza", "Classic pizza with tomato and mozzarella");

    var italianCategory = Category("Italian", [pasta, pizza]);

    return MaterialApp(
      title: 'My Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyMenu(categories: [italianCategory]),
    );
  }
}

class MyMenu extends StatelessWidget {
  final List<Category> categories;

  MyMenu({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Makanan'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var category = categories[index];
          return ExpansionTile(
            title: Text(category.name),
            children: category.meals.map((meal) {
              return ListTile(
                title: Text(meal.name),
                onTap: () {
                  // Navigate to meal details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealDetailsPage(meal: meal),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class MealDetailsPage extends StatelessWidget {
  final Meal meal;

  MealDetailsPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(meal.description),
          ],
        ),
      ),
    );
  }
}
