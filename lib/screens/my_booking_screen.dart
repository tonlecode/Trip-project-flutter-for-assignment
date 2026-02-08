import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_card.dart';

class MyBookingScreen extends StatelessWidget {
  static const routeName = '/my-booking';

  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past & Cancelled'),
              ],
            ),
          ),
          Expanded(
            child: Consumer<BookingProvider>(
              builder: (context, bookingData, child) {
                final upcoming = bookingData.upcomingBookings;
                final past = bookingData.pastBookings;

                return TabBarView(
                  children: [
                    _buildBookingList(context, upcoming, 'No upcoming bookings'),
                    _buildBookingList(context, past, 'No past bookings'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList(
    BuildContext context,
    List<dynamic> bookings,
    String emptyMessage,
  ) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplane_ticket_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(booking: bookings[index]);
      },
    );
  }
}
