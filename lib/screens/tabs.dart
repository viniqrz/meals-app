import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _tabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      CategoriesScreen(
        availableMeals: ref.watch(mealsProvider),
      ),
      MealsScreen(
        meals: ref.watch(favoriteMealsProvider),
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
