import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';
import './screens/results_screen.dart';
import './screens/details_screen.dart';
import './screens/filters_screen.dart';
import './models/trip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Trip> _availableTrips = dummyTrips;
  final List<Trip> _favoriteTrips = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips = dummyTrips.where((trip) {
        if (_filters['gluten']! && !trip.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !trip.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !trip.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !trip.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String tripId) {
    final existingIndex = _favoriteTrips.indexWhere(
      (trip) => trip.id == tripId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(dummyTrips.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B), // Teal 600
          secondary: const Color(0xFFFF6F00), // Amber 900
          surface: Colors.white,
          // background is deprecated in some versions but handled by colorScheme
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Light grey-white
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent, // For transparent feel if needed
          titleTextStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF00695C), // Dark Teal
          ),
          iconTheme: IconThemeData(color: Color(0xFF00695C)),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      // home: CategoriesScreen(), // We use routes now
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteTrips: _favoriteTrips),
        ResultsScreen.routeName: (ctx) =>
            ResultsScreen(availableTrips: _availableTrips),
        DetailsScreen.routeName: (ctx) => DetailsScreen(
          toggleFavorite: _toggleFavorite,
          isFavorite: _isFavorite,
        ),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
    );
  }
}
