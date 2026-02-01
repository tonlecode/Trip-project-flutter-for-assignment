import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_card.dart';
import 'details_screen.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results-screen';

  final List<Trip> availableTrips;

  const ResultsScreen({super.key, required this.availableTrips});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];

    final categoryTrips = availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripCard(
            trip: categoryTrips[index],
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsScreen.routeName,
                arguments: categoryTrips[index].id,
              );
            },
          );
        },
        itemCount: categoryTrips.length,
      ),
    );
  }
}
