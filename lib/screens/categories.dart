import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';

import '../dummy_data.dart';
import 'category_meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map((e) => buildCategoryItem(
                  Category(id: e.id, title: e.title, color: e.color), context))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20)),
    );
  }
}

Widget buildCategoryItem(Category model, context) => InkWell(
      onTap: () => selectCategory(context, model),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [model.color!.withOpacity(0.4), model.color!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          color: model.color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          model.title!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );

void selectCategory(BuildContext context, Category model) {
  Navigator.of(context).pushNamed(CategoryMealScreen.routeName, arguments: {
    'id': model.id,
    "title": model.title,
  });


}
