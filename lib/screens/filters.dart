import 'package:flutter/material.dart';
import 'package:meal_app/screens/tabs.dart';

class FiltersScreen extends StatefulWidget {
    FiltersScreen({required this.saveFilter, required this.currentFilters});
  static const routeName = 'filters';
  final Function saveFilter;
  final Map<String,bool>currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _glutenFree = false;
  bool? _lactoseFree = false;
  bool? _vegan = false;
  bool? _vegetarian = false;

  initState(){
    _glutenFree = widget.currentFilters['gluten'];
     _lactoseFree = widget.currentFilters['lactose'];
      _vegan =  widget.currentFilters['vegan'];
     _vegetarian =  widget.currentFilters['vegetarian'];
    super.initState();
  }



  Widget buildSwitchListTile(
      bool value, String title, String subtitle, Function(bool)? updateValue) {
    return SwitchListTile(
      value: value,
      onChanged: updateValue,

      // 'Gluten-free'
      //'Only include gluten-free meals.'
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: [
          IconButton(onPressed : (){
            final  Map<String,bool> selectedFilters= {
              'gluten': _glutenFree!,
              'lactose': _lactoseFree!,
              'vegan': _vegan!,
              'vegetarian': _vegetarian!,
            };

            widget.saveFilter(selectedFilters);
          },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(context),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection. ',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  _glutenFree!, 'Gluten-free', 'Only include gluten-free meals.',
                  (newValue) {

                setState(() {
                  _glutenFree = newValue;
                });
              }),
              buildSwitchListTile(_lactoseFree!, 'Lactose-free',
                  'Only include lactose-free meals.', (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              buildSwitchListTile(_vegan!, 'Vegan', 'Only include vegan meals.',
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              buildSwitchListTile(
                  _vegetarian!, 'Vegetarian', 'Only include vegetarian meals.',
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
