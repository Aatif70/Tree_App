import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/constants/app_theme.dart';

class GreenScorecard extends StatelessWidget {
  final int treesSaved;
  final int treesPlanted;
  final int treesAdopted;

  const GreenScorecard({
    Key? key,
    required this.treesSaved,
    required this.treesPlanted,
    required this.treesAdopted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                count: treesSaved.toString(),
              ),
              _buildScoreItem(
                icon: Icons.eco,
                title: 'Planted &\nVerified',
                count: treesPlanted.toString(),
              ),
              _buildScoreItem(
                icon: Icons.favorite,
                title: 'Trees You\'ve\nAdopted',
                count: treesAdopted.toString(),
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
} 