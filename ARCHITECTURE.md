# 🏗️ Architecture Deep Dive

## Clean Architecture Principles

This application follows Uncle Bob's Clean Architecture with strict layer separation:

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                    │
│  ┌─────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │
│  │ Screens │→ │ Widgets  │→ │ Providers│→ │ Riverpod│ │
│  └─────────┘  └──────────┘  └──────────┘  └─────────┘ │
└────────────────────────┬────────────────────────────────┘
                         │ Depends on
                         ↓
┌─────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                        │
│  ┌─────────┐  ┌────────────┐  ┌────────────────────┐  │
│  │Entities │  │Repositories│  │    Use Cases        │  │
│  │(Pure    │  │(Interfaces)│  │(Business Logic)     │  │
│  │Objects) │  └────────────┘  └────────────────────┘  │
│  └─────────┘        ↑                                   │
└─────────────────────┼───────────────────────────────────┘
                      │ Implemented by
                      ↓
┌─────────────────────────────────────────────────────────┐
│                      DATA LAYER                          │
│  ┌────────────┐  ┌──────────┐  ┌───────────────────┐  │
│  │Repositories│  │  Models  │  │   Data Sources     │  │
│  │(Impl)      │  │(Mappers) │  │ (Drift Database)   │  │
│  └────────────┘  └──────────┘  └───────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### **Dependency Rule**

1. **Presentation** depends on **Domain**
2. **Data** depends on **Domain**
3. **Domain** depends on NOTHING (pure Dart)

This ensures:
- Business logic is testable without Flutter
- Easy to swap data sources (Drift → Firebase)
- Framework-independent core

---

## Data Flow

### **Reading Data (Query)**

```
User Interaction (Widget)
    ↓
Provider (Riverpod)
    ↓
Use Case (Domain)
    ↓
Repository Interface (Domain)
    ↓
Repository Implementation (Data)
    ↓
Data Source (Drift)
    ↓
Database Query
    ↓
Model → Entity (Mapping)
    ↓
Either<Failure, Entity>
    ↓
Provider updates state
    ↓
Widget rebuilds
```

### **Writing Data (Command)**

```
User Action (Button Tap)
    ↓
Provider.notifier method
    ↓
Use Case with parameters
    ↓
Repository Implementation
    ↓
Entity → Model (Mapping)
    ↓
Data Source insert/update
    ↓
Database Write
    ↓
Either<Failure, Success>
    ↓
Provider updates state
    ↓
UI reflects change
```

---

## State Management Strategy

### **Provider Types Used**

1. **Provider** - Immutable dependencies (database, repositories)
```dart
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
```

2. **StateProvider** - Simple mutable state (filters, selections)
```dart
final searchQueryProvider = StateProvider<String>((ref) => '');
```

3. **StateNotifierProvider** - Complex state with business logic
```dart
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>(...);
```

4. **FutureProvider** - Async computed state
```dart
final searchedProductsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  // ...
});
```

### **State Scoping**

- **Global** - Database, repositories (singleton)
- **Screen-level** - Navigation state, selected product
- **Widget-level** - Form inputs, UI state

### **Performance Optimizations**

1. **Fine-grained reactivity** - Widgets only rebuild when their specific state changes
2. **Selector pattern** - `ref.watch(provider.select((state) => state.field))`
3. **ProviderScope override** - For testing with mocks
4. **Auto-dispose** - Providers clean up when no longer watched

---

## Database Design Patterns

### **Repository Pattern**

Abstracts data source details from business logic:

```dart
// Domain (interface)
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
}

// Data (implementation)
class ProductRepositoryImpl implements ProductRepository {
  final AppDatabase database;

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await database.getAllProducts();
      return Right(products.map((p) => p.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
```

### **Entity-Model Separation**

**Entity** (Domain) - Pure business object
```dart
class Product extends Equatable {
  final String id;
  final String name;
  final Coordinate location;
  // Business logic methods
  bool get isInStock => quantity > 0;
}
```

**Model** (Data) - Database representation
```dart
extension ProductModel on Product {
  ProductsCompanion toCompanion() {
    return ProductsCompanion(
      id: Value(id),
      locationX: Value(location.x),
      locationY: Value(location.y),
    );
  }
}
```

