import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> favoriteTrips;

  const FavoritesScreen({super.key, required this.favoriteTrips});

  @override
  Widget build(BuildContext context) {
    // Check if empty
    if (favoriteTrips.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. More "designed" empty state icon
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_yfq8lknn.json',
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 80,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.5),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              // 2. Stronger Typography
              Text(
                'No favorites yet!',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Explore our amazing trips and tap the heart icon to save your dream destinations here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 3. ListView with better padding and physics
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: favoriteTrips.length,
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
    );
  }
}
