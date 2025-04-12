import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/services/tree_prefs_service.dart';
import 'package:tree_app/utils/widgets.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/views/apply_tree_cut_screen.dart';
import 'package:tree_app/views/plantation_proof_screen.dart';
import 'package:tree_app/views/adopt_tree_screen.dart';
import 'package:tree_app/views/track_requests_screen.dart';

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
              _buildWelcomeHeader(_username),
              
              // Main Content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    // Green Scorecard Banner
                    _buildGreenScorecard(),
                    
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
                    _buildMainActions(),
                    
                    const SizedBox(height: 24),
                    
                    // Nearby Green Spots
                    _buildNearbyGreenSpots(),
                    
                    const SizedBox(height: 24),
                    
                    // Notifications Banner
                    if (!_hasSeenNotification) _buildNotificationsBanner(),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWelcomeHeader(String userName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGreen,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Profile feature coming soon!'),
                      backgroundColor: AppTheme.darkGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppTheme.lightGreen,
                  child: Icon(
                    Icons.person,
                    color: AppTheme.darkGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Welcome back, $_username 🌿',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Every small act counts toward a greener tomorrow.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -0.2, end: 0, duration: 400.ms);
  }

  Widget _buildGreenScorecard() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA5D6A7), Color(0xFFE8F5E9)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Green Impact Score',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreItem(
                icon: Icons.nature,
                title: 'Trees You\'ve\nHelped Save',
                count: _treesSaved.toString(),
              ),
              _buildScoreItem(
                icon: Icons.eco,
                title: 'Planted &\nVerified',
                count: _treesPlanted.toString(),
              ),
              _buildScoreItem(
                icon: Icons.favorite,
                title: 'Trees You\'ve\nAdopted',
                count: _treesAdopted.toString(),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildScoreItem({
    required IconData icon,
    required String title,
    required String count,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: AppTheme.darkGreen,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkGreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppTheme.darkGreen,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainActions() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildActionCard(
          title: 'Apply to Cut a Tree',
          subtitle: 'Request permission with a valid reason',
          icon: Icons.content_cut,
          color: AppTheme.lightGreen,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ApplyTreeCutScreen(),
              ),
            );
          },
        ),
        _buildActionCard(
          title: 'Submit Plantation Proof',
          subtitle: 'Upload images & location of your planted trees',
          icon: Icons.camera_alt,
          color: AppTheme.softGreen,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlantationProofScreen(),
              ),
            );
          },
        ),
        _buildActionCard(
          title: 'Adopt a Tree',
          subtitle: 'Care for a tree and get updates on its growth',
          icon: Icons.favorite,
          color: AppTheme.softGreen,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdoptTreeScreen(),
              ),
            ).then((_) => _loadUserData());
          },
        ),
        _buildActionCard(
          title: 'Track My Requests',
          subtitle: 'Monitor application status & history',
          icon: Icons.access_time,
          color: AppTheme.lightGreen,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TrackRequestsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        final options = [
          'View Details',
          'Add to Favorites',
          'Share',
        ];
        
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...options.map((option) {
                    return ListTile(
                      leading: Icon(
                        option == 'View Details'
                            ? Icons.info_outline
                            : option == 'Add to Favorites'
                                ? Icons.star_outline
                                : Icons.share,
                        color: AppTheme.darkGreen,
                      ),
                      title: Text(
                        option,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$option selected for $title'),
                            backgroundColor: AppTheme.darkGreen,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ).animate().fade(duration: 300.ms).slideY(begin: 0.2, end: 0),
    );
  }

  Widget _buildNearbyGreenSpots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Green Spots',
          style: AppTheme.subheadingStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildGreenSpotCard(
                title: 'Heritage Tree near you',
                distance: '1.2km',
                icon: Icons.park,
              ),
              _buildGreenSpotCard(
                title: 'Public Garden in your ward',
                distance: '0.8km',
                icon: Icons.landscape,
              ),
              _buildGreenSpotCard(
                title: 'Open Plot available for Plantation',
                distance: '2.5km',
                icon: Icons.grass,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGreenSpotCard({
    required String title,
    required String distance,
    required IconData icon,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.softGreen.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 50,
                    color: AppTheme.darkGreen,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Showing $title on map'),
                                backgroundColor: AppTheme.darkGreen,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.darkGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            minimumSize: Size.zero,
                            textStyle: GoogleFonts.poppins(fontSize: 12),
                          ),
                          child: const Text('View on Map'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                distance,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildNotificationsBanner() {
    return Dismissible(
      key: const Key('notification'),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        _dismissNotification();
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            const Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlantationProofScreen(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.lightMintGreen,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.softGreen,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.softGreen.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Your plantation proof is due in 3 days',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.darkGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.darkGreen,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          
          // Handle navigation
          if (index == 1) { // My Trees
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('My Trees feature coming soon!'),
                backgroundColor: AppTheme.darkGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } else if (index == 2) { // Adopt
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdoptTreeScreen(),
              ),
            ).then((_) {
              setState(() {
                _currentIndex = 0; // Reset to home after returning
              });
              _loadUserData();
            });
          } else if (index == 3) { // Notifications
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Notifications feature coming soon!'),
                backgroundColor: AppTheme.darkGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } else if (index == 4) { // Profile
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Profile feature coming soon!'),
                backgroundColor: AppTheme.darkGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
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