### **Drift Code Generation**

Drift generates type-safe database code from annotations:

```dart
// Define table
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  @override
  Set<Column> get primaryKey => {id};
}

// Generated: ProductsCompanion, Product class, queries
```

Run: `dart run build_runner build`

---

## Pathfinding Algorithm Details

### **A\* Pseudocode**

```
function A*(start, goal):
    openSet = {start}
    gScore[start] = 0
    fScore[start] = heuristic(start, goal)

    while openSet is not empty:
        current = node in openSet with lowest fScore

        if current == goal:
            return reconstruct_path(cameFrom, current)

        openSet.remove(current)
        closedSet.add(current)

        for neighbor in current.neighbors:
            if neighbor in closedSet:
                continue

            tentative_gScore = gScore[current] + distance(current, neighbor)

            if tentative_gScore < gScore[neighbor]:
                cameFrom[neighbor] = current
                gScore[neighbor] = tentative_gScore
                fScore[neighbor] = gScore[neighbor] + heuristic(neighbor, goal)

                if neighbor not in openSet:
                    openSet.add(neighbor)

    return failure
```

### **Heuristic Function**

We use **Euclidean distance** (straight-line distance):

```dart
double heuristic(Coordinate a, Coordinate b) {
  final dx = a.x - b.x;
  final dy = a.y - b.y;
  return (dx * dx + dy * dy).abs(); // Squared distance (no sqrt needed)
}
```

**Why squared distance?**
- Faster computation (avoids expensive sqrt)
- Preserves ordering (smallest distance still smallest)
- Admissible heuristic (never overestimates)

### **Path Smoothing** (Future Enhancement)

Current path is jagged (follows grid). To smooth:

```dart
List<Coordinate> smoothPath(List<Coordinate> path) {
  // Catmull-Rom spline interpolation
  final smoothed = <Coordinate>[];
  for (int i = 0; i < path.length - 1; i++) {
    final p0 = path[max(0, i - 1)];
    final p1 = path[i];
    final p2 = path[i + 1];
    final p3 = path[min(path.length - 1, i + 2)];

    for (double t = 0; t <= 1; t += 0.1) {
      smoothed.add(catmullRom(p0, p1, p2, p3, t));
    }
  }
  return smoothed;
}
```

---

## UI Performance Optimizations

### **1. Viewport Culling**

Only render products visible on screen:

```dart
List<Product> getVisibleProducts(Rect viewport, List<Product> allProducts) {
  return allProducts.where((product) {
    return viewport.contains(Offset(product.location.x, product.location.y));
  }).toList();
}
```

Reduces rendering from 1000+ widgets to ~20-50.

### **2. RepaintBoundary**

Isolate expensive repaints:

```dart
RepaintBoundary(
  child: CustomPaint(
    painter: NavigationPathPainter(path),
  ),
)
```

Prevents full map redraw when only path changes.

### **3. Const Constructors**

Maximize use of const widgets:

```dart
const ProductMarker(...) // Won't rebuild unnecessarily
```

### **4. Keys for Lists**

Stable identity for list items:

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return ProductTile(
      key: ValueKey(products[index].id),
      product: products[index],
    );
  },
)
```

Flutter can efficiently update/remove items.

### **5. Lazy Loading**

Load data on demand:

```dart
final productsProvider = FutureProvider.family<List<Product>, int>((ref, page) async {
  // Load products page by page
  return repository.getProducts(page: page, limit: 50);
});
```

---

## Error Handling Strategy

### **Either Type**

All repository methods return `Either<Failure, Success>`:

```dart
Future<Either<Failure, Product>> getProduct(String id) async {
  try {
    final product = await database.getProductById(id);
    if (product == null) {
      return Left(ProductNotFoundFailure('Product not found'));
    }
    return Right(product.toDomain());
  } catch (e) {
    return Left(DatabaseFailure(e.toString()));
  }
}
```

### **Handling in UI**

```dart
final result = await ref.read(productRepositoryProvider).getProduct(id);

