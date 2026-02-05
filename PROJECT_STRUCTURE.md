# 📁 Complete Project Structure

```
Mall_app/
│
├── lib/
│   │
│   ├── main.dart                                    # App entry point with MaterialApp
│   │
│   ├── core/                                        # Shared across all layers
│   │   ├── constants/
│   │   │   └── app_constants.dart                  # App-wide configuration values
│   │   ├── errors/
│   │   │   └── failures.dart                       # Base Failure class and implementations
│   │   ├── usecases/
│   │   │   └── usecase.dart                        # Base UseCase abstract classes
│   │   ├── utils/                                  # Helper functions
│   │   └── theme/                                  # App theming (future)
│   │
│   ├── domain/                                      # BUSINESS LOGIC (Pure Dart)
│   │   │
│   │   ├── entities/                               # Core business objects
│   │   │   ├── coordinate.dart                     # 2D map coordinate with distance calculations
│   │   │   ├── product.dart                        # Product with location, inventory, metadata
│   │   │   ├── path_node.dart                      # Walkable node for pathfinding
│   │   │   ├── store_map.dart                      # Store floor plan metadata
│   │   │   └── user_position.dart                  # User location with heading, accuracy
│   │   │
│   │   ├── repositories/                           # Repository contracts (interfaces)
│   │   │   ├── product_repository.dart             # Product CRUD operations
│   │   │   ├── pathfinding_repository.dart         # A* pathfinding contract
│   │   │   ├── map_repository.dart                 # Store map management
│   │   │   └── positioning_repository.dart         # User location tracking
│   │   │
│   │   └── usecases/                               # Business use cases (one action each)
│   │       ├── get_all_products.dart               # Fetch all products
│   │       ├── search_products.dart                # Fuzzy search products
│   │       ├── calculate_navigation_path.dart      # A* path calculation
│   │       ├── get_product_by_barcode.dart         # Scan product (future)
│   │       └── add_product.dart                    # Admin: add product (future)
│   │
│   ├── data/                                        # DATA IMPLEMENTATION
│   │   │
│   │   ├── datasources/
│   │   │   └── local/
│   │   │       └── database.dart                   # Drift database with tables & queries
│   │   │           # Tables: Products, StoreMaps, PathNodes
│   │   │           # Queries: CRUD, search, spatial queries
│   │   │
│   │   ├── models/                                 # Data models (Entity ↔ Database mappers)
│   │   │   ├── product_model.dart                  # Product entity ↔ DB row
│   │   │   ├── path_node_model.dart                # PathNode entity ↔ DB row
│   │   │   └── store_map_model.dart                # StoreMap entity ↔ DB row
│   │   │
│   │   └── repositories/                           # Repository implementations
│   │       ├── product_repository_impl.dart        # ProductRepository + fuzzy search
│   │       ├── pathfinding_repository_impl.dart    # A* algorithm implementation
│   │       ├── map_repository_impl.dart            # Map CRUD (future)
│   │       └── positioning_repository_impl.dart    # Simulated positioning (future)
│   │
│   └── presentation/                                # UI LAYER
│       │
│       ├── providers/                              # Riverpod state management
│       │   ├── database_provider.dart              # Database singleton, repositories
│       │   ├── product_provider.dart               # Product list, search state
│       │   └── navigation_provider.dart            # Navigation state, path, position
│       │
│       ├── screens/                                # Full-screen views
│       │   ├── home/
│       │   │   └── home_screen.dart                # Main screen: map + search + navigation
│       │   ├── search/
│       │   │   └── search_screen.dart              # Dedicated search (future)
│       │   ├── navigation/
│       │   │   └── navigation_screen.dart          # Full-screen navigation (future)
│       │   └── admin/
│       │       └── admin_screen.dart               # Admin panel: products, paths, map upload
│       │
│       └── widgets/                                # Reusable UI components
│           ├── map/
│           │   ├── interactive_store_map.dart      # InteractiveViewer map with zoom/pan
│           │   ├── map_painter.dart                # CustomPainter for paths & arrows
│           │   └── product_marker.dart             # Product location markers
│           ├── product/
│           │   ├── product_card.dart               # Product display card (future)
│           │   └── product_list_tile.dart          # Product in list (future)
│           ├── navigation/
│           │   ├── navigation_arrow.dart           # Animated direction arrow (future)
│           │   └── path_overlay.dart               # Path visualization (future)
│           └── common/
│               ├── product_search_bar.dart         # Search with autocomplete
│               ├── loading_indicator.dart          # Loading states (future)
│               └── error_widget.dart               # Error display (future)
│
├── assets/                                          # Static assets
│   ├── images/                                     # App icons, logos
│   ├── maps/                                       # Store layout images
│   │   └── store_map.png                          # Example: 2000x1500px floor plan
│   ├── icons/                                      # Custom icons
│   └── fonts/                                      # SF Pro fonts (Apple style)
│       ├── SF-Pro-Display-Regular.ttf
│       ├── SF-Pro-Display-Medium.ttf
│       ├── SF-Pro-Display-Semibold.ttf
│       └── SF-Pro-Display-Bold.ttf
│
├── test/                                            # Unit & widget tests
│   ├── domain/
│   │   ├── entities/
│   │   │   └── coordinate_test.dart                # Test distance calculations
│   │   └── usecases/
│   │       └── search_products_test.dart           # Test search logic
│   ├── data/
│   │   └── repositories/
│   │       └── product_repository_impl_test.dart   # Test repository with mocks
│   └── presentation/
│       └── widgets/
│           └── product_search_bar_test.dart        # Test search widget
│
├── integration_test/                                # End-to-end tests
│   └── app_test.dart                               # Full user flow tests
│
├── android/                                         # Android-specific code
│   ├── app/
│   │   └── build.gradle                            # Android config
│   └── gradle.properties                           # Gradle settings
│
├── ios/                                             # iOS-specific code
│   ├── Runner/
│   │   └── Info.plist                              # iOS config
│   └── Podfile                                      # iOS dependencies
│
├── web/                                             # Web support (optional)
│
├── pubspec.yaml                                     # Dependencies & assets
├── pubspec.lock                                     # Locked dependency versions
│
├── README.md                                        # Main documentation
├── ARCHITECTURE.md                                  # Architecture deep dive
├── QUICKSTART.md                                    # Quick setup guide
├── PROJECT_STRUCTURE.md                             # This file!
├── CHANGELOG.md                                     # Version history (future)
│
├── .gitignore                                       # Git ignore rules
├── .metadata                                        # Flutter metadata
├── analysis_options.yaml                            # Linter rules
│
└── build/                                           # Generated files (not in git)
    └── app/
        └── outputs/
            └── flutter-apk/
                └── app-release.apk                 # Production APK
```

