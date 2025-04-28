import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';

class PlantationVerificationScreen extends StatefulWidget {
  const PlantationVerificationScreen({super.key});

  @override
  State<PlantationVerificationScreen> createState() => _PlantationVerificationScreenState();
}

class _PlantationVerificationScreenState extends State<PlantationVerificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _pendingVerifications = [
    {
      'id': 'PLT-1001',
      'applicantName': 'Rahul Mehta',
      'dateSubmitted': '18 May 2023',
      'treeCount': 2,
      'treeType': 'Neem',
      'location': 'Dharavi Garden, Mumbai',
      'imageUrls': ['assets/plantations/plt1.jpg', 'assets/plantations/plt2.jpg'],
      'status': 'Pending Verification',
      'applicationId': 'APP-23040',
    },
    {
      'id': 'PLT-1002',
      'applicantName': 'Aisha Khan',
      'dateSubmitted': '19 May 2023',
      'treeCount': 1,
      'treeType': 'Banyan',
      'location': 'Goregaon Municipal Park, Mumbai',
      'imageUrls': ['assets/plantations/plt3.jpg', 'assets/plantations/plt4.jpg'],
      'status': 'Pending Verification',
      'applicationId': 'APP-23041',
    },
    {
      'id': 'PLT-1003',
      'applicantName': 'Deepak Verma',
      'dateSubmitted': '20 May 2023',
      'treeCount': 3,
      'treeType': 'Peepal',
      'location': 'Andheri Sports Complex, Mumbai',
      'imageUrls': ['assets/plantations/plt5.jpg', 'assets/plantations/plt6.jpg'],
      'status': 'Pending Verification',
      'applicationId': 'APP-23042',
    },
  ];

  final List<Map<String, dynamic>> _verifiedPlantations = [
    {
      'id': 'PLT-1000',
      'applicantName': 'Sunita Sharma',
      'dateSubmitted': '15 May 2023',
      'dateVerified': '16 May 2023',
      'treeCount': 2,
      'treeType': 'Banyan',
      'location': 'Malad Municipal Garden, Mumbai',
      'imageUrls': ['assets/plantations/plt7.jpg', 'assets/plantations/plt8.jpg'],
      'status': 'Verified',
      'applicationId': 'APP-23038',
      'verifiedBy': 'Officer Amit Kumar',
      'remarks': 'Trees are healthy and properly planted',
    },
    {
      'id': 'PLT-999',
      'applicantName': 'Vikram Singh',
      'dateSubmitted': '14 May 2023',
      'dateVerified': '15 May 2023',
      'treeCount': 1,
      'treeType': 'Neem',
      'location': 'Bandra Promenade, Mumbai',
      'imageUrls': ['assets/plantations/plt9.jpg', 'assets/plantations/plt10.jpg'],
      'status': 'Rejected',
      'applicationId': 'APP-23037',
      'verifiedBy': 'Officer Amit Kumar',
      'remarks': 'Plants are too small and not according to guidelines',
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
        title: const Text('Plantation Verifications'),
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.white,
          tabs: const [
            Tab(text: 'Pending Verification'),
            Tab(text: 'Verified'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingVerifications(),
          _buildVerifiedPlantations(),
        ],
      ),
    );
  }

  Widget _buildPendingVerifications() {
    return _pendingVerifications.isEmpty
        ? _buildEmptyState('No pending verifications')
        : ListView.builder(
            itemCount: _pendingVerifications.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final verification = _pendingVerifications[index];
              return _buildVerificationCard(
                verification,
                isPending: true,
              );
            },
          );
  }

  Widget _buildVerifiedPlantations() {
    return _verifiedPlantations.isEmpty
        ? _buildEmptyState('No verified plantations')
        : ListView.builder(
            itemCount: _verifiedPlantations.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final verification = _verifiedPlantations[index];
              return _buildVerificationCard(
                verification,
                isPending: false,
              );
            },
          );
  }

  Widget _buildVerificationCard(Map<String, dynamic> verification, {required bool isPending}) {
    final Color statusColor = verification['status'] == 'Verified'
        ? AppTheme.darkGreen
        : verification['status'] == 'Rejected'
            ? Colors.red
            : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(verification['imageUrls'][0]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha:0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      verification['id'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha:0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      verification['status'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        _showAllImages(verification['imageUrls']);
                      },
                      child: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            verification['applicantName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Application: ${verification['applicationId']}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreen.withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.darkGreen),
                      ),
                      child: Text(
                        '${verification['treeCount']} Trees',
                        style: const TextStyle(
                          color: AppTheme.darkGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.forest, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Type: ${verification['treeType']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Location: ${verification['location']}',
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Submitted: ${verification['dateSubmitted']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                if (!isPending) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        verification['status'] == 'Verified'
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${verification['status']} by: ${verification['verifiedBy']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Remarks: ${verification['remarks']}',
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (isPending) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _navigateToVerificationDetails(verification);
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
                            _showVerificationOptions(verification);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.darkGreen,
                          ),
                          child: const Text('Verify'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
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

  void _navigateToVerificationDetails(Map<String, dynamic> verification) {
    // Navigation to be implemented
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening details for ${verification['id']}'),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _showAllImages(List<String> imageUrls) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'All Plantation Images',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkGreen,
                  ),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVerificationOptions(Map<String, dynamic> verification) {
    final TextEditingController remarksController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Verify Plantation ${verification['id']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please verify if the plantation meets the required standards:',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Officer Remarks:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: remarksController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your comments about the plantation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Verification Decision:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _approveVerification(verification, remarksController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Approve'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _rejectVerification(verification, remarksController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  void _approveVerification(Map<String, dynamic> verification, String remarks) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Plantation ${verification['id']} verified successfully'),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _rejectVerification(Map<String, dynamic> verification, String remarks) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Plantation ${verification['id']} rejected'),
        backgroundColor: Colors.red,
      ),
    );
  }
} 