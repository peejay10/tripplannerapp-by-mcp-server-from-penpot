import 'package:flutter/material.dart';
import 'booking_summary_screen.dart'; // <--- Import หน้าสรุปการจอง

class ViewDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('View Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. รูปภาพหลัก (ใช้ Placeholder สีเทา)
            Container(
              margin: const EdgeInsets.all(16),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 60, color: Colors.grey),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. ชื่อทัวร์
                  const Text(
                    'Parisian Dreams',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Paris for 5 day',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // 3. กล่อง Description (สีเหลือง)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9E076), // สีเหลืองตามดีไซน์
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Experience the magic of Paris with our guided city tour. Discover hidden gems, iconic landmarks, and unforgettable moments.',
                          style: TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. ส่วนเลือกวันที่ (Custom Cards)
                  const Text(
                    'Select Travel Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none, // เพื่อให้เงาไม่ถูกตัด
                    child: Row(
                      children: [
                        _buildDateCard(context, '15-20 oct 2026', '฿10,000'),
                        _buildDateCard(context, '25-30 oct 2026', '฿10,000'),
                        _buildDateCard(context, '26-1 sep 2026', '฿15,000'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 5. ส่วนรีวิว (Custom Cards)
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        _buildReviewCard(
                          'PEEJAY',
                          'เป็นทัวร์ที่ดีมาก!!!',
                          const Color(0xFFE6DFA3), // สีเหลืองอ่อน
                        ),
                        _buildReviewCard(
                          'คำปู้จู้',
                          'ฉันแนะนำเลย คุ้มค่ากับ\nเงินที่เสียไปมากๆ',
                          const Color(0xFFD4C28D), // สีออกน้ำตาลทอง
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40), // เว้นที่ด้านล่างหน่อย
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget สร้างการ์ดวันที่ (Date Card) - เพิ่ม context เพื่อใช้ Navigator
  Widget _buildDateCard(BuildContext context, String date, String price) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          
          // ปุ่ม Booking สีชมพู (เชื่อมต่อแล้ว)
          InkWell(
            onTap: () {
               // เมื่อกดแล้ว ส่งข้อมูลไปหน้า Booking Summary
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSummaryScreen(
                    tripName: 'Parisian Dreams', 
                    date: date,    // ส่งวันที่จากการ์ดนี้
                    priceStr: price, // ส่งราคาจากการ์ดนี้
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF94C6), // สีชมพู
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'booking',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget สร้างการ์ดรีวิว (Review Card)
  Widget _buildReviewCard(String name, String comment, Color bgColor) {
    return Container(
      width: 180,
      height: 120, // ฟิกความสูงให้เท่ากันเพื่อความสวย
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black87,
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.star, size: 14, color: Colors.amber),
              Icon(Icons.star, size: 14, color: Colors.amber),
              Icon(Icons.star, size: 14, color: Colors.amber),
              Icon(Icons.star, size: 14, color: Colors.amber),
              Icon(Icons.star, size: 14, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}