import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import '../models/trip.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteTrips;

  const TabsScreen({super.key, required this.favoriteTrips});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    if (_selectedPageIndex == 1) {
      activePage = FavoritesScreen(favoriteTrips: widget.favoriteTrips);
    }

    return Scaffold(
      drawer: const MainDrawer(),
      body: activePage,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _selectPage,
        selectedIndex: _selectedPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
