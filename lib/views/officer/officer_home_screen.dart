import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/utils/widgets.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OfficerHomeScreen extends StatefulWidget {
  const OfficerHomeScreen({Key? key}) : super(key: key);

  @override
  State<OfficerHomeScreen> createState() => _OfficerHomeScreenState();
}

class _OfficerHomeScreenState extends State<OfficerHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userName = authViewModel.currentUser.name ?? 'Tree Officer';

    return Scaffold(
      backgroundColor: AppTheme.lightMintGreen,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
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
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: AppTheme.white),
                          onPressed: () {
                            _showFeatureNotImplemented('Notifications');
                          },
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.white, width: 1.5),
                            ),
                            child: const Text(
                              '4',
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome, Officer of Green Zones 🌿',
                  style: AppTheme.headingStyle.copyWith(
                    color: AppTheme.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ).animate().slideY(begin: -0.2, end: 0, duration: 400.ms),
          Expanded(
            child: _currentIndex == 0
                ? _buildHomeContent()
                : _buildPlaceholderContent(),
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
        backgroundColor: AppTheme.white,
        selectedItemColor: AppTheme.darkGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Trees Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Quick Actions',
            style: AppTheme.subheadingStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionCards(),
          const SizedBox(height: 24),
          _buildTodaySummary(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showFeatureNotImplemented('Start Reviewing');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
                foregroundColor: AppTheme.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Start Reviewing',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ActionCard(
          title: 'Review Tree Cut Applications',
          icon: Icons.folder_outlined,
          color: AppTheme.lightGreen,
          onTap: () {
            _showFeatureNotImplemented('Review Applications');
          },
        ),
        ActionCard(
          title: 'View Mapped Trees',
          icon: Icons.location_on_outlined,
          color: AppTheme.softGreen,
          onTap: () {
            _showFeatureNotImplemented('View Map');
          },
        ),
        ActionCard(
          title: 'Validate Plantation Proofs',
          icon: Icons.camera_alt_outlined,
          color: AppTheme.softGreen,
          onTap: () {
            _showFeatureNotImplemented('Validate Proofs');
          },
        ),
        ActionCard(
          title: 'Reports & Violations',
          icon: Icons.warning_amber_outlined,
          color: AppTheme.lightGreen,
          onTap: () {
            _showFeatureNotImplemented('View Reports');
          },
        ),
      ],
    );
  }

  Widget _buildTodaySummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Summary',
              style: AppTheme.subheadingStyle.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryItem(Icons.forest, 'Trees Reviewed', '12', Colors.green.shade800),
            const Divider(),
            _buildSummaryItem(Icons.check_circle_outline, 'Validated Proofs', '9', Colors.blue.shade700),
            const Divider(),
            _buildSummaryItem(Icons.warning_amber_outlined, 'Pending Issues', '3', Colors.orange.shade700),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
        );
  }

  Widget _buildSummaryItem(IconData icon, String title, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Text(
            title,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            count,
            style: AppTheme.headingStyle.copyWith(
              fontSize: 20,
              color: color,
            ),
          ),
        ],
      ),
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