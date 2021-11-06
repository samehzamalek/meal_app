import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

import 'category_meal.dart';

class FavoritesScreen extends StatelessWidget {

  final List<Meal>? favoritesMeal;

  const FavoritesScreen({Key? key,required this.favoritesMeal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(favoritesMeal!.isEmpty) {
      return
      const Center(child: Text('You have no favorites yet - start adding some!',style: TextStyle(color: Colors.black),));

    }else {
      return  ListView.builder(
        itemBuilder: (context, index) => mealItem(
          favoritesMeal![index].imageUrl,
          favoritesMeal![index].title,
          favoritesMeal![index].duration,
          favoritesMeal![index].complexity,
          favoritesMeal![index].affordability,
          context,
          favoritesMeal![index].id,
        )
        //Center(child: Text("${categoryMeals[index].title}",style: TextStyle(color: Colors.black),));
        ,
        itemCount: favoritesMeal!.length,
      );
    }
  }
}
//Text('You have no favorites yet - start adding some!',style: TextStyle(color: Colors.black),),