class Meal {
  String id;
  List<String>? categories;
  String? title;
  String? imageUrl;
  List<String>? steps;
  List<String>? ingredients;
  int? duration;
  Complexity? complexity;
  Affordability? affordability;
  bool? isGlutenFree;
  bool? isLactoseFree;
  bool? isVegan;
  bool? isVegetarian;

  Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imageUrl,
      required this.steps,
      required this.ingredients,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian
      });
}
enum Complexity{
  Simple,
  Challenging,
  Hard
}
enum Affordability{
  Affordable,
  Pricey,
  Luxurious
}


