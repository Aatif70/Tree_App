import 'package:shared_preferences/shared_preferences.dart';

class TreePrefsService {
  static const String usernameKey = 'username';
  static const String treesSavedKey = 'trees_saved';
  static const String treesPlantedKey = 'trees_planted';
  static const String treesAdoptedKey = 'trees_adopted';
  static const String hasSeenNotificationKey = 'has_seen_notification';

  // Default values
  static const String defaultUsername = 'Aatif';
  static const int defaultTreesSaved = 4;
  static const int defaultTreesPlanted = 6;
  static const int defaultTreesAdopted = 2;
  static const bool defaultHasSeenNotification = false;

  // Initialize with default values if not already set
  static Future<void> initializePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if values exist, if not, set defaults
    if (!prefs.containsKey(usernameKey)) {
      await prefs.setString(usernameKey, defaultUsername);
    }
    
    if (!prefs.containsKey(treesSavedKey)) {
      await prefs.setInt(treesSavedKey, defaultTreesSaved);
    }
    
    if (!prefs.containsKey(treesPlantedKey)) {
      await prefs.setInt(treesPlantedKey, defaultTreesPlanted);
    }
    
    if (!prefs.containsKey(treesAdoptedKey)) {
      await prefs.setInt(treesAdoptedKey, defaultTreesAdopted);
    }
    
    if (!prefs.containsKey(hasSeenNotificationKey)) {
      await prefs.setBool(hasSeenNotificationKey, defaultHasSeenNotification);
    }
  }

  // Get username
  static Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey) ?? defaultUsername;
  }

  // Set username
  static Future<bool> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(usernameKey, value);
  }

  // Get trees saved
  static Future<int> getTreesSaved() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(treesSavedKey) ?? defaultTreesSaved;
  }

  // Set trees saved
  static Future<bool> setTreesSaved(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(treesSavedKey, value);
  }

  // Get trees planted
  static Future<int> getTreesPlanted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(treesPlantedKey) ?? defaultTreesPlanted;
  }

  // Set trees planted
  static Future<bool> setTreesPlanted(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(treesPlantedKey, value);
  }

  // Get trees adopted
  static Future<int> getTreesAdopted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(treesAdoptedKey) ?? defaultTreesAdopted;
  }

  // Set trees adopted
  static Future<bool> setTreesAdopted(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(treesAdoptedKey, value);
  }

  // Get has seen notification
  static Future<bool> getHasSeenNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasSeenNotificationKey) ?? defaultHasSeenNotification;
  }

  // Set has seen notification
  static Future<bool> setHasSeenNotification(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(hasSeenNotificationKey, value);
  }
} 