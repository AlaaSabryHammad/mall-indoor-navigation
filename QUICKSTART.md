# 🚀 Quick Start Guide

Get the app running in 5 minutes!

---

## Prerequisites

✅ Flutter SDK 3.5.0 or higher
✅ Dart SDK 3.5.0 or higher
✅ Android Studio or VS Code with Flutter extension
✅ Physical device or emulator

Check your Flutter installation:
```bash
flutter doctor
```

---

## Step-by-Step Setup

### 1️⃣ **Clone & Install**

```bash
cd Mall_app
flutter pub get
```

### 2️⃣ **Generate Code**

The app uses code generation for Drift (database) and Riverpod (state management):

```bash
dart run build_runner build --delete-conflicting-outputs
```

This will generate:
- `database.g.dart` - Database queries
- `*.g.dart` - JSON serialization

### 3️⃣ **Add Assets**

Create a sample store map or use a placeholder:

```bash
# Create assets directory (already exists)
mkdir -p assets/maps

# Add your store layout image
# Name it: store_map.png
# Recommended size: 2000x1500 pixels
```

### 4️⃣ **Run the App**

```bash
flutter run
```

Or in VS Code:
- Press `F5`
- Select your device
- Wait for the app to launch

---

## First Time Usage

### Customer Mode (Default)

1. **Search for a product** - Type in the search bar
2. **Select a product** - Tap on a search result
3. **Navigate** - Tap "Navigate to this product"
4. **Follow the arrow** - Blue arrow points to destination

### Admin Mode

1. Tap the **orange admin button** (bottom right)
2. Default password: `admin123` (change this in production!)
3. Go to **"Paths" tab**
4. Tap **"Generate Path Grid"** to create walkable nodes
5. Go to **"Products" tab**
6. Tap **"Add Product"** to add your first product
7. Tap on the map to set product location

---

## Testing the Navigation

### Add Sample Data

Run this to add test products:

```dart
// Create a seed script: lib/core/utils/seed_data.dart

Future<void> seedDatabase(AppDatabase db) async {
  final products = [
    Product(
      id: 'p1',
      name: 'Milk',
      barcode: '123456789',
      category: 'Food',
      description: 'Fresh milk',
      quantity: 50,
      aisleNumber: 'A1',
      shelfNumber: 'S3',
      location: Coordinate(x: 300, y: 400),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    // Add more products...
  ];

  for (final product in products) {
    await db.insertProduct(product.toCompanion());
  }
}
```

Call this function on first launch in `main.dart`.

---

## Project Structure Overview

```
Mall_app/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── core/                        # Shared utilities
│   │   ├── constants/
│   │   ├── errors/
│   │   └── usecases/
│   ├── domain/                      # Business logic
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── data/                        # Data implementation
│   │   ├── datasources/
│   │   ├── models/
│   │   └── repositories/
│   └── presentation/                # UI
│       ├── providers/
│       ├── screens/
│       └── widgets/
├── assets/
│   ├── images/
│   └── maps/
├── test/                            # Unit tests
├── integration_test/                # Integration tests
├── pubspec.yaml                     # Dependencies
├── README.md                        # Full documentation
├── ARCHITECTURE.md                  # Architecture deep dive
└── QUICKSTART.md                    # This file!
```

---

## Common Issues & Solutions

### ❌ **"FileSystemException: Cannot open file" (database)**

**Solution:** The database is created automatically on first launch. If you see this error:
```dart
// Delete app data and restart
flutter clean
flutter pub get
flutter run
```

### ❌ **"build_runner" not generating files**

**Solution:**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### ❌ **"Map image not found"**

**Solution:** Add a placeholder in [interactive_store_map.dart](lib/presentation/widgets/map/interactive_store_map.dart:60):
```dart
if (!File(widget.mapImagePath).existsSync()) {
  return Container(
    color: Colors.grey[200],
    child: Center(child: Text('No map uploaded')),
  );
}
```

### ❌ **"No path found" error**

**Solution:** You need to generate the path grid first:
1. Go to Admin Mode
2. Paths tab
3. Tap "Generate Path Grid"
4. Wait for completion message

### ❌ **Products not showing on map**

