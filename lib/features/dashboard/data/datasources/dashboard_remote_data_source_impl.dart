// lib/features/dashboard/data/datasources/dashboard_remote_data_source_impl.dart

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../models/booking_model.dart';
import '../models/arena_model.dart';
import '../models/special_offer_model.dart';
import 'dashboard_remote_data_source.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;

  DashboardRemoteDataSourceImpl({
    required this.apiClient,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BookingModel>>> fetchUpcomingBookings() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/bookings/upcoming');
        final List<BookingModel> bookings = (response.data as List)
            .map((data) => BookingModel.fromJson(data))
            .toList();
        return Right(bookings);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, List<ArenaModel>>> fetchArenas() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/arenas');
        final List<ArenaModel> arenas = (response.data as List)
            .map((data) => ArenaModel.fromJson(data))
            .toList();
        return Right(arenas);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, List<ArenaModel>>> fetchFeaturedArenas() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/arenas/featured');
        final List<ArenaModel> featuredArenas = (response.data as List)
            .map((data) => ArenaModel.fromJson(data))
            .toList();
        return Right(featuredArenas);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> fetchRecentBookings() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/bookings/recent');
        final List<BookingModel> bookings = (response.data as List)
            .map((data) => BookingModel.fromJson(data))
            .toList();
        return Right(bookings);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, List<ArenaModel>>> fetchFavoriteArenas() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/arenas/favorites');
        final List<ArenaModel> favoriteArenas = (response.data as List)
            .map((data) => ArenaModel.fromJson(data))
            .toList();
        return Right(favoriteArenas);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, List<SpecialOfferModel>>> fetchSpecialOffers() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiClient.get('/special_offers');
        final List<SpecialOfferModel> specialOffers = (response.data as List)
            .map((data) => SpecialOfferModel.fromJson(data))
            .toList();
        return Right(specialOffers);
      } on DioException catch (e) {
        return Left(ApiFailure(e.message.toString()));
      }
    } else {
      return Left(ApiFailure('No internet connection.'));
    }
  }
}
