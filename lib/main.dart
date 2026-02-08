import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/booking_provider.dart';
import 'screens/tabs_screen.dart';
import 'screens/details_screen.dart';
import 'screens/results_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/ai_planner_screen.dart';
import 'screens/my_booking_screen.dart';
import 'models/trip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Manage favorite trips state here
  final List<Trip> _favoriteTrips = [];

  void _toggleFavorite(String tripId) {
    final existingIndex = _favoriteTrips.indexWhere(
      (trip) => trip.id == tripId,
    );
    setState(() {
      if (existingIndex >= 0) {
        _favoriteTrips.removeAt(existingIndex);
      } else {
        _favoriteTrips.add(dummyTrips.firstWhere((trip) => trip.id == tripId));
      }
    });
  }

  bool _isFavorite(String tripId) {
    return _favoriteTrips.any((trip) => trip.id == tripId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Travel App',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF006D77), // Teal from TabsScreen
                secondary: const Color(0xFFE29578), // Peach from TabsScreen
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.interTextTheme(
                Theme.of(context).textTheme,
              ),
              appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF006D77),
                secondary: const Color(0xFFE29578),
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.interTextTheme(
                Theme.of(context).textTheme,
              ).apply(bodyColor: Colors.white, displayColor: Colors.white),
              appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
            ),
            // Define the home screen as TabsScreen
            home: TabsScreen(favoriteTrips: _favoriteTrips),
            // Define routes for navigation
            routes: {
              DetailsScreen.routeName: (ctx) => DetailsScreen(
                toggleFavorite: _toggleFavorite,
                isFavorite: _isFavorite,
              ),
              ResultsScreen.routeName: (ctx) =>
                  const ResultsScreen(availableTrips: dummyTrips),
              CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
              AiPlannerScreen.routeName: (ctx) => const AiPlannerScreen(),
              MyBookingScreen.routeName: (ctx) => const MyBookingScreen(),
            },
            // Fallback for unknown routes
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (ctx) => const TabsScreen(favoriteTrips: []),
              );
            },
          );
        },
      ),
    );
  }
}
