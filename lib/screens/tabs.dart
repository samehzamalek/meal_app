import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

import 'categories.dart';
import 'favorites.dart';
import 'filters.dart';

class TabsScreen extends StatefulWidget {
  // TabsScreen({Key? key}) : super(key: key);
  final List<Meal>? favoritesMeal;

  const TabsScreen({Key? key,required this.favoritesMeal}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Widget>>? screens;
  List<Map<String, Object>> title = [
    {'title': 'Categories'},
    {'title': 'Your Favorites '},
  ];
  int currentIndex = 0;
  @override
  void initState() {
    screens = [
      {
        'page': const CategoriesScreen(),
        //'title':'Categories'
      },
      {
        'page':   FavoritesScreen(favoritesMeal:widget.favoritesMeal ,),
        //'title':'Your Favorites '
      },
    ];
     super.initState();
  }

  void selectPage(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title[currentIndex]['title']}'),
      ),
      body: screens![currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
      drawer: MainDrawer(context),
    );
  }
}

Widget MainDrawer(BuildContext context) {
  Widget buildListTile(String title, IconData icon,VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w900,
            color: Colors.black),
      ),
      onTap:onTap ,
    );
  }

  return Drawer(
    child: Column(
      children: [
        Container(
          color: Theme.of(context).accentColor,
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Cooking Up!',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile('Meal', Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
          print('sameh');
        }),
        buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
      ],
    ),
  );
}
