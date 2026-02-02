import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/trip.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/trip-detail';

  final Function(String) toggleFavorite;
  final bool Function(String) isFavorite; // Fixed type to return bool

  const DetailsScreen({
    super.key,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  // Reusable Section Header with modern typography
  Widget _buildSectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildDetailChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    final trip = dummyTrips.firstWhere((trip) => trip.id == tripId);
    final favoriteStatus = isFavorite(tripId);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Immersive SliverAppBar
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            stretch: true,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              title: Text(
                trip.title,
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  shadows: [
                    const Shadow(blurRadius: 10, color: Colors.black45),
                  ],
                ),
              ),
              background: Hero(
                tag: trip.id,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(trip.imageUrl, fit: BoxFit.cover),
                    // Stronger gradient for title readability
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                            Colors.black45,
                          ],
                          begin: Alignment.bottomCenter,
                          stops: [0.0, 0.4, 1.0],
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 25),
              // 2. Info Chips Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDetailChip(
                    context,
                    Icons.schedule,
                    '${trip.duration} Days',
                    Colors.blueGrey,
                  ),
                  _buildDetailChip(
                    context,
                    Icons.attach_money,
                    '\$${trip.price}',
                    Colors.green,
                  ),
                  _buildDetailChip(
                    context,
                    Icons.star,
                    '4.8',
                    Colors.orange,
                  ), // Static rating example
                ],
              ),

              _buildSectionTitle(context, 'Activities'),
              // 3. Horizontal Activities Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: trip.activities.map((activity) {
                    return Chip(
                      label: Text(activity),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }).toList(),
                ),
              ),

              _buildSectionTitle(context, 'Journey Plan'),
              // 4. Modern Step-by-Step Program
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: trip.program.asMap().entries.map((entry) {
                    return IntrinsicHeight(
                      child: Row(
                        children: [
                          // Timeline line and circle
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 2,
                                  color: entry.key == trip.program.length - 1
                                      ? Colors.transparent
                                      : Theme.of(context).colorScheme.primary
                                            .withValues(alpha: 0.2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          // Content Card
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade100),
                              ),
                              child: Text(
                                entry.value,
                                style: GoogleFonts.inter(
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(context, 'Location'),
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      // Using a color placeholder or image if available
                      Container(color: Colors.grey.shade300),
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Map View'),
                          ],
                        ),
                      ),
                      // Uncomment to use Google Maps (requires API Key)
                      // GoogleMap(
                      //   initialCameraPosition: const CameraPosition(
                      //     target: LatLng(37.42796133580664, -122.085749655962),
                      //     zoom: 10,
                      //   ),
                      //   liteModeEnabled: true,
                      // ),
                    ],
                  ),
                ),
              ),

              _buildSectionTitle(context, 'Weather'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.wb_sunny_rounded,
                      size: 40,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24°C',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'Sunny',
                          style: GoogleFonts.inter(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text('Wind: 10km/h'), Text('Humidity: 45%')],
                    ),
                  ],
                ),
              ),

              _buildSectionTitle(context, 'Reviews'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text(
                          'A',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: const Text('Alice'),
                      subtitle: const Text('Amazing trip! Highly recommended.'),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' 5.0'),
                        ],
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        child: const Text(
                          'B',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: const Text('Bob'),
                      subtitle: const Text('Good experience but a bit tiring.'),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' 4.0'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
      // 5. Stylized Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => toggleFavorite(tripId),
        backgroundColor: favoriteStatus
            ? Colors.pink
            : Theme.of(context).colorScheme.primary,
        icon: Icon(
          favoriteStatus ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
        label: Text(
          favoriteStatus ? 'In Favorites' : 'Add to Favorites',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
