import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/local/database.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/pathfinding_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/pathfinding_repository.dart';

/// Database provider - singleton
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// UUID generator provider
final uuidProvider = Provider<Uuid>((ref) {
  return const Uuid();
});

/// Product repository provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ProductRepositoryImpl(database);
});

/// Pathfinding repository provider
final pathfindingRepositoryProvider = Provider<PathfindingRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final uuid = ref.watch(uuidProvider);
  return PathfindingRepositoryImpl(database, uuid);
});
