import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';

class ApplicationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> application;

  const ApplicationDetailsScreen({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  State<ApplicationDetailsScreen> createState() => _ApplicationDetailsScreenState();
}

class _ApplicationDetailsScreenState extends State<ApplicationDetailsScreen> {
  final List<Map<String, dynamic>> _treeDetails = [
    {
      'id': 'TREE-001',
      'species': 'Banyan',
      'age': '~25 years',
      'height': '12 meters',
      'girth': '2.5 meters',
      'reason': 'Construction of residential building',
      'location': '23.0225° N, 72.5714° E',
      'images': ['assets/trees/banyan1.jpg', 'assets/trees/banyan2.jpg'],
    },
    {
      'id': 'TREE-002',
      'species': 'Neem',
      'age': '~15 years',
      'height': '8 meters',
      'girth': '1.2 meters',
      'reason': 'Blocking drainage line',
      'location': '23.0226° N, 72.5715° E',
      'images': ['assets/trees/neem1.jpg', 'assets/trees/neem2.jpg'],
    },
    {
      'id': 'TREE-003',
      'species': 'Peepal',
      'age': '~20 years',
      'height': '10 meters',
      'girth': '1.8 meters',
      'reason': 'Road widening project',
      'location': '23.0227° N, 72.5716° E',
      'images': ['assets/trees/peepal1.jpg', 'assets/trees/peepal2.jpg'],
    },
  ];

  // Mock documents
  final List<Map<String, dynamic>> _documents = [
    {
      'name': 'Land Ownership Certificate',
      'type': 'PDF',
      'size': '1.2 MB',
      'uploadDate': '12 May 2023',
      'verified': true,
    },
    {
      'name': 'Building Permission',
      'type': 'PDF',
      'size': '3.4 MB',
      'uploadDate': '12 May 2023',
      'verified': true,
    },
    {
      'name': 'Site Plan with Trees Marked',
      'type': 'JPG',
      'size': '2.1 MB',
      'uploadDate': '12 May 2023',
      'verified': false,
    },
    {
      'name': 'Tree Compensation Plan',
      'type': 'PDF',
      'size': '0.8 MB',
      'uploadDate': '12 May 2023',
      'verified': false,
    },
  ];

  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightMintGreen,
      appBar: AppBar(
        title: Text('Application ${widget.application['id']}'),
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showApplicationStatus();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildApplicationHeader(),
          _buildTabBar(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildApplicationHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.application['applicantName'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.application['address'],
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange),
                ),
                child: Text(
                  'Trees: ${widget.application['treeCount']}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                'Submitted: ${widget.application['dateSubmitted']}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getUrgencyColor(widget.application['urgency']).withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _getUrgencyColor(widget.application['urgency'])),
                ),
                child: Text(
                  'Urgency: ${widget.application['urgency']}',
                  style: TextStyle(
                    color: _getUrgencyColor(widget.application['urgency']),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return AppTheme.darkGreen;
      default:
        return AppTheme.darkGreen;
    }
  }

  Widget _buildTabBar() {
    return Container(
      color: AppTheme.white,
      child: Row(
        children: [
          _buildTabItem(0, 'Tree Details'),
          _buildTabItem(1, 'Documents'),
          _buildTabItem(2, 'Site Info'),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppTheme.darkGreen : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppTheme.darkGreen : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildTreeDetailsList();
      case 1:
        return _buildDocumentsList();
      case 2:
        return _buildSiteInfo();
      default:
        return _buildTreeDetailsList();
    }
  }

  Widget _buildTreeDetailsList() {
    return ListView.builder(
      itemCount: _treeDetails.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final tree = _treeDetails[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
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
                    image: AssetImage(tree['images'][0]),
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
                          tree['id'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          // Show more images
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha:0.6),
                            shape: BoxShape.circle,
                          ),
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
                        Text(
                          'Species: ${tree['species']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                            tree['age'],
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
                    _buildTreeDetailRow('Height', tree['height'], Icons.height),
                    const SizedBox(height: 8),
                    _buildTreeDetailRow('Girth', tree['girth'], Icons.front_hand),
                    const SizedBox(height: 8),
                    _buildTreeDetailRow('Location', tree['location'], Icons.location_on),
                    const SizedBox(height: 12),
                    const Text(
                      'Reason for Removal:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tree['reason'],
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTreeDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '$label:',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsList() {
    return ListView.builder(
      itemCount: _documents.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final document = _documents[index];
        final icon = _getFileIcon(document['type']);
        final color = _getFileColor(document['type']);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            title: Text(
              document['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${document['type']} • ${document['size']} • Uploaded ${document['uploadDate']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  document['verified'] ? Icons.check_circle : Icons.pending,
                  color: document['verified'] ? AppTheme.darkGreen : Colors.orange,
                  size: 18,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.download_rounded),
                  onPressed: () {
                    // Download document
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Downloading ${document['name']}...'),
                        backgroundColor: AppTheme.darkGreen,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'JPG':
      case 'PNG':
        return Icons.image;
      case 'DOC':
      case 'DOCX':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(String type) {
    switch (type) {
      case 'PDF':
        return Colors.red;
      case 'JPG':
      case 'PNG':
        return Colors.blue;
      case 'DOC':
      case 'DOCX':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSiteInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    image: const DecorationImage(
                      image: AssetImage('assets/map_sample.jpg'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.1),
                        offset: const Offset(0, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.darkGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Expand Map',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
                      const Text(
                        'Site Inspection',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSiteInfoItem('Property Type', 'Residential Plot'),
                      _buildSiteInfoItem('Area', '2500 sq. ft.'),
                      _buildSiteInfoItem('Zone', 'R2 - Residential Zone'),
                      _buildSiteInfoItem('Survey Number', '123/4, Block B'),
                      const SizedBox(height: 16),
                      const Text(
                        'Project Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSiteInfoItem('Project Type', 'Construction of Residential Building'),
                      _buildSiteInfoItem('Building Area', '1800 sq. ft.'),
                      _buildSiteInfoItem('Start Date', 'June 2023'),
                      _buildSiteInfoItem('Estimated Completion', 'December 2024'),
                      const SizedBox(height: 16),
                      const Text(
                        'Replantation Plan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.darkGreen.withValues(alpha:0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trees to be Planted: 6 (2:1 ratio)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Location: Municipal Garden, Sector 12',
                              style: TextStyle(
                                color: AppTheme.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppTheme.darkGreen,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Compensation Amount Paid',
                                  style: TextStyle(
                                    color: AppTheme.darkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSiteInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            offset: const Offset(0, -3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Reject application
                _showRejectDialog();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Reject'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Approve application
                _showApproveDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Approve'),
            ),
          ),
        ],
      ),
    );
  }

  void _showApplicationStatus() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Application Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusStep('Application Submitted', 'May 12, 2023', true),
              _buildStatusStep('Document Verification', 'May 13, 2023', true),
              _buildStatusStep('Field Inspection', 'May 14, 2023', true),
              _buildStatusStep('Officer Review', 'In Progress', false),
              _buildStatusStep('Final Decision', 'Pending', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusStep(String title, String date, bool completed) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed ? AppTheme.darkGreen : Colors.grey.shade300,
          ),
          child: Icon(
            completed ? Icons.check : Icons.circle,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: completed ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: completed ? Colors.grey : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showApproveDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Approve Application'),
          content: const Text(
            'Are you sure you want to approve this tree cutting application?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Application approved successfully'),
                    backgroundColor: AppTheme.darkGreen,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              child: const Text('Approve'),
            ),
          ],
        );
      },
    );
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reject Application'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to reject this tree cutting application?',
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Reason for rejection',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Application rejected'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }
} 