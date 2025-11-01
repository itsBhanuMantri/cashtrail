import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/remote/dio_client.dart';
import 'db/database.dart';
import 'repositories/category_repository.dart';
import 'repositories/ledger_repository.dart';

/// Service Locator - used to get instances of services
/// sl is short for service locator
/// Example:
/// ```dart
/// final dio = sl.get<Dio>();
/// final response = await dio.get('https://api.example.com');
/// ```
final sl = GetIt.instance;

void registerServices() {
  sl.registerLazySingleton<Dio>(() => DioClient().dio);
  sl.registerLazySingleton<Database>(() => Database());
  sl.registerLazySingleton<LedgerRepository>(() => LedgerRepository());
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
}
