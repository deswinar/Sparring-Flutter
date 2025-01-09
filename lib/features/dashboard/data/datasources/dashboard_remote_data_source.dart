import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/booking_model.dart';
import '../models/arena_model.dart';
import '../models/special_offer_model.dart';

abstract class DashboardRemoteDataSource {
  // Fetch upcoming bookings for the user
  Future<Either<Failure, List<BookingModel>>> fetchUpcomingBookings();

  // Fetch all arenas
  Future<Either<Failure, List<ArenaModel>>> fetchArenas();

  // Fetch featured arenas (could be a special category or promotion)
  Future<Either<Failure, List<ArenaModel>>> fetchFeaturedArenas();

  // Fetch recent bookings (could be based on user's activity)
  Future<Either<Failure, List<BookingModel>>> fetchRecentBookings();

  // Fetch favorite arenas for the user
  Future<Either<Failure, List<ArenaModel>>> fetchFavoriteArenas();

  // Fetch special offers like discount banners
  Future<Either<Failure, List<SpecialOfferModel>>> fetchSpecialOffers();
}
