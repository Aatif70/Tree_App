import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      
      // If user is already logged in, navigate to their home screen
      if (authViewModel.isLoggedIn) {
        Navigator.pushReplacementNamed(context, authViewModel.getHomeRoute());
      } else {
        // Otherwise go to role selection
        Navigator.pushReplacementNamed(context, Routes.roleSelection);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.eco,
                  size: 80,
                  color: AppTheme.darkGreen,
                ),
              )
                  .animate()
                  .fade(duration: 500.ms)
                  .scale(delay: 300.ms, duration: 500.ms),
              const SizedBox(height: 24),
              Text(
                'TreeGuard',
                style: AppTheme.headingStyle.copyWith(
                  color: AppTheme.darkGreen,
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              )
                  .animate()
                  .fade(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.5, end: 0),
            ],
          ),
        ),
      ),
    );
  }
} 