import 'package:flutter/material.dart';
import 'package:tree_app/constants/app_theme.dart';

class TreeMapScreen extends StatefulWidget {
  const TreeMapScreen({Key? key}) : super(key: key);

  @override
  State<TreeMapScreen> createState() => _TreeMapScreenState();
}

class _TreeMapScreenState extends State<TreeMapScreen> {
  int _selectedFilter = 0;
  bool _showFilters = false;

  final List<String> _filterOptions = [
    'All Trees',
    'Protected Trees',
    'Heritage Trees',
    'Newly Planted',
    'To Be Cut',
    'Area Wise'
  ];

  final List<Map<String, dynamic>> _treeMarkers = [
    {
      'id': 'TR-1001',
      'species': 'Banyan',
      'age': '~50 years',
      'height': '18 meters',
      'girth': '3.2 meters',
      'status': 'Protected',
      'location': '19.0760° N, 72.8777° E',
      'address': 'Near Dadar Station, Mumbai',
      'image': 'assets/trees/banyan1.jpg',
    },
    {
      'id': 'TR-1002',
      'species': 'Peepal',
      'age': '~35 years',
      'height': '15 meters',
      'girth': '2.8 meters',
      'status': 'Heritage',
      'location': '19.0728° N, 72.8826° E',
      'address': 'Shivaji Park, Mumbai',
      'image': 'assets/trees/peepal1.jpg',
    },
    {
      'id': 'TR-1003',
      'species': 'Neem',
      'age': '~20 years',
      'height': '12 meters',
      'girth': '1.5 meters',
      'status': 'Regular',
      'location': '19.1136° N, 72.8697° E',
      'address': 'Jogeshwari East, Mumbai',
      'image': 'assets/trees/neem1.jpg',
    },
    {
      'id': 'TR-1004',
      'species': 'Tamarind',
      'age': '~40 years',
      'height': '16 meters',
      'girth': '2.4 meters',
      'status': 'Heritage',
      'location': '19.0330° N, 72.8296° E',
      'address': 'Bandra Fort, Mumbai',
      'image': 'assets/trees/tamarind1.jpg',
    },
    {
      'id': 'TR-1005',
      'species': 'Gulmohar',
      'age': '~15 years',
      'height': '10 meters',
      'girth': '1.2 meters',
      'status': 'To Be Cut',
      'location': '19.0821° N, 72.8416° E',
      'address': 'Santacruz West, Mumbai',
      'image': 'assets/trees/gulmohar1.jpg',
      'applicationId': 'APP-23046',
    },
    {
      'id': 'TR-1006',
      'species': 'Palm',
      'age': '~8 years',
      'height': '6 meters',
      'girth': '0.8 meters',
      'status': 'Newly Planted',
      'location': '19.1176° N, 72.9060° E',
      'address': 'Powai Garden, Mumbai',
      'image': 'assets/trees/palm1.jpg',
      'plantingDate': '10 Jan 2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMap(),
          _buildHeader(),
          if (_showFilters) _buildFilterPanel(),
          _buildBottomPanel(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Current Location button
          FloatingActionButton(
            mini: true,
            heroTag: 'locationBtn',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Getting current location...'),
                  backgroundColor: AppTheme.darkGreen,
                ),
              );
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.my_location, color: AppTheme.darkGreen),
          ),
          const SizedBox(height: 10),
          // Filter button
          FloatingActionButton(
            mini: true,
            heroTag: 'filterBtn',
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            backgroundColor: _showFilters ? AppTheme.darkGreen : Colors.white,
            child: Icon(
              Icons.filter_list,
              color: _showFilters ? Colors.white : AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 10),
          // Add Tree button
          FloatingActionButton(
            heroTag: 'addTreeBtn',
            onPressed: () {
              _showAddTreeDialog();
            },
            backgroundColor: AppTheme.darkGreen,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Image.asset(
      'assets/map_sample.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Text(
                    'Tree Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getIconForFilter(_filterOptions[_selectedFilter]),
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _filterOptions[_selectedFilter],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search trees, areas...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForFilter(String filter) {
    switch (filter) {
      case 'All Trees':
        return Icons.forest;
      case 'Protected Trees':
        return Icons.security;
      case 'Heritage Trees':
        return Icons.star;
      case 'Newly Planted':
        return Icons.new_releases;
      case 'To Be Cut':
        return Icons.content_cut;
      case 'Area Wise':
        return Icons.map;
      default:
        return Icons.forest;
    }
  }

  Widget _buildFilterPanel() {
    return Positioned(
      top: 140,
      right: 16,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Trees',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              _filterOptions.length,
              (index) => RadioListTile<int>(
                title: Text(
                  _filterOptions[index],
                  style: const TextStyle(fontSize: 14),
                ),
                value: index,
                groupValue: _selectedFilter,
                dense: true,
                activeColor: AppTheme.darkGreen,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                    _showFilters = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trees in View',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    color: AppTheme.darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _treeMarkers.length,
                itemBuilder: (context, index) {
                  final tree = _treeMarkers[index];
                  return GestureDetector(
                    onTap: () {
                      _showTreeDetails(tree);
                    },
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              tree['image'],
                              height: 80,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      tree['species'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(tree['status']).withValues(alpha:0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: _getStatusColor(tree['status']),
                                        ),
                                      ),
                                      child: Text(
                                        tree['status'],
                                        style: TextStyle(
                                          color: _getStatusColor(tree['status']),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tree['address'],
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Age: ${tree['age']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Protected':
        return Colors.green;
      case 'Heritage':
        return Colors.purple;
      case 'Regular':
        return Colors.blue;
      case 'To Be Cut':
        return Colors.red;
      case 'Newly Planted':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showTreeDetails(Map<String, dynamic> tree) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      tree['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(tree['status']).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tree['status'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha:0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
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
                                '${tree['species']} Tree',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${tree['id']}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to directions
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Navigating to tree location...'),
                                  backgroundColor: AppTheme.darkGreen,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.darkGreen,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: const Icon(Icons.directions, size: 18),
                            label: const Text('Directions'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow('Location', tree['address'], Icons.location_on),
                      _buildDetailRow('Coordinates', tree['location'], Icons.my_location),
                      _buildDetailRow('Age', tree['age'], Icons.access_time),
                      _buildDetailRow('Height', tree['height'], Icons.height),
                      _buildDetailRow('Girth', tree['girth'], Icons.radar),
                      if (tree['status'] == 'Newly Planted')
                        _buildDetailRow('Planting Date', tree['plantingDate'], Icons.calendar_today),
                      if (tree['status'] == 'To Be Cut')
                        _buildDetailRow('Application ID', tree['applicationId'], Icons.description),
                      const SizedBox(height: 20),
                      const Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildActionButton('Take Photo', Icons.camera_alt, Colors.blue),
                          const SizedBox(width: 12),
                          _buildActionButton('Report Issue', Icons.warning, Colors.orange),
                          const SizedBox(width: 12),
                          _buildActionButton('Add Note', Icons.note_add, Colors.purple),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActivityItem(
                        'Inspection completed',
                        '24 May 2023',
                        'Officer Amit Kumar',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      _buildActivityItem(
                        'Trimming performed',
                        '10 Apr 2023',
                        'Garden Department',
                        Icons.content_cut,
                        Colors.blue,
                      ),
                      _buildActivityItem(
                        'Tree health assessment',
                        '15 Feb 2023',
                        'Dr. Neha Singh (Botanist)',
                        Icons.favorite,
                        Colors.red,
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

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.lightMintGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.darkGreen, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
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
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label action initiated'),
              backgroundColor: color,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha:0.1),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String date,
    String by,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$date by $by',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTreeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Tree'),
          content: const Text(
            'This feature allows you to add a new tree to the map. You can take a photo, mark its location, and add details.',
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
                    content: Text('Tree adding process initiated'),
                    backgroundColor: AppTheme.darkGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
              ),
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }
} 