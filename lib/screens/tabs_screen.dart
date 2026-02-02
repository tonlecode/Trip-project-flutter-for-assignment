import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'my_booking_screen.dart';
import 'my_profile_screen.dart';
import 'ai_planner_screen.dart';
import '../models/trip.dart';
import '../widgets/main_drawer.dart';
import '../delegates/trip_search_delegate.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteTrips;

  const TabsScreen({super.key, required this.favoriteTrips});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with SingleTickerProviderStateMixin {
  int _selectedPageIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    // Adds a subtle vibration for a premium physical feel
    HapticFeedback.lightImpact();
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of pages to keep the build method clean
    final List<Map<String, dynamic>> pages = [
      {'page': const HomeScreen(), 'title': 'Explore Trips'},
      {'page': const MyBookingScreen(), 'title': 'My Bookings'},
      {
        'page': FavoritesScreen(favoriteTrips: widget.favoriteTrips),
        'title': 'Your Favorites',
      },
      {'page': const MyProfileScreen(), 'title': 'My Profile'},
    ];

    return Scaffold(
      drawer: const MainDrawer(),
      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnimation,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AiPlannerScreen(),
            );
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.smart_toy, color: Colors.white, size: 30),
        ),
      ),
      // 1. Transparent AppBar that blends with the scaffold background
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TripSearchDelegate());
            },
          ),
        ],
      ),
      // 2. Animated Switcher for smooth fading between tabs
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_selectedPageIndex]['page'],
      ),
      // 3. Stylized NavigationBar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: NavigationBar(
          onDestinationSelected: _selectPage,
          selectedIndex: _selectedPageIndex,
          height: 70, // Slightly taller for better ergonomics
          elevation: 0,
          backgroundColor: Colors.white,
          indicatorColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.5),
          labelBehavior: NavigationDestinationLabelBehavior
              .onlyShowSelected, // Cleaner look
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore, color: Color(0xFF006D77)),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.airplane_ticket_outlined),
              selectedIcon:
                  Icon(Icons.airplane_ticket, color: Color(0xFF006D77)),
              label: 'My Booking',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite, color: Color(0xFFE29578)),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Color(0xFF006D77)),
              label: 'My Profile',
            ),
          ],
        ),
      ),
    );
  }
}
