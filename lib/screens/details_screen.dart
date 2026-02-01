import 'package:flutter/material.dart';
import '../models/trip.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/trip-detail';

  final Function(String) toggleFavorite;
  final Function(String) isFavorite;

  const DetailsScreen({
    super.key,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    final trip = dummyTrips.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      // Changed to SliverAppBar for "cool" design
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(trip.title),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: trip.id,
                    child: Image.asset(
                      trip.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.broken_image, size: 100),
                          ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDetailChip(
                    context,
                    Icons.attach_money,
                    '${trip.price}',
                  ),
                  const SizedBox(width: 15),
                  _buildDetailChip(
                    context,
                    Icons.schedule,
                    '${trip.duration} Days',
                  ),
                ],
              ),
              buildSectionTitle(context, 'Activities'),
              ...trip.activities.map(
                (activity) => Card(
                  elevation: 1,
                  color: Theme.of(context).colorScheme.surface,
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(activity)),
                      ],
                    ),
                  ),
                ),
              ),
              buildSectionTitle(context, 'Daily Program'),
              ...trip.program.asMap().entries.map(
                (entry) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                        child: Text('${(entry.key + 1)}'),
                      ),
                      title: Text(entry.value),
                    ),
                    Divider(
                      indent: 70,
                      endIndent: 20,
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(tripId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(tripId),
      ),
    );
  }
}
