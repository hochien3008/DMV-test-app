import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver\'s Manual'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Traffic Signs', Icons.traffic, [
            'Stop signs require complete stop',
            'Yield signs mean slow down and give right of way',
            'Speed limit signs show maximum speed',
            'Warning signs alert to potential hazards',
          ]),
          const SizedBox(height: 16),
          _buildSection('Right of Way', Icons.directions_car, [
            'Emergency vehicles always have right of way',
            'Pedestrians in crosswalks have right of way',
            'First vehicle at intersection goes first',
            'Right turns on red are allowed unless posted',
          ]),
          const SizedBox(height: 16),
          _buildSection('Speed Limits', Icons.speed, [
            'Residential areas: 25 mph',
            'Highways: 55-65 mph',
            'School zones: 15-20 mph',
            'Always follow posted speed limits',
          ]),
          const SizedBox(height: 16),
          _buildSection('Parking Rules', Icons.local_parking, [
            'No parking within 15 feet of fire hydrant',
            'No parking in handicapped spaces without permit',
            'Parallel parking on streets',
            'Follow posted parking restrictions',
          ]),
          const SizedBox(height: 16),
          _buildSection('Emergency Procedures', Icons.emergency, [
            'Pull over for emergency vehicles',
            'Use hazard lights when stopped',
            'Call 911 for accidents with injuries',
            'Exchange information after accidents',
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<String> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[600], size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
