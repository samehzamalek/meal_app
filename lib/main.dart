import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
 import 'package:meal_app/screens/category_meal.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meal_detail.dart';
import 'package:meal_app/screens/tabs.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal>? availableMeal=DUMMY_MEALS;
  List<Meal>? favoritesMeal=[];

  void _setFilters(  Map<String, bool>filterData){
    setState(() {
      _filters =filterData;
      availableMeal =DUMMY_MEALS.where((element) {
        if(_filters['gluten'] == true && element.isGlutenFree == false ) {
          return false;
        }
        if(_filters['lactose'] == true && element.isLactoseFree == false ) {
          return false;
        }
        if(_filters['vegan'] == true && element.isVegan == false ) {
          return false;
        }
        if(_filters['vegetarian'] == true && element.isVegetarian == false ) {
          return false;
        }
        return true;

      }).toList();
    });


  }

  void  toggleFavorites(String mealId){
   final existingIndex = favoritesMeal!.indexWhere((element) => element.id == mealId);
   if(existingIndex >= 0){
     setState(() {
       favoritesMeal!.removeAt(existingIndex);
     });
   }else{
     setState(() {
       favoritesMeal!.add(DUMMY_MEALS.firstWhere((element) => element.id ==mealId ));

     });
   }
  }
  bool isMealFavorite(String id){
    return favoritesMeal!.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(255, 254, 229, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(255, 254, 229, 1),
              ),
              subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) =>   TabsScreen(favoritesMeal: favoritesMeal,),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(availableMeals: availableMeal!,),
        MealDetailScreen.routeName: (context) =>   MealDetailScreen(toggleFavorites: toggleFavorites, isFavorite: isMealFavorite,),
        FiltersScreen.routeName: (context) =>   FiltersScreen(saveFilter: _setFilters, currentFilters: _filters ,),
      },
    );
  }
}