result.fold(
  (failure) {
    // Show error to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(failure.message)),
    );
  },
  (product) {
    // Use product
    setState(() => _product = product);
  },
);
```

### **Failure Types**

All failures extend base `Failure` class:

- `DatabaseFailure` - DB errors
- `ProductNotFoundFailure` - Entity not found
- `PathNotFoundFailure` - No route available
- `ValidationFailure` - Invalid input
- `AuthenticationFailure` - Admin auth failed

Enables exhaustive error handling.

---

## Testing Architecture

### **Test Pyramid**

```
         ╱╲
        ╱  ╲
       ╱ E2E ╲       ← Few (expensive, slow)
      ╱──────╲
     ╱ Widget ╲      ← Some (medium cost)
    ╱──────────╲
   ╱   Unit    ╲    ← Many (cheap, fast)
  ╱──────────────╲
```

### **Unit Tests** (Domain Layer)

Test pure business logic:

```dart
test('Product.isInStock returns true when quantity > 0', () {
  final product = Product(quantity: 5, ...);
  expect(product.isInStock, isTrue);
});

test('A* finds shortest path', () {
  final path = calculatePath(start, end, nodes);
  expect(path.waypoints.length, greaterThan(0));
});
```

**Run:** `flutter test test/domain`

### **Widget Tests** (Presentation Layer)

Test UI components:

```dart
testWidgets('Search bar filters products', (tester) async {
  await tester.pumpWidget(ProviderScope(
    child: MaterialApp(home: ProductSearchBar()),
  ));

  await tester.enterText(find.byType(TextField), 'milk');
  await tester.pumpAndSettle();

  expect(find.text('Milk'), findsOneWidget);
});
```

**Run:** `flutter test test/presentation`

### **Integration Tests** (Data Layer)

Test repository implementations with real database:

```dart
testWidgets('ProductRepository saves and retrieves product', (tester) async {
  final db = AppDatabase();
  final repository = ProductRepositoryImpl(db);

  final product = Product(...);
  await repository.addProduct(product);

  final result = await repository.getProductById(product.id);
  expect(result.isRight(), isTrue);
});
```

### **Mocking with Riverpod**

Override providers for testing:

```dart
testWidgets('HomeScreen displays products', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        productRepositoryProvider.overrideWithValue(MockProductRepository()),
      ],
      child: MaterialApp(home: HomeScreen()),
    ),
  );

  expect(find.byType(ProductMarker), findsWidgets);
});
```

---

## Migration Strategy

### **Database Migrations**

Drift supports migrations for schema changes:

```dart
@override
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Version 1 → 2: Add image_url column
        await m.addColumn(products, products.imageUrl);
      }
      if (from < 3) {
        // Version 2 → 3: Create new table
        await m.createTable(reviews);
      }
    },
  );
}
```

### **Testing Migrations**

```dart
test('Migration from v1 to v2 adds image_url column', () async {
  final schema = await GeneratedDatabase.createMigrationValidator(...);

  // Create v1 database
  await schema.startAt(1);

  // Run migration to v2
  await schema.migrateAndValidate(connection, 2);

  // Verify schema
  expect(schema.hasColumn('products', 'image_url'), isTrue);
});
```

---

## Deployment Checklist

### **Pre-Release**

- [ ] Run all tests: `flutter test`
- [ ] Check code coverage: `flutter test --coverage`
- [ ] Analyze code: `flutter analyze`
- [ ] Update version in pubspec.yaml
- [ ] Update CHANGELOG.md
- [ ] Generate signed APK/IPA

### **Production Considerations**

1. **Change admin password** - Remove hardcoded default
2. **Enable ProGuard** (Android) - Code obfuscation
3. **Enable Bitcode** (iOS) - App thinning
4. **Add Crashlytics** - Error reporting
5. **Performance monitoring** - Firebase Performance
6. **Analytics** - Firebase Analytics / Mixpanel
7. **A/B testing** - Firebase Remote Config

### **App Store Optimization**

- Screenshots showing key features
- Demo video of navigation in action
- Keywords: "indoor navigation", "store finder", "mall map"
- Privacy policy (data collection disclosure)

---

## Performance Benchmarks

### **Target Metrics**

| Metric | Target | Current |
|--------|--------|---------|
| App startup | < 2s | TBD |
| Search latency | < 100ms | TBD |
| Path calculation | < 500ms | TBD |
| Map FPS | 60fps | TBD |
| Memory usage | < 200MB | TBD |

### **Profiling Tools**

1. **Flutter DevTools** - CPU, memory, rendering profiler
2. **Dart Observatory** - Memory leaks, allocations
3. **Android Profiler** - Native memory, battery
4. **Xcode Instruments** - Time profiler, leaks

### **Common Bottlenecks**

1. **Database queries** - Add indexes, use EXPLAIN
2. **Widget rebuilds** - Use `const`, `select()`, `RepaintBoundary`
3. **Image loading** - Use `cached_network_image`, compress assets
4. **Pathfinding** - Cache common paths, use spatial indexing

---

## Security Best Practices

### **1. Secure Storage**

Never store secrets in plain text:

```dart
// BAD
final password = 'admin123';

