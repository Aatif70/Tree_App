import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_app/constants/app_theme.dart';

class TrackRequestsScreen extends StatefulWidget {
  const TrackRequestsScreen({Key? key}) : super(key: key);

  @override
  State<TrackRequestsScreen> createState() => _TrackRequestsScreenState();
}

class _TrackRequestsScreenState extends State<TrackRequestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  // Dummy data for tree cutting and planting requests
  final List<Map<String, dynamic>> _cuttingRequests = [
    {
      'id': 'TC-2023-001',
      'date': '2023-10-15',
      'status': 'Approved',
      'location': '123 Green Street, Eco City',
      'reason': 'Diseased tree posing safety hazard',
      'officer': 'Officer Johnson',
      'notes': 'Approval granted with condition to plant 2 new trees within 30 days.',
    },
    {
      'id': 'TC-2023-002',
      'date': '2023-11-05',
      'status': 'Pending',
      'location': '45 Forest Avenue, Eco City',
      'reason': 'Tree roots damaging building foundation',
      'officer': 'Officer Williams',
      'notes': 'Site inspection scheduled for Nov 10th',
    },
    {
      'id': 'TC-2023-003',
      'date': '2023-11-28',
      'status': 'Rejected',
      'location': '78 Park Road, Eco City',
      'reason': 'Tree blocking sunlight to property',
      'officer': 'Officer Davis',
      'notes': 'Request denied as the reason does not justify tree removal. Consider pruning instead.',
    },
  ];

  final List<Map<String, dynamic>> _plantationProofs = [
    {
      'id': 'TP-2023-001',
      'date': '2023-09-20',
      'status': 'Verified',
      'location': 'Community Garden, Riverside',
      'treeType': 'Neem',
      'officer': 'Officer Wilson',
      'notes': 'Successfully verified. Tree is healthy and well-planted.',
    },
    {
      'id': 'TP-2023-002',
      'date': '2023-10-12',
      'status': 'Verified',
      'location': '123 Green Street, Eco City',
      'treeType': 'Oak',
      'officer': 'Officer Martinez',
      'notes': 'Plantation verified. Great job!',
    },
    {
      'id': 'TP-2023-003',
      'date': '2023-11-25',
      'status': 'Pending Verification',
      'location': '45 Forest Avenue, Eco City',
      'treeType': 'Maple',
      'officer': 'Unassigned',
      'notes': 'Awaiting officer assignment for verification.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Simulate loading data
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track My Requests',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.darkGreen,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: 'Cutting Requests'),
            Tab(text: 'Plantation Proofs'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppTheme.darkGreen,
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                // Cutting Requests Tab
                _buildRequestsList(_cuttingRequests, 'cutting requests'),
                
                // Plantation Proofs Tab
                _buildRequestsList(_plantationProofs, 'plantation proofs'),
              ],
            ),
    );
  }

  Widget _buildRequestsList(List<Map<String, dynamic>> requests, String type) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'cutting requests' ? Icons.content_cut : Icons.nature,
              size: 50,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No $type found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your $type will appear here',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return _buildRequestCard(request, type);
      },
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request, String type) {
    // Determine status color
    Color statusColor;
    IconData statusIcon;
    
    switch (request['status']) {
      case 'Approved':
      case 'Verified':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Pending':
      case 'Pending Verification':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = Icons.info;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.2),
          child: Icon(
            statusIcon,
            color: statusColor,
          ),
        ),
        title: Row(
          children: [
            Text(
              request['id'],
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkGreen,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                request['status'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Submitted on ${request['date']}',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
        children: [
          // Location
          _buildDetailRow(
            'Location',
            request['location'],
            Icons.location_on,
          ),
          const SizedBox(height: 8),
          
          // Reason or Tree Type
          _buildDetailRow(
            type == 'cutting requests' ? 'Reason' : 'Tree Type',
            type == 'cutting requests' ? request['reason'] : request['treeType'],
            type == 'cutting requests' ? Icons.info_outline : Icons.nature,
          ),
          const SizedBox(height: 8),
          
          // Officer
          _buildDetailRow(
            'Officer',
            request['officer'],
            Icons.person,
          ),
          const SizedBox(height: 8),
          
          // Notes
          _buildDetailRow(
            'Notes',
            request['notes'],
            Icons.notes,
          ),
          const SizedBox(height: 16),
          
          // Action button
          SizedBox(
            width: double.infinity,
            child: request['status'] == 'Pending' || request['status'] == 'Pending Verification'
                ? OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Reminder sent to officials for ${request['id']}'),
                          backgroundColor: AppTheme.darkGreen,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.darkGreen,
                      side: const BorderSide(color: AppTheme.darkGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Send Reminder',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Certificate for ${request['id']} will be emailed to you.'),
                          backgroundColor: AppTheme.darkGreen,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Download Certificate',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppTheme.darkGreen,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 