---

## 📊 File Count by Layer

| Layer              | Files | Lines of Code (est.) |
|--------------------|-------|----------------------|
| Domain (Entities)  | 5     | ~500                 |
| Domain (Use Cases) | 5     | ~300                 |
| Data (Models)      | 3     | ~200                 |
| Data (Repos)       | 2     | ~1000 (A* algorithm) |
| Data (Database)    | 1     | ~400                 |
| Presentation       | 10    | ~1500                |
| **Total**          | ~26   | **~3900 LOC**        |

---

## 🎯 Key Files to Start With

If you're new to the project, read these files in order:

1. [README.md](README.md) - Overview and features
2. [QUICKSTART.md](QUICKSTART.md) - Get it running
3. [main.dart](lib/main.dart:1) - App entry point
4. [home_screen.dart](lib/presentation/screens/home/home_screen.dart:1) - Main UI
5. [product_provider.dart](lib/presentation/providers/product_provider.dart:1) - State management
6. [pathfinding_repository_impl.dart](lib/data/repositories/pathfinding_repository_impl.dart:1) - A* algorithm
7. [ARCHITECTURE.md](ARCHITECTURE.md) - Design patterns

---

## 📦 Generated Files (Not in Version Control)

These files are created by `build_runner`:

```
lib/
├── data/
│   └── datasources/
│       └── local/
│           └── database.g.dart         # Generated by Drift
│
└── [various]/
    └── *.g.dart                        # Generated by Riverpod/JSON
```

Run `dart run build_runner build` to generate these.

---

## 🗂️ Data Flow Through Layers

### Example: Searching for a Product

```
┌──────────────────────────────────────────────────────────────┐
│ User types "milk" in search bar                              │
│ [presentation/widgets/common/product_search_bar.dart]        │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Search query updates provider                                │
│ [presentation/providers/product_provider.dart]               │
│   → searchQueryProvider.state = "milk"                       │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Provider triggers use case                                   │
│ [domain/usecases/search_products.dart]                       │
│   → SearchProducts.call(SearchProductsParams("milk"))        │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Use case calls repository interface                          │
│ [domain/repositories/product_repository.dart]                │
│   → repository.searchProducts("milk")                        │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Repository implementation queries database                   │
│ [data/repositories/product_repository_impl.dart]             │
│   → database.getAllProducts()                                │
│   → fuzzy.search("milk") // Typo-tolerant search             │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Database queries SQLite                                      │
│ [data/datasources/local/database.dart]                       │
│   → SELECT * FROM products WHERE name LIKE '%milk%'          │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Results mapped to domain entities                            │
│ [data/models/product_model.dart]                             │
│   → List<Product>.from(rows.map((r) => r.toDomain()))        │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ Either<Failure, List<Product>> returned                      │
│ Back through use case → provider → widget                    │
└────────────────────────┬─────────────────────────────────────┘
                         │
                         ↓
┌──────────────────────────────────────────────────────────────┐
│ UI rebuilds with results                                     │
│ [presentation/widgets/common/product_search_bar.dart]        │
│   → ListView of matching products                            │
└──────────────────────────────────────────────────────────────┘
```

