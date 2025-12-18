import 'package:flutter/material.dart';
import 'view_details_screen.dart';
import 'trip_data.dart'; // <--- สำคัญมาก: ต้อง Import เพื่อดึงข้อมูลจริง

class MyTripsScreen extends StatefulWidget {
  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _selectedTab = 0; // 0 = Upcoming, 1 = Past Trips

  @override
  Widget build(BuildContext context) {
    // กำหนดสีและข้อความตาม Tab ที่เลือก
    final bool isUpcoming = _selectedTab == 0;
    
    // ---------------------------------------------------------
    // จุดเปลี่ยนสำคัญ: ดึงข้อมูลจากไฟล์ trip_data.dart โดยตรง
    // ---------------------------------------------------------
    final List<Map<String, dynamic>> currentList = isUpcoming ? bookedTrips : pastTrips;
    
    final headerTitle = isUpcoming ? 'My Trips' : 'My Past Trips';
    final headerSubtitle = '${currentList.length} Trips ${isUpcoming ? "Ready to go!!!" : "Completed!!!"}';
    final headerColor = const Color(0xFFDCC898);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.history, size: 40, color: Color(0xFF5A4E32)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headerTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A4E32),
                                ),
                              ),
                              Text(
                                headerSubtitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5A4E32).withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.notifications_outlined, color: Color(0xFF5A4E32)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Tabs
                  Row(
                    children: [
                      Expanded(
                        child: _buildCustomTabButton(
                          text: 'Upcoming',
                          icon: Icons.flight_takeoff,
                          isActive: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildCustomTabButton(
                          text: 'Past Trips',
                          icon: Icons.check_circle_outline,
                          isActive: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Trip List
            Expanded(
              child: currentList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text('No trips yet', style: TextStyle(color: Colors.grey[400], fontSize: 18)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final trip = currentList[index];
                        return _buildTripCard(trip);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget ปุ่ม Tab
  Widget _buildCustomTabButton({
    required String text,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFC5A659) : const Color(0xFFC5A659).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 2), blurRadius: 4)]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Widget การ์ดทริป
  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
              ),
              Positioned(
                top: 12, left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: trip['statusColor'],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(trip['status'] == 'On Going' ? Icons.check_circle : Icons.flag, size: 12, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(trip['status'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trip['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(trip['desc'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8E669),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text('${trip['rating']} (${trip['reviewCount']} reviews)', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Budget', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text('${trip['price']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDetailsScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2EF000),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      child: const Row(
                        children: [
                          Text('View Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}