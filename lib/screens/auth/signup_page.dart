import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFE1F1F2,
      ), // ganti warna background sesuai Figma
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(20),
                        isSelected: const [false, true],
                        onPressed: (int index) {},
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Login'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Sign Up'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Full Name
                      buildTextField(
                        Icons.person_outline,
                        'Full Name',
                        'add your full name',
                      ),

                      // Email
                      buildTextField(
                        Icons.email_outlined,
                        'Email Address',
                        'add your email',
                      ),

                      // Role
                      buildDropdown(),

                      // School
                      buildTextField(
                        Icons.school_outlined,
                        'School',
                        'add your institution',
                      ),

                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF83C3C1),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: const [
            Icon(Icons.person_2_outlined, size: 20),
            SizedBox(width: 8),
            Text('Role'),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
          hint: const Text('choose'),
          items: const [
            DropdownMenuItem(value: 'student', child: Text('Student')),
            DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
            DropdownMenuItem(value: 'parent', child: Text('parent')),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
