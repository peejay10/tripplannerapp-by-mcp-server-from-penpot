import 'package:flutter/material.dart';
import 'trip_data.dart'; // import เพื่อบันทึกข้อมูล
import 'main_screen.dart'; // import เพื่อกลับหน้าหลัก

class BookingSummaryScreen extends StatefulWidget {
  // เพิ่มตัวแปรรับค่าจากหน้าก่อนหน้า
  final String tripName;
  final String date;
  final String priceStr; // เช่น "฿ 10,000"

  const BookingSummaryScreen({
    Key? key, 
    required this.tripName, 
    required this.date, 
    required this.priceStr
  }) : super(key: key);

  @override
  _BookingSummaryScreenState createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  int passengerCount = 1;
  late int pricePerPerson;

  @override
  void initState() {
    super.initState();
    // แปลง string ราคา "฿ 10,000" ให้เป็นตัวเลข int เพื่อคำนวณ
    String cleanPrice = widget.priceStr.replaceAll(RegExp(r'[^0-9]'), ''); // ลบตัวหนังสือออกเหลือแต่เลข
    pricePerPerson = int.tryParse(cleanPrice) ?? 0;
  }

  void _incrementPassenger() {
    setState(() {
      passengerCount++;
    });
  }

  void _decrementPassenger() {
    if (passengerCount > 1) {
      setState(() {
        passengerCount--;
      });
    }
  }

  int get totalPrice => passengerCount * pricePerPerson;

  void _confirmBooking() {
    // 1. บันทึกข้อมูลลงสมุดกลาง (Trip Data)
    bookedTrips.add({
      'name': widget.tripName,
      'desc': widget.date, // ใช้วันที่แทนคำบรรยาย
      'status': 'Upcoming', // สถานะเริ่มต้น
      'statusColor': const Color(0xFF00FF47),
      'rating': 5.0,
      'reviewCount': '0',
      'price': '฿ ${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', // แปลงกลับเป็นฟอร์แมตเงิน
    });

    // 2. โชว์ Dialog สำเร็จ
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Confirmed! 🎉'),
          content: const Text('Your trip has been saved to My Trips.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
                
                // 3. เด้งกลับไปหน้า MainScreen (เคลียร์หน้าเก่าออกให้หมด)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()), 
                  (route) => false,
                );
              },
              child: const Text('OK', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFFDCC898),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Booking Summary',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Trip Name and Date
            Container(
              color: const Color(0xFFDCC898),
              padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tripName, // ใช้ชื่อจริง
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                      const SizedBox(width: 8),
                      Text(
                        widget.date, // ใช้วันที่จริง
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Passenger Selector
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Number of Passengers',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _decrementPassenger,
                                icon: const Icon(Icons.remove_circle_outline, size: 32),
                                color: Colors.green[700],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$passengerCount',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: _incrementPassenger,
                                icon: const Icon(Icons.add_circle_outline, size: 32),
                                color: Colors.green[700],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Total Price: ฿ ${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF388E3C)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Itinerary List
                    const Text('Trip Itinerary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    // ... (ส่วน ExpansionTile ใช้ของเดิมได้เลยครับ หรือจะก็อปจากที่ผมส่งให้อันก่อนก็ได้)
                     _buildItineraryList(), 
                  ],
                ),
              ),
            ),

            // Confirm Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2EF000),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // แยก Widget Itinerary ออกมาเพื่อให้โค้ดอ่านง่าย
  Widget _buildItineraryList() {
    return Column(
      children: [
        _buildDayTile('Day 1: Departure', [
            _buildItineraryItem('20:30', 'นัดพบที่สนามบินสุวรรณภูมิ'),
            _buildItineraryItem('23:00', 'ออกเดินทางสู่ปารีส'),
        ]),
        _buildDayTile('Day 2: Arrival', [
             _buildItineraryItem('08:00', 'ถึงสนามบินชาร์ล เดอ โกล'),
             _buildItineraryItem('14:00', 'เช็คอินเข้าที่พัก'),
        ]),
        // เพิ่มวันอื่นๆ ตามต้องการ...
      ],
    );
  }

  Widget _buildDayTile(String title, List<Widget> children) {
      return ExpansionTile(
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(children: children),
            )
        ],
      );
  }

  Widget _buildItineraryItem(String time, String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$time ', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(activity, style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
        ],
      ),
    );
  }
}