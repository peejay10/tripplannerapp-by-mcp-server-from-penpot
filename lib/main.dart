import 'package:flutter/material.dart';
import 'login_screen.dart'; // บรรทัดนี้สำคัญมาก คือการดึงไฟล์ที่เราเพิ่งสร้างมาใช้
import 'register_screen.dart'; // <--- 1. เพิ่มบรรทัดนี้
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // เอาป้าย Debug มุมขวาบนออก
      title: 'Trip Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginScreen(), // สั่งให้เปิดหน้า LoginScreen เป็นหน้าแรก
    );
  }
}