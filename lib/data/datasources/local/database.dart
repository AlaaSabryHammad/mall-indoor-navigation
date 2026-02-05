import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/constants/app_constants.dart';

part 'database.g.dart';

// ============================================
// DRIFT TABLES DEFINITION
// ============================================

/// Products table
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get barcode => text().unique()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get quantity => integer()();
  TextColumn get aisleNumber => text()();
  TextColumn get shelfNumber => text()();
  RealColumn get locationX => real()();
  RealColumn get locationY => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Store maps table
class StoreMaps extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  RealColumn get width => real()();
  RealColumn get height => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Path nodes table (for A* pathfinding)
class PathNodes extends Table {
  TextColumn get id => text()();
  RealColumn get positionX => real()();
  RealColumn get positionY => real()();
  BoolColumn get isWalkable => boolean()();
  TextColumn get connectedNodeIds => text()(); // JSON array of connected node IDs

  @override
  Set<Column> get primaryKey => {id};
}

/// App database
@DriftDatabase(tables: [Products, StoreMaps, PathNodes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
        // Example:
        // if (from < 2) {
        //   await m.addColumn(products, products.newColumn);
        // }
      },
    );
  }

  // ============================================
  // PRODUCT QUERIES
  // ============================================

  /// Get all products
  Future<List<Product>> getAllProducts() => select(products).get();

  /// Get product by ID
  Future<Product?> getProductById(String id) {
    return (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  /// Get product by barcode
  Future<Product?> getProductByBarcode(String barcode) {
    return (select(products)..where((p) => p.barcode.equals(barcode))).getSingleOrNull();
  }

  /// Search products by name (case-insensitive)
  Future<List<Product>> searchProducts(String query) {
    return (select(products)
          ..where((p) => p.name.lower().like('%${query.toLowerCase()}%')))
        .get();
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String category) {
    return (select(products)..where((p) => p.category.equals(category))).get();
  }

  /// Get all unique categories
  Future<List<String>> getCategories() async {
    final query = selectOnly(products, distinct: true)..addColumns([products.category]);
    final results = await query.get();
    return results.map((row) => row.read(products.category)!).toList();
  }

  /// Get products in a specific area (for map optimization)
  Future<List<Product>> getProductsInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  }) {
    return (select(products)
          ..where((p) =>
              p.locationX.isBiggerOrEqualValue(minX) &
              p.locationX.isSmallerOrEqualValue(maxX) &
              p.locationY.isBiggerOrEqualValue(minY) &
              p.locationY.isSmallerOrEqualValue(maxY)))
        .get();
  }

  /// Get low stock products
  Future<List<Product>> getLowStockProducts() {
    return (select(products)
          ..where((p) => p.quantity.isSmallerThanValue(10) & p.quantity.isBiggerThanValue(0)))
        .get();
  }

  /// Insert product
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  /// Update product
  Future<bool> updateProduct(Product product) {
    return update(products).replace(product);
  }

  /// Delete product
  Future<int> deleteProduct(String id) {
    return (delete(products)..where((p) => p.id.equals(id))).go();
  }

  /// Update product quantity
  Future<int> updateProductQuantity(String id, int quantity) {
    return (update(products)..where((p) => p.id.equals(id))).write(
      ProductsCompanion(quantity: Value(quantity)),
    );
  }

  // ============================================
  // MAP QUERIES
  // ============================================

  /// Get current map (assumes single map for now)
  Future<StoreMap?> getCurrentMap() async {
    final maps = await select(storeMaps).get();
    return maps.isNotEmpty ? maps.first : null;
  }

  /// Insert map
  Future<int> insertMap(StoreMapsCompanion map) {
    return into(storeMaps).insert(map);
  }

  /// Update map
  Future<bool> updateMap(StoreMap map) {
    return update(storeMaps).replace(map);
  }

  /// Delete map
  Future<int> deleteMap(String id) {
    return (delete(storeMaps)..where((m) => m.id.equals(id))).go();
  }

  /// Get all maps
  Future<List<StoreMap>> getAllMaps() => select(storeMaps).get();

  // ============================================
  // PATH NODE QUERIES
  // ============================================

  /// Get all path nodes
  Future<List<PathNode>> getAllPathNodes() => select(pathNodes).get();

  /// Get path node by ID
  Future<PathNode?> getPathNodeById(String id) {
    return (select(pathNodes)..where((n) => n.id.equals(id))).getSingleOrNull();
  }

  /// Get walkable path nodes
  Future<List<PathNode>> getWalkablePathNodes() {
    return (select(pathNodes)..where((n) => n.isWalkable.equals(true))).get();
  }

  /// Get path nodes in area
  Future<List<PathNode>> getPathNodesInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  }) {
    return (select(pathNodes)
          ..where((n) =>
              n.positionX.isBiggerOrEqualValue(minX) &
              n.positionX.isSmallerOrEqualValue(maxX) &
              n.positionY.isBiggerOrEqualValue(minY) &
              n.positionY.isSmallerOrEqualValue(maxY)))
        .get();
  }

  /// Insert path node
  Future<int> insertPathNode(PathNodesCompanion node) {
    return into(pathNodes).insert(node);
  }

  /// Update path node
  Future<bool> updatePathNode(PathNode node) {
    return update(pathNodes).replace(node);
  }

  /// Delete path node
  Future<int> deletePathNode(String id) {
    return (delete(pathNodes)..where((n) => n.id.equals(id))).go();
  }

  /// Batch insert path nodes (for grid generation)
  Future<void> insertPathNodesBatch(List<PathNodesCompanion> nodes) async {
    await batch((batch) {
      batch.insertAll(pathNodes, nodes);
    });
  }
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseName));
    return NativeDatabase(file);
  });
}
