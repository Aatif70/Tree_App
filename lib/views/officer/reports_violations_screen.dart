import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';

class ReportsViolationsScreen extends StatefulWidget {
  const ReportsViolationsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsViolationsScreen> createState() => _ReportsViolationsScreenState();
}

class _ReportsViolationsScreenState extends State<ReportsViolationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _pendingReports = [
    {
      'id': 'REP-1001',
      'title': 'Illegal Tree Cutting',
      'location': 'Bandra East, Mumbai',
      'dateReported': '22 May 2023',
      'reportedBy': 'Citizen',
      'citizenName': 'Ravi Kumar',
      'citizenContact': '+91 98765 43210',
      'status': 'Pending Investigation',
      'description': 'Found someone cutting trees without permission near the construction site at Bandra East.',
      'images': ['assets/reports/report1.jpg', 'assets/reports/report2.jpg'],
      'priority': 'High',
      'coordinates': '19.0596° N, 72.8295° E',
    },
    {
      'id': 'REP-1002',
      'title': 'Damaged Tree',
      'location': 'Malad West, Mumbai',
      'dateReported': '20 May 2023',
      'reportedBy': 'Municipal Worker',
      'citizenName': 'Sunil Patil',
      'citizenContact': '+91 87654 32109',
      'status': 'Pending Investigation',
      'description': 'Tree damaged by heavy vehicle. Tree seems to be leaning and might fall if not attended to quickly.',
      'images': ['assets/reports/report3.jpg'],
      'priority': 'Medium',
      'coordinates': '19.1943° N, 72.8402° E',
    },
    {
      'id': 'REP-1003',
      'title': 'Tree Burning',
      'location': 'Andheri East, Mumbai',
      'dateReported': '18 May 2023',
      'reportedBy': 'Citizen',
      'citizenName': 'Anjali Desai',
      'citizenContact': '+91 76543 21098',
      'status': 'Pending Investigation',
      'description': 'Someone is burning leaves and waste near the tree area which is causing damage to the nearby trees.',
      'images': ['assets/reports/report4.jpg', 'assets/reports/report5.jpg'],
      'priority': 'High',
      'coordinates': '19.1136° N, 72.8697° E',
    },
  ];

  final List<Map<String, dynamic>> _resolvedReports = [
    {
      'id': 'REP-1000',
      'title': 'Unauthorized Pruning',
      'location': 'Juhu, Mumbai',
      'dateReported': '15 May 2023',
      'dateResolved': '17 May 2023',
      'reportedBy': 'Citizen',
      'citizenName': 'Prakash Joshi',
      'resolutionOfficer': 'Officer Rajesh Singh',
      'status': 'Resolved',
      'description': 'Found unauthorized pruning of trees in the residential complex.',
      'resolution': 'Warning issued to the residential society. Fine of Rs. 5000 imposed.',
      'images': ['assets/reports/report6.jpg'],
      'priority': 'Medium',
      'coordinates': '19.1075° N, 72.8263° E',
    },
    {
      'id': 'REP-999',
      'title': 'Tree Clearing for Banner',
      'location': 'Dadar, Mumbai',
      'dateReported': '12 May 2023',
      'dateResolved': '14 May 2023',
      'reportedBy': 'NGO',
      'citizenName': 'Green Mumbai NGO',
      'resolutionOfficer': 'Officer Amit Kumar',
      'status': 'Resolved',
      'description': 'Political banner installed after clearing branches of roadside trees.',
      'resolution': 'Banner removed and case filed against the responsible party. Fine of Rs. 10,000 imposed.',
      'images': ['assets/reports/report7.jpg'],
      'priority': 'High',
      'coordinates': '19.0178° N, 72.8478° E',
    },
    {
      'id': 'REP-998',
      'title': 'Concrete Around Tree Base',
      'location': 'Worli, Mumbai',
      'dateReported': '10 May 2023',
      'dateResolved': '13 May 2023',
      'reportedBy': 'Municipal Worker',
      'citizenName': 'Ganesh Sawant',
      'resolutionOfficer': 'Officer Priya Sharma',
      'status': 'Resolved',
      'description': 'Construction site has put concrete around the base of trees which is harmful for their growth.',
      'resolution': 'Concrete removed and proper space created around the trees. Warning issued to the contractor.',
      'images': ['assets/reports/report8.jpg'],
      'priority': 'Medium',
      'coordinates': '19.0110° N, 72.8130° E',
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
        title: const Text('Reports & Violations'),
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.white,
          tabs: const [
            Tab(text: 'Pending (3)'),
            Tab(text: 'Resolved'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingReports(),
          _buildResolvedReports(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.darkGreen,
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddReportDialog();
        },
      ),
    );
  }
  
  Widget _buildPendingReports() {
    return _pendingReports.isEmpty
      ? _buildEmptyState('No pending reports')
      : ListView.builder(
          itemCount: _pendingReports.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final report = _pendingReports[index];
            return _buildReportCard(report, isPending: true);
          },
        );
  }
  
  Widget _buildResolvedReports() {
    return _resolvedReports.isEmpty
      ? _buildEmptyState('No resolved reports')
      : ListView.builder(
          itemCount: _resolvedReports.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final report = _resolvedReports[index];
            return _buildReportCard(report, isPending: false);
          },
        );
  }
  
  Widget _buildReportCard(Map<String, dynamic> report, {required bool isPending}) {
    final priorityColor = _getPriorityColor(report['priority']);
    
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.darkGreen.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${report['id']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: priorityColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getPriorityIcon(report['priority']),
                        color: priorityColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        report['priority'],
                        style: TextStyle(
                          color: priorityColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        report['location'],
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Reported: ${report['dateReported']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'By: ${report['reportedBy']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  report['description'],
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                if ((report['images'] as List).isNotEmpty)
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (report['images'] as List).length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(report['images'][index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showReportDetails(report);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.darkGreen),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                    if (isPending) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showInvestigationOptions(report);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.darkGreen,
                          ),
                          child: const Text('Investigate'),
                        ),
                      ),
                    ],
                  ],
                ),
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
            Icons.announcement_outlined,
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case 'High':
        return Icons.priority_high;
      case 'Medium':
        return Icons.rectangle;
      case 'Low':
        return Icons.arrow_downward;
      default:
        return Icons.help_outline;
    }
  }

  void _showReportDetails(Map<String, dynamic> report) {
    final bool isResolved = report.containsKey('dateResolved');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppTheme.darkGreen,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          report['id'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      report['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Status: ${report['status']}',
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getPriorityIcon(report['priority']),
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${report['priority']} Priority',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((report['images'] as List).isNotEmpty) ...[
                        const Text(
                          'Photos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (report['images'] as List).length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 120,
                                height: 120,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(report['images'][index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailItem('Location', report['location'], Icons.location_on),
                      _buildDetailItem('Coordinates', report['coordinates'], Icons.map),
                      _buildDetailItem('Reported By', report['reportedBy'], Icons.person),
                      _buildDetailItem('Contact Person', report['citizenName'], Icons.contacts),
                      if (report.containsKey('citizenContact'))
                        _buildDetailItem('Contact Number', report['citizenContact'], Icons.phone),
                      _buildDetailItem('Date Reported', report['dateReported'], Icons.event),
                      if (isResolved)
                        _buildDetailItem('Date Resolved', report['dateResolved'], Icons.event_available),
                      if (isResolved)
                        _buildDetailItem('Resolved By', report['resolutionOfficer'], Icons.person_outline),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(report['description']),
                      ),
                      if (isResolved) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Resolution',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.lightMintGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(report['resolution']),
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (!isResolved)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showInvestigationOptions(report);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.darkGreen,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.assignment),
                            label: const Text('Investigate & Resolve'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInvestigationOptions(Map<String, dynamic> report) {
    final TextEditingController remarksController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Investigate Report ${report['id']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please select your action for this report:',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Officer Remarks/Resolution:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: remarksController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your findings and actions taken',
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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Site visit scheduled'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text('Schedule Site Visit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _resolveReport(report, remarksController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              child: const Text('Resolve'),
            ),
          ],
        );
      },
    );
  }

  void _resolveReport(Map<String, dynamic> report, String resolution) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report ${report['id']} resolved'),
        backgroundColor: AppTheme.darkGreen,
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Reports'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('All Reports', true),
              _buildFilterOption('High Priority', false),
              _buildFilterOption('Medium Priority', false),
              _buildFilterOption('Low Priority', false),
              _buildFilterOption('Illegal Cutting', false),
              _buildFilterOption('Tree Damage', false),
              _buildFilterOption('Other Violations', false),
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String label, bool isSelected) {
    return CheckboxListTile(
      title: Text(label),
      value: isSelected,
      activeColor: AppTheme.darkGreen,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        // No state changes in demo
      },
    );
  }

  void _showAddReportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Report'),
          content: const Text(
            'This action allows you to add a new report or violation. You can take photos, mark the location, and add details.',
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
                    content: Text('New report creation initiated'),
                    backgroundColor: AppTheme.darkGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
} 