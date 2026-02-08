enum BookingStatus { upcoming, completed, cancelled }

class Booking {
  final String id;
  final String tripId;
  final String tripTitle;
  final String tripImageUrl;
  final DateTime date;
  final int guests;
  final double totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.tripId,
    required this.tripTitle,
    required this.tripImageUrl,
    required this.date,
    required this.guests,
    required this.totalPrice,
    this.status = BookingStatus.upcoming,
    required this.bookingDate,
  });
}
