import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/trip.dart';

class BookingProvider with ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => [..._bookings];

  List<Booking> get upcomingBookings =>
      _bookings
          .where((booking) => booking.status == BookingStatus.upcoming)
          .toList();

  List<Booking> get pastBookings =>
      _bookings
          .where(
            (booking) =>
                booking.status == BookingStatus.completed ||
                booking.status == BookingStatus.cancelled,
          )
          .toList();

  void addBooking(
    Trip trip,
    DateTime date,
    int guests,
  ) {
    final newBooking = Booking(
      id: DateTime.now().toString(),
      tripId: trip.id,
      tripTitle: trip.title,
      tripImageUrl: trip.imageUrl,
      date: date,
      guests: guests,
      totalPrice: trip.price * guests,
      bookingDate: DateTime.now(),
      status: BookingStatus.upcoming,
    );
    _bookings.insert(0, newBooking);
    notifyListeners();
  }

  void cancelBooking(String id) {
    final index = _bookings.indexWhere((booking) => booking.id == id);
    if (index >= 0) {
      final oldBooking = _bookings[index];
      _bookings[index] = Booking(
        id: oldBooking.id,
        tripId: oldBooking.tripId,
        tripTitle: oldBooking.tripTitle,
        tripImageUrl: oldBooking.tripImageUrl,
        date: oldBooking.date,
        guests: oldBooking.guests,
        totalPrice: oldBooking.totalPrice,
        status: BookingStatus.cancelled,
        bookingDate: oldBooking.bookingDate,
      );
      notifyListeners();
    }
  }
}
