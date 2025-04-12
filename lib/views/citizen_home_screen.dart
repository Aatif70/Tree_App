import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/utils/widgets.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({Key? key}) : super(key: key);

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userName = authViewModel.currentUser.name ?? 'Tree Guardian';

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: const BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TreeGuard',
                      style: AppTheme.subheadingStyle.copyWith(
                        color: AppTheme.white,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: AppTheme.white,
                      child: Icon(
                        Icons.person,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome back, $userName 🌿',
                  style: AppTheme.headingStyle.copyWith(
                    color: AppTheme.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ).animate().slideY(begin: -0.2, end: 0, duration: 400.ms),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _currentIndex == 0
                  ? _buildHomeContent()
                  : _buildPlaceholderContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppTheme.darkGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nature),
            label: 'My Trees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What would you like to do?',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              ActionCard(
                title: 'Apply to Cut a Tree',
                icon: Icons.content_cut,
                color: AppTheme.lightGreen,
                onTap: () {
                  _showFeatureNotImplemented('Apply to Cut a Tree');
                },
              ),
              ActionCard(
                title: 'Submit Plantation Proof',
                icon: Icons.camera_alt,
                color: AppTheme.softGreen,
                onTap: () {
                  _showFeatureNotImplemented('Submit Plantation Proof');
                },
              ),
              ActionCard(
                title: 'Adopt a Tree',
                icon: Icons.favorite,
                color: AppTheme.softGreen,
                onTap: () {
                  _showFeatureNotImplemented('Adopt a Tree');
                },
              ),
              ActionCard(
                title: 'Track My Requests',
                icon: Icons.access_time,
                color: AppTheme.lightGreen,
                onTap: () {
                  _showFeatureNotImplemented('Track My Requests');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction,
            size: 80,
            color: AppTheme.softGreen,
          ),
          const SizedBox(height: 20),
          Text(
            'Feature Coming Soon',
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'This section is under development',
            style: AppTheme.bodyStyle,
          ),
        ],
      ),
    );
  }

  void _showFeatureNotImplemented(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName feature is coming soon!'),
        backgroundColor: AppTheme.darkGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
} 