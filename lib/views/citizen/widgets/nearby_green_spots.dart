import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/views/citizen/widgets/green_spot_card.dart';

class NearbyGreenSpots extends StatelessWidget {
  const NearbyGreenSpots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              GreenSpotCard(
                title: 'Heritage Tree near you',
                distance: '1.2km',
                icon: Icons.park,
                onViewMap: (title) {
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
              ),
              GreenSpotCard(
                title: 'Public Garden in your ward',
                distance: '0.8km',
                icon: Icons.landscape,
                onViewMap: (title) {
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
              ),
              GreenSpotCard(
                title: 'Open Plot available for Plantation',
                distance: '2.5km',
                icon: Icons.grass,
                onViewMap: (title) {
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
              ),
            ],
          ),
        ),
      ],
    );
  }
} 