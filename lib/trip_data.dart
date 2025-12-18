import 'package:flutter/material.dart';

// ปล่อยให้ว่างไว้ [] เพื่อรอรับข้อมูลใหม่จากการจอง
List<Map<String, dynamic>> bookedTrips = []; 

List<Map<String, dynamic>> pastTrips = [
  // (ข้อมูล Past Trips ปล่อยไว้เหมือนเดิมก็ได้ครับ)
  {
    'name': 'Bali Paradise',
    'desc': 'Bali for 4 day',
    'status': 'Completed',
    'statusColor': Colors.grey,
    'rating': 4.8,
    'reviewCount': '2,000',
    'price': '฿ 4,500',
  },
];