import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/models/user_model.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/view_models/auth_view_model.dart';

class RouteGuard {
  static Route<dynamic> guardRoute(
    BuildContext context,
    Widget destinationPage,
    List<UserRole> allowedRoles,
    bool requireLogin,
  ) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final currentUser = authViewModel.currentUser;
    
    // Check if login required and user is not logged in
    if (requireLogin && !authViewModel.isLoggedIn) {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Please login to access this page'),
          ),
        ),
      );
    }
    
    // Check if user has the required role
    if (allowedRoles.isNotEmpty && !allowedRoles.contains(currentUser.role)) {
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You do not have permission to access this page',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.roleSelection);
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    // If all checks pass, return the requested page
    return MaterialPageRoute(builder: (_) => destinationPage);
  }

  static Route<dynamic> guardRouteByRole(
    BuildContext context,
    Widget citizenPage,
    Widget officerPage,
    Widget authorityPage,
  ) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final currentUser = authViewModel.currentUser;
    
    // Check if user is logged in
    if (!authViewModel.isLoggedIn) {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Please login to access this page'),
          ),
        ),
      );
    }
    
    // Return page based on user role
    switch (currentUser.role) {
      case UserRole.citizen:
        return MaterialPageRoute(builder: (_) => citizenPage);
      case UserRole.treeOfficer:
        return MaterialPageRoute(builder: (_) => officerPage);
      case UserRole.treeAuthority:
        return MaterialPageRoute(builder: (_) => authorityPage);
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Invalid user role'),
            ),
          ),
        );
    }
  }
} 