import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/constants/app_theme.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ActionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
} 