**Solution:** Check product coordinates are within map bounds:
```dart
// In admin screen, validate coordinates
if (location.x > mapWidth || location.y > mapHeight) {
  showError('Location outside map bounds');
}
```

---

## Development Workflow

### Making Changes

1. **Edit code** in appropriate layer (domain/data/presentation)
2. **Run build_runner** if you modify Drift tables or Riverpod providers
3. **Hot reload** - Press `r` in terminal or click hot reload in IDE
4. **Hot restart** - Press `R` if hot reload doesn't work

### Adding a New Feature

Example: Add product categories filter

```dart
// 1. Domain - Add use case (if needed)
class GetProductsByCategory implements UseCase<...> {
  // Implementation
}

// 2. Data - Already implemented in repository

// 3. Presentation - Add provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// 4. UI - Add filter dropdown
DropdownButton<String>(
  value: ref.watch(selectedCategoryProvider),
  items: categories.map((cat) => DropdownMenuItem(
    value: cat,
    child: Text(cat),
  )).toList(),
  onChanged: (value) {
    ref.read(selectedCategoryProvider.notifier).state = value;
  },
)
```

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/domain/usecases/search_products_test.dart

# With coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Performance Tips

### 1. Use DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

Open in browser, connect to your app, and monitor:
- Widget rebuilds
- Memory usage
- Frame rendering time

### 2. Profile Before Optimizing

```bash
flutter run --profile
```

This enables performance profiling without debug overhead.

### 3. Check Build Mode

Never measure performance in **debug mode**! Use:
- `--profile` for profiling
- `--release` for production performance

---

## Building for Production

### Android APK

```bash
# Debug APK (for testing)
flutter build apk --debug

# Release APK (for production)
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Recommended)

```bash
flutter build appbundle --release
```

Upload to Google Play Console.

### iOS IPA

```bash
# Requires macOS and Xcode
flutter build ios --release

# Open Xcode to create archive
open ios/Runner.xcworkspace
```

Then:
1. Product → Archive
2. Distribute App
3. Upload to App Store Connect

---

## Debugging Tips

### Print Statements

```dart
import 'package:flutter/foundation.dart';

debugPrint('Product selected: ${product.name}');
```

### Breakpoints

In VS Code:
1. Click left of line number to set breakpoint
2. Press F5 to run in debug mode
3. Execution pauses at breakpoint
4. Inspect variables in debug panel

### Riverpod DevTools

```dart
// Add to main.dart
ProviderScope(
  observers: [ProviderLogger()],
  child: MyApp(),
)

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('Provider updated: ${provider.name ?? provider.runtimeType}');
  }
}
```

---

## Next Steps

1. ✅ Read [README.md](README.md) for full feature list
2. ✅ Study [ARCHITECTURE.md](ARCHITECTURE.md) for design patterns
3. ✅ Explore code starting from [main.dart](lib/main.dart:1)
4. ✅ Run the app and test navigation
5. ✅ Add your own products and paths
6. ✅ Customize UI theme to match your brand
7. ✅ Integrate real positioning system (BLE/WiFi)
8. ✅ Deploy to app stores!

---

## Useful Commands Cheat Sheet

```bash
# Clean build
flutter clean && flutter pub get

# Update dependencies
flutter pub upgrade

# Analyze code quality
flutter analyze

# Format code
dart format lib/

# Generate code
flutter pub run build_runner build

# Run tests with coverage
flutter test --coverage

# Build release APK
flutter build apk --release

# Check outdated packages
flutter pub outdated
```

---

## Getting Help

- **GitHub Issues** - Report bugs or request features
- **Stack Overflow** - Tag with `flutter` and `dart`
- **Flutter Discord** - Join #help channel
- **Code Comments** - Most complex code has explanatory comments

---

## Learning Resources

### Flutter

- [Flutter Documentation](https://docs.flutter.dev/)
- [Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Cookbook](https://docs.flutter.dev/cookbook)

### Clean Architecture

- [Uncle Bob's Blog](https://blog.cleancoder.com/)
- [Flutter Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)

### Riverpod

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Examples](https://github.com/rrousselGit/riverpod)

### Drift

- [Drift Documentation](https://drift.simonbinder.eu/)
- [Drift Examples](https://github.com/simolus3/drift)

---

**Happy coding! 🎉**

If you have questions, check the README.md or open an issue on GitHub.
