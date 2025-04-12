import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/views/citizen/adopt_tree_screen.dart';
import 'package:tree_app/views/citizen/apply_tree_cut_screen.dart';
import 'package:tree_app/views/citizen/plantation_proof_screen.dart';
import 'package:tree_app/views/citizen/track_requests_screen.dart';
import 'package:tree_app/views/citizen/widgets/action_card.dart';

class MainActionsGrid extends StatelessWidget {
  final VoidCallback onAdoptComplete;

  const MainActionsGrid({
    Key? key,
    required this.onAdoptComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        ActionCard(
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
        ActionCard(
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
        ActionCard(
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
            ).then((_) => onAdoptComplete());
          },
        ),
        ActionCard(
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
} 