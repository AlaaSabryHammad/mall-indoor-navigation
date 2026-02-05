/// Application-wide constants
class AppConstants {
  AppConstants._();

  // ============================================
  // DATABASE
  // ============================================
  static const String databaseName = 'mall_navigation.db';
  static const int databaseVersion = 1;

  // ============================================
  // MAP SETTINGS
  // ============================================
  static const double minZoomScale = 0.5;
  static const double maxZoomScale = 4.0;
  static const double defaultZoomScale = 1.0;

  // Default map size (will be overridden by actual image dimensions)
  static const double defaultMapWidth = 2000.0;
  static const double defaultMapHeight = 1500.0;

  // ============================================
  // PATHFINDING
  // ============================================
  // Grid size for pathfinding nodes (in pixels)
  // Smaller = more accurate but slower
  // 50px is good balance for indoor navigation
  static const double pathNodeSpacing = 50.0;

  // Heuristic weight for A* (1.0 = optimal, >1.0 = faster but less optimal)
  static const double aStarHeuristicWeight = 1.0;

  // Maximum iterations to prevent infinite loops
  static const int maxPathfindingIterations = 10000;

  // ============================================
  // NAVIGATION
  // ============================================
  // Distance threshold to consider "arrived" (in pixels on map)
  static const double arrivalThreshold = 30.0;

  // How often to update position during navigation (milliseconds)
  static const int navigationUpdateInterval = 100;

  // Arrow size
  static const double navigationArrowSize = 40.0;

  // ============================================
  // SEARCH
  // ============================================
  static const int searchResultsLimit = 50;
  static const int autocompleteMinChars = 2;
  static const int autocompleteResultsLimit = 10;

  // Fuzzy search threshold (0.0 = exact match, 1.0 = very loose)
  static const double fuzzySearchThreshold = 0.6;

  // ============================================
  // PERFORMANCE
  // ============================================
  // Maximum products to show on map at once
  static const int maxVisibleMarkers = 100;

  // Debounce time for search (milliseconds)
  static const int searchDebounceMs = 300;

  // Cache duration for images
  static const Duration imageCacheDuration = Duration(days: 30);

  // ============================================
  // ADMIN
  // ============================================
  static const String adminPasswordKey = 'admin_password';
  static const String defaultAdminPassword = 'admin123'; // Change in production!

  // ============================================
  // UI
  // ============================================
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // ============================================
  // PRODUCT MARKERS
  // ============================================
  static const double markerSize = 24.0;
  static const double selectedMarkerSize = 32.0;

  // ============================================
  // POSITIONING (Future Integration)
  // ============================================
  // BLE beacon RSSI threshold
  static const int bleRssiThreshold = -80;

  // WiFi scan interval
  static const Duration wifiScanInterval = Duration(seconds: 2);

  // Kalman filter smoothing factor
  static const double positionSmoothingFactor = 0.3;
}
