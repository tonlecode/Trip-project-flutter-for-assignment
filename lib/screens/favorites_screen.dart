import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> favoriteTrips;

  const FavoritesScreen({super.key, required this.favoriteTrips});

  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Favorites')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 100,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              const SizedBox(height: 20),
              Text(
                'No favorites yet!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Start adding some trips to your list.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Your Favorites')),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return TripCard(
              trip: favoriteTrips[index],
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetailsScreen.routeName,
                  arguments: favoriteTrips[index].id,
                );
              },
            );
          },
          itemCount: favoriteTrips.length,
        ),
      );
    }
  }
}
