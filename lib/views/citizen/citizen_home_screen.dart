import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/services/tree_prefs_service.dart';

// Import the extracted widget files
import 'package:tree_app/views/citizen/widgets/welcome_header.dart';
import 'package:tree_app/views/citizen/widgets/green_scorecard.dart';
import 'package:tree_app/views/citizen/widgets/notification_banner.dart';
import 'package:tree_app/views/citizen/widgets/citizen_bottom_nav.dart';
import 'package:tree_app/views/citizen/widgets/main_actions_grid.dart';
import 'package:tree_app/views/citizen/widgets/nearby_green_spots.dart';
import 'package:tree_app/views/citizen/plantation_proof_screen.dart';

class CitizenHomeScreen extends StatefulWidget {
  const CitizenHomeScreen({Key? key}) : super(key: key);

  @override
  State<CitizenHomeScreen> createState() => _CitizenHomeScreenState();
}

class _CitizenHomeScreenState extends State<CitizenHomeScreen> {
  int _currentIndex = 0;
  String _username = 'Aatif';
  int _treesSaved = 0;
  int _treesPlanted = 0;
  int _treesAdopted = 0;
  bool _hasSeenNotification = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Initialize preferences if needed
    await TreePrefsService.initializePrefs();
    
    // Load values
    final username = await TreePrefsService.getUsername();
    final treesSaved = await TreePrefsService.getTreesSaved();
    final treesPlanted = await TreePrefsService.getTreesPlanted();
    final treesAdopted = await TreePrefsService.getTreesAdopted();
    final hasSeenNotification = await TreePrefsService.getHasSeenNotification();
    
    if (mounted) {
      setState(() {
        _username = username;
        _treesSaved = treesSaved;
        _treesPlanted = treesPlanted;
        _treesAdopted = treesAdopted;
        _hasSeenNotification = hasSeenNotification;
        _isLoading = false;
      });
    }
  }

  void _dismissNotification() async {
    await TreePrefsService.setHasSeenNotification(true);
    setState(() {
      _hasSeenNotification = true;
    });
  }

  void _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    await _loadUserData();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data refreshed successfully!'),
        backgroundColor: AppTheme.darkGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading 
        ? const Center(
            child: CircularProgressIndicator(
              color: AppTheme.darkGreen,
            ),
          )
        : SafeArea(
          child: Column(
            children: [
              // Welcome Header
              WelcomeHeader(username: _username),
              
              // Main Content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    // Green Scorecard Banner
                    GreenScorecard(
                      treesSaved: _treesSaved,
                      treesPlanted: _treesPlanted,
                      treesAdopted: _treesAdopted,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Main Actions Section Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What would you like to do?',
                          style: AppTheme.subheadingStyle.copyWith(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: _refreshData,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.lightMintGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.refresh,
                              color: AppTheme.darkGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Main Actions Grid
                    MainActionsGrid(onAdoptComplete: _loadUserData),
                    
                    const SizedBox(height: 24),
                    
                    // Nearby Green Spots
                    const NearbyGreenSpots(),
                    
                    const SizedBox(height: 24),
                    
                    // Notifications Banner
                    if (!_hasSeenNotification) 
                      NotificationBanner(
                        onDismiss: _dismissNotification,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlantationProofScreen(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: CitizenBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onAdoptComplete: _loadUserData,
      ),
    );
  }
} 