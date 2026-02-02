import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';
import 'details_screen.dart';

class ResultsScreen extends StatefulWidget {
  static const routeName = '/results-screen';

  final List<Trip> availableTrips;

  const ResultsScreen({super.key, required this.availableTrips});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final Set<String> _selectedChips = {};

  final List<String> _filterOptions = [
    'Affordable',
    'Pricey',
    'Luxurious',
    'Simple',
    'Challenging',
    'Hard',
  ];

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];

    // 1. Filter by Category
    var filteredTrips = widget.availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();

    // 2. Filter by Chips
    if (_selectedChips.isNotEmpty) {
      filteredTrips = filteredTrips.where((trip) {
        bool matches = false;
        if (_selectedChips.contains('Affordable') &&
            trip.affordability == Affordability.affordable)
          matches = true;
        if (_selectedChips.contains('Pricey') &&
            trip.affordability == Affordability.pricey)
          matches = true;
        if (_selectedChips.contains('Luxurious') &&
            trip.affordability == Affordability.luxurious)
          matches = true;
        if (_selectedChips.contains('Simple') &&
            trip.complexity == Complexity.simple)
          matches = true;
        if (_selectedChips.contains('Challenging') &&
            trip.complexity == Complexity.challenging)
          matches = true;
        if (_selectedChips.contains('Hard') &&
            trip.complexity == Complexity.hard)
          matches = true;
        return matches;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(categoryTitle!),
            Text(
              '${filteredTrips.length} trips found',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 8),
              itemBuilder: (ctx, index) {
                final option = _filterOptions[index];
                final isSelected = _selectedChips.contains(option);
                return FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedChips.add(option);
                      } else {
                        _selectedChips.remove(option);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: filteredTrips.isEmpty
                ? _buildEmptyState(context)
                : AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredTrips.length,
                      itemBuilder: (ctx, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: TripCard(
                                trip: filteredTrips[index],
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    DetailsScreen.routeName,
                                    arguments: filteredTrips[index].id,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Beautiful empty state for when filters hide all category trips
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list_off_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: 24),
            Text(
              'No Trips Match Your Filters',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Try adjusting your preferences to see more adventures.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[600], height: 1.5),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
