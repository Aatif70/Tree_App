import 'package:flutter/material.dart';
import 'package:tree_app/models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  User _currentUser = User();
  bool _isLoading = false;

  User get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser.isRegistered;

  // Select user role from welcome screen
  void selectRole(UserRole role) {
    _currentUser = _currentUser.copyWith(role: role);
    notifyListeners();
  }

  // Login method based on role
  Future<bool> login({
    required String identifier,
    required String password,
    String? otp,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call with different logic per role
    await Future.delayed(const Duration(seconds: 1));

    bool success = false;
    String? mockId = DateTime.now().millisecondsSinceEpoch.toString();






    switch (_currentUser.role) {
      case UserRole.citizen:
        // For citizens, identifier is phone number or email
        success = true; // Simple validation for demo
        _currentUser = _currentUser.copyWith(
          id: mockId,
          phoneNumber: identifier,
          isRegistered: true,
        );
        break;
        
      case UserRole.treeOfficer:
        // For officers, check officer ID and password
        if (password.length >= 4) { // Simple validation for demo
          success = true;
          _currentUser = _currentUser.copyWith(
            id: identifier,
            isRegistered: true,
            name: 'Officer $identifier',
          );
        }
        break;
        
      case UserRole.treeAuthority:
        // For authority, validate ID, password and optional OTP
        if (password.length >= 6 && (otp == null || otp.length == 6)) {
          success = true;
          _currentUser = _currentUser.copyWith(
            id: identifier,
            isRegistered: true,
            name: 'Authority $identifier',
          );
        }
        break;
        
      default:
        success = false;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  // Register new citizen user
  Future<bool> registerUser({
    required String name,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Generate a mock ID in a real app this would come from backend
    String mockId = DateTime.now().millisecondsSinceEpoch.toString();

    _currentUser = _currentUser.copyWith(
      id: mockId,
      name: name,
      phoneNumber: phoneNumber,
      isRegistered: true,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Get home route based on user role
  String getHomeRoute() {
    switch (_currentUser.role) {
      case UserRole.citizen:
        return '/citizen-home';
      case UserRole.treeOfficer:
        return '/officer-home';
      case UserRole.treeAuthority:
        return '/authority-home';
      default:
        return '/role-selection';
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = User();
    _isLoading = false;
    notifyListeners();
  }
} 