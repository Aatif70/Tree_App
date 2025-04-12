import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/views/citizen/adopt_tree_screen.dart';

class CitizenBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onAdoptComplete;

  const CitizenBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAdoptComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Update the selected index
          onTap(index);
          
          // Handle navigation
          if (index == 1) { // My Trees
            _showFeatureSnackbar(context, 'My Trees');
          } else if (index == 2) { // Adopt
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdoptTreeScreen(),
              ),
            ).then((_) {
              onTap(0); // Reset to home after returning
              onAdoptComplete();
            });
          } else if (index == 3) { // Notifications
            _showFeatureSnackbar(context, 'Notifications');
          } else if (index == 4) { // Profile
            _showFeatureSnackbar(context, 'Profile');
          }
        },
        selectedItemColor: AppTheme.darkGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nature_outlined),
            activeIcon: Icon(Icons.nature),
            label: 'My Trees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Adopt',
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

  void _showFeatureSnackbar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName feature coming soon!'),
        backgroundColor: AppTheme.darkGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
} 