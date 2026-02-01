import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'results_screen.dart';
import 'details_screen.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
    required this.icon,
  });
}

const dummyCategories = [
  Category(
    id: 'c1',
    title: 'Mountains',
    color: Colors.purple,
    icon: Icons.terrain,
  ),
  Category(
    id: 'c2',
    title: 'Beaches',
    color: Colors.red,
    icon: Icons.beach_access,
  ),
  Category(id: 'c3', title: 'Hiking', color: Colors.orange, icon: Icons.hiking),
  Category(
    id: 'c4',
    title: 'City',
    color: Colors.amber,
    icon: Icons.location_city,
  ),
  Category(
    id: 'c5',
    title: 'Skiing',
    color: Colors.blue,
    icon: Icons.snowboarding,
  ),
  Category(id: 'c6', title: 'Safari', color: Colors.green, icon: Icons.pets),
  Category(
    id: 'c7',
    title: 'History',
    color: Colors.lightBlue,
    icon: Icons.history_edu,
  ),
  Category(
    id: 'c8',
    title: 'Romantic',
    color: Colors.lightGreen,
    icon: Icons.favorite,
  ),
  Category(id: 'c9', title: 'Luxury', color: Colors.pink, icon: Icons.diamond),
  Category(
    id: 'c10',
    title: 'Adventure',
    color: Colors.teal,
    icon: Icons.explore,
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get top 5 trips for the banner
    final featuredTrips = dummyTrips.take(5).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Trip Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Add a subtle pattern overlay or icon
                  Center(
                    child: Opacity(
                      opacity: 0.05,
                      child: Icon(
                        Icons.flight_takeoff,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Featured Trips',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                itemCount: featuredTrips.length,
                itemBuilder: (ctx, index) {
                  final trip = featuredTrips[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailsScreen.routeName,
                          arguments: trip.id,
                        );
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              trip.imageUrl,
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withValues(alpha: 0.8),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${trip.duration} Days',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Browse Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate((ctx, index) {
                final catData = dummyCategories[index];
                return CategoryItem(
                  id: catData.id,
                  title: catData.title,
                  color: catData.color,
                  icon: catData.icon,
                );
              }, childCount: dummyCategories.length),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  const CategoryItem({
    super.key,
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
  });

  void selectCategory(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(ResultsScreen.routeName, arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -10,
              child: Transform.rotate(
                angle: -0.2,
                child: Icon(
                  icon,
                  size: 100,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 28, color: Colors.white),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
