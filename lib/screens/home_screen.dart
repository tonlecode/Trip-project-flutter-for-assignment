import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../models/category.dart';
import '../widgets/category_item.dart';
import '../widgets/popular_trip_card.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredTrips = dummyTrips.take(5).toList();
    final popularTrips = [...dummyTrips]
      ..sort((a, b) => b.price.compareTo(a.price));
    final topPopular = popularTrips.take(8).toList();

    return Scaffold(
      body: CustomScrollView(
        physics:
            const BouncingScrollPhysics(), // Adds that premium "elastic" feel
        slivers: [
          // Removed SliverAppBar
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Section Title: Featured
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, 'Featured Experiences'),
          ),

          // Horizontal Featured Carousel
          SliverToBoxAdapter(
            child: SizedBox(
              height: 260, // Increased height to prevent clipping shadows
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: featuredTrips.length,
                itemBuilder: (ctx, index) {
                  final trip = featuredTrips[index];
                  return FeaturedTripCard(trip: trip);
                },
              ),
            ),
          ),

          // Section Title: Categories
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, 'Travel Categories'),
          ),

          // Category Grid with refined padding
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.1, // Square-ish cards look cleaner here
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, index) => CategoryItem(category: dummyCategories[index]),
                childCount: dummyCategories.length,
              ),
            ),
          ),

          // Section Title: More Popular
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, 'More Popular'),
          ),

          // Horizontal Popular list
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: topPopular.length,
                separatorBuilder: (_, __) => const SizedBox(width: 4),
                itemBuilder: (ctx, index) {
                  return PopularTripCard(trip: topPopular[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class FeaturedTripCard extends StatelessWidget {
  final Trip trip;
  const FeaturedTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(DetailsScreen.routeName, arguments: trip.id);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Hero(
                tag: trip.id,
                child: Image.asset(
                  trip.imageUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              // Gradient Overlay for text readability
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${trip.duration} Days',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