---

## 🏗️ Adding a New Feature Checklist

Example: Adding "Product Reviews"

### 1. Domain Layer
- [ ] Create `Review` entity in [lib/domain/entities/review.dart](lib/domain/entities/review.dart)
- [ ] Add `ReviewRepository` interface in [lib/domain/repositories/review_repository.dart](lib/domain/repositories/review_repository.dart)
- [ ] Create use cases: `GetReviews`, `AddReview` in [lib/domain/usecases/](lib/domain/usecases/)

### 2. Data Layer
- [ ] Add `Reviews` table in [lib/data/datasources/local/database.dart](lib/data/datasources/local/database.dart)
- [ ] Create `review_model.dart` in [lib/data/models/](lib/data/models/)
- [ ] Implement `ReviewRepositoryImpl` in [lib/data/repositories/](lib/data/repositories/)
- [ ] Run `build_runner` to generate code

### 3. Presentation Layer
- [ ] Add `reviewProvider` in [lib/presentation/providers/](lib/presentation/providers/)
- [ ] Create `ReviewsList` widget in [lib/presentation/widgets/product/](lib/presentation/widgets/product/)
- [ ] Add to product detail screen

### 4. Testing
- [ ] Unit test `Review` entity
- [ ] Unit test `GetReviews` use case
- [ ] Integration test `ReviewRepositoryImpl`
- [ ] Widget test `ReviewsList`

---

## 🔍 Finding Code

### By Feature

| Feature | Files |
|---------|-------|
| **Product Search** | [product_search_bar.dart](lib/presentation/widgets/common/product_search_bar.dart:1), [search_products.dart](lib/domain/usecases/search_products.dart:1), [product_repository_impl.dart](lib/data/repositories/product_repository_impl.dart:52) |
| **Navigation** | [navigation_provider.dart](lib/presentation/providers/navigation_provider.dart:1), [calculate_navigation_path.dart](lib/domain/usecases/calculate_navigation_path.dart:1), [pathfinding_repository_impl.dart](lib/data/repositories/pathfinding_repository_impl.dart:60) |
| **Map Display** | [interactive_store_map.dart](lib/presentation/widgets/map/interactive_store_map.dart:1), [map_painter.dart](lib/presentation/widgets/map/map_painter.dart:1) |
| **Admin Panel** | [admin_screen.dart](lib/presentation/screens/admin/admin_screen.dart:1) |
| **Database** | [database.dart](lib/data/datasources/local/database.dart:1) |

### By Technology

| Tech | Usage |
|------|-------|
| **Riverpod** | All [lib/presentation/providers/](lib/presentation/providers/) files |
| **Drift** | [database.dart](lib/data/datasources/local/database.dart:1), all [lib/data/models/](lib/data/models/) |
| **CustomPaint** | [map_painter.dart](lib/presentation/widgets/map/map_painter.dart:1) |
| **InteractiveViewer** | [interactive_store_map.dart](lib/presentation/widgets/map/interactive_store_map.dart:1) |
| **A\*** | [pathfinding_repository_impl.dart](lib/data/repositories/pathfinding_repository_impl.dart:60) |

---

## 📈 Metrics

- **Total Packages**: 25+
- **Clean Architecture Layers**: 3 (Domain, Data, Presentation)
- **State Management**: Riverpod (6 providers)
- **Database Tables**: 3 (Products, StoreMaps, PathNodes)
- **Screens**: 2 (Home, Admin)
- **Widgets**: 10+ reusable components
- **Use Cases**: 5+ business operations
- **Repositories**: 4 interfaces + implementations

---

## 🎓 Code Quality Standards

All files follow:
- ✅ Clean Architecture principles
- ✅ SOLID principles
- ✅ Dart style guide
- ✅ Meaningful naming
- ✅ Comprehensive comments
- ✅ Error handling with Either<Failure, Success>
- ✅ Immutable entities (Equatable)
- ✅ Type-safe database queries

---

**This structure is designed for maintainability and scalability from MVP to production.**