// GOOD
final storage = FlutterSecureStorage();
await storage.write(key: 'admin_pw', value: hashedPassword);
```

### **2. SQL Injection Prevention**

Drift uses parameterized queries (safe by default):

```dart
// Drift automatically escapes inputs
final products = await (select(products)
  ..where((p) => p.name.equals(userInput))).get();
```

### **3. Input Validation**

Always validate user input:

```dart
Future<Either<Failure, Product>> addProduct(Product product) async {
  if (product.name.isEmpty) {
    return Left(ValidationFailure('Name cannot be empty'));
  }
  if (!product.location.isWithinBounds(mapWidth, mapHeight)) {
    return Left(InvalidCoordinatesFailure('Location out of bounds'));
  }
  // ...
}
```

### **4. HTTPS Only**

When adding cloud sync:

```dart
// Force HTTPS
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  validateStatus: (status) => status! < 500,
));
```

---

## Monitoring & Observability

### **Logging Strategy**

```dart
class Logger {
  static void info(String message) {
    debugPrint('[INFO] $message');
    // Send to analytics in production
  }

  static void error(String message, dynamic error, StackTrace? stack) {
    debugPrint('[ERROR] $message: $error');
    // Send to Crashlytics
  }
}
```

### **Analytics Events**

Track key user actions:

```dart
enum AnalyticsEvent {
  productSearched,
  navigationStarted,
  navigationCompleted,
  productNotFound,
  pathCalculationFailed,
}

void logEvent(AnalyticsEvent event, Map<String, dynamic> params) {
  FirebaseAnalytics.instance.logEvent(
    name: event.name,
    parameters: params,
  );
}
```

### **Health Checks**

Monitor app health:

```dart
class AppHealthMonitor {
  Future<HealthStatus> checkHealth() async {
    final dbConnected = await _checkDatabase();
    final pathfindingWorking = await _checkPathfinding();

    return HealthStatus(
      isHealthy: dbConnected && pathfindingWorking,
      details: {...},
    );
  }
}
```

---

## Internationalization (i18n)

### **Setup**

Add to pubspec.yaml:
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
```

Generate translations:
```dart
// lib/l10n/app_en.arb
{
  "searchProducts": "Search products",
  "navigateToProduct": "Navigate to this product",
  "@navigateToProduct": {
    "description": "Button to start navigation"
  }
}
```

### **Usage**

```dart
Text(AppLocalizations.of(context)!.searchProducts)
```

### **Supported Languages** (Future)

- English (en)
- Arabic (ar) - RTL support
- Spanish (es)
- French (fr)

---

## Contributing Guidelines

### **Code Style**

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart):

1. Use trailing commas for formatting
2. Prefer const constructors
3. Use meaningful variable names
4. Add dartdoc comments for public APIs

### **Commit Messages**

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add voice search support
fix: resolve pathfinding infinite loop
docs: update architecture diagram
refactor: extract ProductCard widget
test: add unit tests for A* algorithm
```

### **Pull Request Process**

1. Create feature branch: `git checkout -b feature/voice-search`
2. Make changes following Clean Architecture
3. Add tests for new features
4. Update documentation
5. Run `flutter analyze` and fix issues
6. Submit PR with clear description

---

**This architecture is designed to scale from MVP to enterprise-level system.**
