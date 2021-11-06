import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail.dart';

class CategoryMealScreen extends StatefulWidget {
  const CategoryMealScreen({Key? key, required this.availableMeals})
      : super(key: key);
  static const routeName = 'category_meals';
  final List<Meal> availableMeals;

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  List<Meal>? displayMeals;

  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = widget.availableMeals.where((element) {
      return element.categories!.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    void removeMeal(String mealId) {
      setState(() {
        displayMeals!.removeWhere((element) => element.id == mealId);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => mealItem(
          displayMeals![index].imageUrl,
          displayMeals![index].title,
          displayMeals![index].duration,
          displayMeals![index].complexity,
          displayMeals![index].affordability,
          context,
          displayMeals![index].id,

        )

        //Center(child: Text("${categoryMeals[index].title}",style: TextStyle(color: Colors.black),));

        ,
        itemCount: displayMeals!.length,
      ),
    );
  }
}

Widget mealItem(
  String? imageUrl,
  String? title,
  int? duration,
  Complexity? complexity,
  Affordability? affordability,
  context,
  String id,
  //void Function(String mealId)? removeMeal,
  // removeItem
) {
  return InkWell(
    onTap: () => selectMeal(context, id ),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Text(
          //   '$title',
          //   style: TextStyle(color: Colors.black),
          // ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image(
                  image: NetworkImage('$imageUrl'),
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  child: Text(
                    '$title',
                    style: const TextStyle(
                      fontSize: 26,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '$duration min',
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    const Icon(Icons.work),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      complexityText(complexity!),
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      affordabilityText(affordability!),
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

void selectMeal(
  BuildContext context,
  String id,
 // void Function(String mealId) removeMeal,
) {
  Navigator.of(context)
      .pushNamed(
    MealDetailScreen.routeName,
    arguments: id,
  )
      .then((value) {
    print(value);
   // if (value != null) removeMeal('$value');
  });
}

String affordabilityText(Affordability affordability) {
  switch (affordability) {
    case Affordability.Affordable:
      return 'Affordable';
      break;
    case Affordability.Pricey:
      return 'Pricey';
      break;
    case Affordability.Luxurious:
      return 'Luxurious';
      break;
    default:
      return 'Unknown';
      break;
  }
}

String complexityText(Complexity complexity) {
  switch (complexity) {
    case Complexity.Simple:
      return 'Simple';
      break;
    case Complexity.Challenging:
      return 'Challenging';
      break;
    case Complexity.Hard:
      return 'Hard';
      break;
  }
}
//Function? removeItem;
