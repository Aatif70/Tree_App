import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';

class TreeApplicationsScreen extends StatefulWidget {
  const TreeApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<TreeApplicationsScreen> createState() => _TreeApplicationsScreenState();
}

class _TreeApplicationsScreenState extends State<TreeApplicationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _pendingApplications = [
    {
      'id': 'APP-23045',
      'applicantName': 'Raj Kumar',
      'address': '23 Bandra West, Mumbai',
      'dateSubmitted': '12 May 2023',
      'treeCount': 3,
      'status': 'Pending Review',
      'urgency': 'High',
    },
    {
      'id': 'APP-23046',
      'applicantName': 'Priya Shah',
      'address': '45 Andheri East, Mumbai',
      'dateSubmitted': '14 May 2023',
      'treeCount': 1,
      'status': 'Pending Review',
      'urgency': 'Low',
    },
    {
      'id': 'APP-23048',
      'applicantName': 'Vikram Singh',
      'address': '78 Powai, Mumbai',
      'dateSubmitted': '15 May 2023',
      'treeCount': 2,
      'status': 'Pending Review',
      'urgency': 'Medium',
    },
  ];

  final List<Map<String, dynamic>> _reviewedApplications = [
    {
      'id': 'APP-23040',
      'applicantName': 'Mehul Patel',
      'address': '12 Goregaon, Mumbai',
      'dateSubmitted': '10 May 2023',
      'dateReviewed': '11 May 2023',
      'treeCount': 2,
      'status': 'Approved',
    },
    {
      'id': 'APP-23041',
      'applicantName': 'Anjali Desai',
      'address': '34 Juhu, Mumbai',
      'dateSubmitted': '9 May 2023',
      'dateReviewed': '11 May 2023',
      'treeCount': 1,
      'status': 'Rejected',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightMintGreen,
      appBar: AppBar(
        title: const Text('Tree Applications'),
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.white,
          tabs: const [
            Tab(text: 'Pending Review'),
            Tab(text: 'Reviewed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingApplications(),
          _buildReviewedApplications(),
        ],
      ),
    );
  }

  Widget _buildPendingApplications() {
    return _pendingApplications.isEmpty
        ? _buildEmptyState('No pending applications')
        : ListView.builder(
            itemCount: _pendingApplications.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final application = _pendingApplications[index];
              return _buildApplicationCard(
                application,
                isPending: true,
              );
            },
          );
  }

  Widget _buildReviewedApplications() {
    return _reviewedApplications.isEmpty
        ? _buildEmptyState('No reviewed applications')
        : ListView.builder(
            itemCount: _reviewedApplications.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final application = _reviewedApplications[index];
              return _buildApplicationCard(
                application,
                isPending: false,
              );
            },
          );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application, {required bool isPending}) {
    Color statusColor = AppTheme.darkGreen;
    
    if (!isPending) {
      statusColor = application['status'] == 'Approved' 
          ? AppTheme.darkGreen 
          : Colors.red;
    } else {
      switch (application['urgency']) {
        case 'High':
          statusColor = Colors.red;
          break;
        case 'Medium':
          statusColor = Colors.orange;
          break;
        case 'Low':
          statusColor = AppTheme.darkGreen;
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to application details
          _navigateToApplicationDetails(application);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    application['id'],
                    style: const TextStyle(
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      isPending ? 'Urgency: ${application['urgency']}' : application['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                application['applicantName'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                application['address'],
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Submitted: ${application['dateSubmitted']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.forest, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Trees: ${application['treeCount']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              if (!isPending) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Reviewed: ${application['dateReviewed']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
              if (isPending) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _navigateToApplicationDetails(application);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.darkGreen),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showReviewOptions(application);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkGreen,
                        ),
                        child: const Text('Review'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToApplicationDetails(Map<String, dynamic> application) {
    // Navigation to be implemented
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening details for ${application['id']}'),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _showReviewOptions(Map<String, dynamic> application) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review Application ${application['id']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please select your decision:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _approveApplication(application);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkGreen,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Approve Application'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _rejectApplication(application);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Reject Application'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _approveApplication(Map<String, dynamic> application) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application ${application['id']} approved'),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _rejectApplication(Map<String, dynamic> application) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application ${application['id']} rejected'),
        backgroundColor: Colors.red,
      ),
    );
  }
} 