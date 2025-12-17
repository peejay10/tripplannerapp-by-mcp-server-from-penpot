import 'package:flutter/material.dart';
import 'register_screen.dart'; // <--- 1. เพิ่มบรรทัดนี้เพื่อให้รู้จักหน้า Register
import 'main_screen.dart'; // <--- เติมบรรทัดนี้

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png',
                height: 100, // Adjust size as needed
                width: 100,
              ),
              const SizedBox(height: 40),

              // Welcome Back!
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Email TextField
              Container(
                width: 340,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.2),
                      offset: Offset(4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email address',
                    hintStyle: TextStyle(
                      color: Color(0xFF000000).withOpacity(0.38),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4).withOpacity(0.4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4).withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Password TextField
              Container(
                width: 340,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.2),
                      offset: Offset(4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xFF000000).withOpacity(0.38),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4).withOpacity(0.4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4).withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF6750A4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Forgot your password?
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000000).withOpacity(0.38),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Role: Members
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Role: Members',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Login Button
              Container(
                width: 268,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFECDC6C),
                      Color(0xFFF9F295),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.2),
                      offset: Offset(4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
  // สั่งให้เปลี่ยนหน้าไปที่ MainScreen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MainScreen()),
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Don't have an account? Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // <--- 2. แก้ตรงนี้: ใส่ GestureDetector เพื่อให้กดเปลี่ยนหน้าได้
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF000000).withOpacity(0.7),
                        fontWeight: FontWeight.bold, // ตัวหนาเพื่อให้รู้ว่ากดได้
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}