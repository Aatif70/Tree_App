import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthorityHomeScreen extends StatefulWidget {
  const AuthorityHomeScreen({Key? key}) : super(key: key);

  @override
  State<AuthorityHomeScreen> createState() => _AuthorityHomeScreenState();
}

class _AuthorityHomeScreenState extends State<AuthorityHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userName = authViewModel.currentUser.name ?? 'Administrator';

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4CAF50),
                  const Color(0xFF81C784),
                ],
              ),
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
                    Row(
                      children: [
                        const Icon(
                          Icons.eco,
                          color: AppTheme.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TreeGuard',
                          style: AppTheme.subheadingStyle.copyWith(
                            color: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: AppTheme.white,
                      child: Icon(
                        Icons.admin_panel_settings,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome, Tree Authority 🌲',
                  style: AppTheme.headingStyle.copyWith(
                    color: AppTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
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
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Tree Zones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park_outlined),
            activeIcon: Icon(Icons.park),
            label: 'Heritage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
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
          _buildStatsSummary(),
          const SizedBox(height: 24),
          Text(
            'Administrative Actions',
            style: AppTheme.subheadingStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          _buildAdminActions(),
          const SizedBox(height: 24),
          _buildChart(),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.softGreen.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4CAF50),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                'You\'re shaping Maharashtra\'s green legacy.',
                style: AppTheme.bodyStyle.copyWith(
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF4CAF50),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 700.ms),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatsCard(
            'Tree Cut Requests',
            '32',
            Icons.content_cut,
            const Color(0xFFFF5722),
          ),
          _buildStatsCard(
            'Trees Planted',
            '146',
            Icons.nature,
            const Color(0xFF4CAF50),
          ),
          _buildStatsCard(
            'Active Adoptions',
            '87',
            Icons.favorite,
            const Color(0xFFE91E63),
          ),
          _buildStatsCard(
            'Fund Utilization',
            '72%',
            Icons.account_balance_wallet,
            const Color(0xFF2196F3),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: AppTheme.headingStyle.copyWith(
                fontSize: 24,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminActions() {
    return Column(
      children: [
        _buildAdminActionButton(
          'Manage Officers & Permissions',
          Icons.people_outline,
          () => _showFeatureNotImplemented('Manage Officers'),
        ),
        _buildAdminActionButton(
          'Tag & Approve Heritage Trees',
          Icons.park_outlined,
          () => _showFeatureNotImplemented('Heritage Trees'),
        ),
        _buildAdminActionButton(
          'Fund & Cess Management',
          Icons.account_balance_wallet_outlined,
          () => _showFeatureNotImplemented('Fund Management'),
        ),
        _buildAdminActionButton(
          'Review Final Appeals',
          Icons.gavel_outlined,
          () => _showFeatureNotImplemented('Review Appeals'),
        ),
        _buildAdminActionButton(
          'View Regional Tree Data',
          Icons.bar_chart_outlined,
          () => _showFeatureNotImplemented('Regional Data'),
        ),
      ],
    );
  }

  Widget _buildAdminActionButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.darkGreen.withValues(alpha: 0.05),
                  AppTheme.softGreen.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF4CAF50),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fade(duration: 300.ms).slideX(begin: 0.05, end: 0);
  }

  Widget _buildChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plantation vs Felling Ratio',
                  style: AppTheme.subheadingStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () => _showFeatureNotImplemented('View Detailed Reports'),
                  child: Text(
                    'View Details',
                    style: AppTheme.smallTextStyle.copyWith(
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CustomPaint(
                    painter: PieChartPainter(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChartLegend('Planted', '74%', const Color(0xFF4CAF50)),
                      const SizedBox(height: 8),
                      _buildChartLegend('Felled', '26%', const Color(0xFFFF5722)),
                      const SizedBox(height: 12),
                      Text(
                        'We\'re meeting our goal of 3:1 plantation ratio.',
                        style: AppTheme.smallTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildChartLegend(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
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
            color: Color(0xFF81C784),
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
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Draw green portion (74%)
    final greenPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.fill;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14159, // Start from top
      1.5 * 3.14159, // 74% of the circle (in radians)
      true,
      greenPaint,
    );
    
    // Draw red portion (26%)
    final redPaint = Paint()
      ..color = const Color(0xFFFF5722)
      ..style = PaintingStyle.fill;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.0 * 3.14159, // Start from where green ends
      0.5 * 3.14159, // 26% of the circle (in radians)
      true,
      redPaint,
    );
    
    // Draw white circle in center for donut effect
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      center,
      radius * 0.6, // Inner circle radius
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 