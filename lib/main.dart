import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screen.dart';
import './screens/results_screen.dart';
import './screens/details_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './screens/ai_planner_screen.dart';
import './screens/ai_chat_screen.dart';
import './screens/ai_image_screen.dart';
import './models/trip.dart';
import './providers/theme_provider.dart';
import './services/ai_service.dart';

void main() {
  AIService().init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Trip App',
      debugShowCheckedModeBanner:
          false, // Removes the debug banner for a cleaner look
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,

        // 1. Refined Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006D77), // Deep Ocean Teal
          primary: const Color(0xFF006D77),
          secondary: const Color(0xFFE29578), // Soft Coral/Salmon
          surface: Colors.white,
          onSurface: const Color(0xFF2B2D42),
          brightness: Brightness.light,
        ),

        // 2. Global Scaffold Style
        scaffoldBackgroundColor: const Color(
          0xFFF1F5F9,
        ), // Very light cool grey
        // 3. Typography (Using Google Fonts for a premium feel)
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme)
            .copyWith(
              displayLarge: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2B2D42),
              ),
              titleLarge: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
              bodyMedium: GoogleFonts.inter(
                color: const Color(0xFF4A4E69),
                fontSize: 16,
              ),
            ),

        // 4. Enhanced AppBar Design
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 2, // Slight shadow when content scrolls under
          backgroundColor: const Color(0xFFF1F5F9),
          foregroundColor: const Color(0xFF006D77),
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF006D77),
          ),
        ),

        // 5. Modern Card & Button Styling
        cardTheme: CardThemeData(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              24,
            ), // Extra rounded for modern look
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006D77),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
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
        CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
        AiPlannerScreen.routeName: (ctx) => const AiPlannerScreen(),
        AIChatScreen.routeName: (ctx) => const AIChatScreen(),
        AIImageScreen.routeName: (ctx) => const AIImageScreen(),
      },
    );
  }
}
