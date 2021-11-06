import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
 // const MealDetailScreen({Key? key}) : super(key: key);
    final Function? toggleFavorites;
    final Function? isFavorite;
  static const routeName = 'meal_detail';

  const MealDetailScreen({Key? key,required this.toggleFavorites,required this.isFavorite}) : super(key: key);
  Widget buildSectionTitle(BuildContext context,String text){
    return      Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child:   Text(text,style: Theme.of(context).textTheme.subtitle1,),
    );
  }
  Widget buildContainer(Widget child,){
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 300,
      child:child
    );
  }


  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String ;
    final selectedMeal=DUMMY_MEALS.firstWhere((element) => element.id==mealId,);


    return Scaffold(
      appBar:AppBar(
        title: Text('${selectedMeal.title}'),
      ) ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child:Image.network('${selectedMeal.imageUrl}',fit: BoxFit.cover,),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
           buildSectionTitle(context, 'Ingredients'),
           buildContainer( ListView.builder(
             itemBuilder:(context,index)=> Card(
               color: Theme.of(context).accentColor,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(selectedMeal.ingredients![index]),
               ),

             ) ,
             itemCount:selectedMeal.ingredients!.length ,

           )),
            buildSectionTitle(context, 'Steps'),
            buildContainer( ListView.builder(
              itemBuilder:(context,index)=>Column(
                children: [
                  ListTile(
                    leading:CircleAvatar(
                      child: Text('#${index + 1 }'),
                    ) ,
                    title: Text(selectedMeal.steps![index]),
                  ),
                  const Divider(color: Colors.grey,)

                ],
              ) ,
              itemCount:selectedMeal.steps!.length ,

            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>toggleFavorites!(mealId),
        child:   Icon(
            isFavorite!(mealId) ? Icons.star : Icons.star_border
        ),
      ),
    );
  }
}
