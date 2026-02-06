import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_test_app/screens/otp_screen.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? errorText;

  bool isValidPhone(String phone) {
    if (phone.length != 10) return false;
    if (!RegExp(r'^[6-9]').hasMatch(phone)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/login.jpg',
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'Enter Phone Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number *',
                  counterText: '',
                  errorText: errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    errorText = null;
                  });
                },
              ),

              const SizedBox(height: 6),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  children: [
                    TextSpan(text: 'By continuing, I agree to Company'),
                    TextSpan(
                      text: 'Terms and condition',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: ' & '),
                    TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    final phone = phoneController.text.trim();

                    if (!isValidPhone(phone)) {
                      setState(() {
                        errorText =
                            'Enter a valid 10-digit number starting with 6,7,8,9';
                      });
                      return;
                    }


                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => OtpScreen(
      phoneNumber: phoneController.text,
    ),
  ),
);

                  },
                  child: const Text('Get OTP'),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
