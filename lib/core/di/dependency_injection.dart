import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/data/datasources/movie_api_service.dart';
import '../../features/data/datasources/movie_local_datasource.dart';
import '../../features/data/repository/movie_repository.dart';
import '../../features/presentation/cubit/movie_list_cubit/movies_list_cubit.dart';
import '../../features/presentation/cubit/movie_details_cubit/movie_details_cubit.dart';
import '../network/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  log('Setting up service locator');

  await Hive.initFlutter();
  await Hive.openBox('movies_box');
  await Hive.openBox('movie_details_box');

  final dio = DioFactory.getDio();
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<MovieApiService>(() => MovieApiService(getIt<Dio>()));

  getIt.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(getIt<MovieApiService>(), getIt<MovieLocalDataSource>()));

  getIt.registerFactory<MoviesListCubit>(() => MoviesListCubit(getIt<MovieRepository>()));

  getIt.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(getIt<MovieRepository>()));

  log('Service locator setup complete');
}
