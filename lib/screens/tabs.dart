import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _tabIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 4),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting == true) {
      _favoriteMeals.remove(meal);
      _showInfoMessage('Removed from favorites');
    } else {
      _favoriteMeals.add(meal);
      _showInfoMessage('Added to favorites');
    }
  }

  void _selectTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus),
      MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      ),
    ];

    List<String> titles = [
      'Categories',
      'Favorites',
    ];

    String title = titles[_tabIndex];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: tabs[_tabIndex],
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          print('Selected $identifier');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _tabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
