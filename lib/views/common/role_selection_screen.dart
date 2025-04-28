import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/models/user_model.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/utils/widgets.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/forest_bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.darkGreen.withValues(alpha: 0.6),
                AppTheme.softGreen.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.eco,
                        color: AppTheme.white,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TreeGuard',
                        style: AppTheme.subheadingStyle.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          color: AppTheme.white,
                        ),
                        onPressed: () {
                          _showInfoDialog(context);
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      'Select your Role',
                      style: AppTheme.headingStyle.copyWith(
                        color: AppTheme.white,
                        fontSize: 32,
                      ),
                    ).animate().fadeIn(duration: 800.ms),
                  ),
                  const SizedBox(height: 40),
                  _buildRoleCards(context),
                  const Spacer(),
                  Center(
                    child: Text(
                      'Your actions protect our future forests.',
                      style: AppTheme.smallTextStyle.copyWith(
                        color: AppTheme.white,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCards(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Column(
      children: [
        RoleCard(
          title: 'I\'m a Citizen',
          icon: Icons.person,
          color: AppTheme.lightGreen,
          onTap: () {
            authViewModel.selectRole(UserRole.citizen);
            Navigator.pushNamed(context, Routes.login);
          },
        ),
        RoleCard(
          title: 'I\'m a Tree Officer',
          icon: Icons.forest,
          color: AppTheme.softGreen,
          onTap: () {
            authViewModel.selectRole(UserRole.treeOfficer);
            Navigator.pushNamed(context, Routes.login);
          },
        ),
        RoleCard(
          title: 'I\'m a Tree Authority',
          icon: Icons.account_balance,
          color: AppTheme.darkGreen,
          onTap: () {
            authViewModel.selectRole(UserRole.treeAuthority);
            Navigator.pushNamed(context, Routes.login);
          },
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About TreeGuard',
            style: TextStyle(color: Colors.green),),

        content: const Text(
          'TreeGuard helps you protect and manage trees in your community.'
          'Choose your role to get started with the appropriate features.',
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
} 