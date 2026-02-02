import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../screens/details_screen.dart';

class TripSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = dummyTrips.where((trip) {
      return trip.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No trips found for "$query"',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final trip = results[index];
        return ListTile(
          leading: Hero(
            tag: trip.id,
            child: CircleAvatar(
              backgroundImage: AssetImage(trip.imageUrl),
            ),
          ),
          title: Text(trip.title),
          subtitle: Text('${trip.duration} days - \$${trip.price}'),
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailsScreen.routeName,
              arguments: trip.id,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dummyTrips.where((trip) {
      return trip.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final trip = suggestions[index];
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(trip.title),
          onTap: () {
            query = trip.title;
            showResults(context);
          },
        );
      },
    );
  }
}
