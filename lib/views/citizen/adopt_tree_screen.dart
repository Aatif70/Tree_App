import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/services/tree_prefs_service.dart';

class AdoptTreeScreen extends StatefulWidget {
  const AdoptTreeScreen({Key? key}) : super(key: key);

  @override
  State<AdoptTreeScreen> createState() => _AdoptTreeScreenState();
}

class _AdoptTreeScreenState extends State<AdoptTreeScreen> {
  bool _isLoading = false;
  int _adoptedCount = 0;
  
  final List<Map<String, dynamic>> _treesList = [
    {
      'id': 1,
      'name': 'Royal Oak',
      'age': '15 years',
      'location': 'Central Park, Eco City',
      'description': 'A majestic oak tree that provides shade to visitors and is home to many bird species.',
      'image': 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?ixlib=rb-4.0.3',
      'isAdopted': false,
    },
    {
      'id': 2,
      'name': 'Heritage Banyan',
      'age': '95 years',
      'location': 'Historic District, Green Boulevard',
      'description': 'A century-old banyan tree that has witnessed the city\'s history and growth.',
      'image': 'https://images.unsplash.com/photo-1635774855317-edf3ee4463db?ixlib=rb-4.0.3',
      'isAdopted': false,
    },
    {
      'id': 3,
      'name': 'Young Maple',
      'age': '3 years',
      'location': 'Community Garden, Riverside',
      'description': 'A young maple tree planted during a community initiative that needs care to grow strong.',
      'image': 'https://images.unsplash.com/photo-1628447525803-3bf6b5ba4aee?ixlib=rb-4.0.3',
      'isAdopted': false,
    },
    {
      'id': 4,
      'name': 'Flowering Cherry',
      'age': '8 years',
      'location': 'Blossom Road, East Ward',
      'description': 'A beautiful cherry tree that blooms vibrant pink flowers during spring.',
      'image': 'https://images.unsplash.com/photo-1616648873483-f4f6912c5a54?ixlib=rb-4.0.3',
      'isAdopted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadAdoptedTrees();
  }

  Future<void> _loadAdoptedTrees() async {
    final count = await TreePrefsService.getTreesAdopted();
    setState(() {
      _adoptedCount = count;
      // Mark some trees as adopted based on count
      for (int i = 0; i < _treesList.length && i < count; i++) {
        _treesList[i]['isAdopted'] = true;
      }
    });
  }

  Future<void> _adoptTree(int treeId) async {
    setState(() {
      _isLoading = true;
    });

    // Find tree and update its status
    final treeIndex = _treesList.indexWhere((tree) => tree['id'] == treeId);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (treeIndex != -1 && !_treesList[treeIndex]['isAdopted']) {
      setState(() {
        _treesList[treeIndex]['isAdopted'] = true;
        _adoptedCount += 1;
      });
      
      // Update SharedPreferences
      await TreePrefsService.setTreesAdopted(_adoptedCount);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have adopted ${_treesList[treeIndex]['name']}!'),
          backgroundColor: AppTheme.darkGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adopt a Tree',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.darkGreen,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppTheme.darkGreen,
              ),
            )
          : Column(
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppTheme.lightMintGreen,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trees Available for Adoption',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Adopt a tree and contribute to a greener planet. You\'ll receive updates about your tree\'s growth and health.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.softGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'You\'ve adopted $_adoptedCount trees',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Tree List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _treesList.length,
                    itemBuilder: (context, index) {
                      final tree = _treesList[index];
                      return _buildTreeCard(tree);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTreeCard(Map<String, dynamic> tree) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tree Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              tree['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: AppTheme.lightGreen,
                  child: const Center(
                    child: Icon(
                      Icons.nature,
                      size: 50,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Tree Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tree['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.lightMintGreen,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.softGreen),
                      ),
                      child: Text(
                        tree['age'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppTheme.darkGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tree['location'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  tree['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: tree['isAdopted']
                        ? null
                        : () => _adoptTree(tree['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.grey[600],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      tree['isAdopted'] ? 'Already Adopted' : 'Adopt This Tree',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 