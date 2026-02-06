import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  void resetOtp() {
    otpController.clear();
    otpFocusNode.requestFocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String otp = otpController.text;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => otpFocusNode.requestFocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Image.asset(
                    'assets/otp.jpg',
                    height: 160,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Enter the verification code we just sent to your\nnumber +91 ******${widget.phoneNumber.substring(6)}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () => otpFocusNode.requestFocus(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 45,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: index == otp.length
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          child: Text(
                            index < otp.length ? otp[index] : '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: TextField(
                      controller: otpController,
                      focusNode: otpFocusNode,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "59 Sec",
                    style: TextStyle(color: Colors.red),
                  ),

                  const SizedBox(height: 6),

                  const Text.rich(
                    TextSpan(
                      text: "Don't Get OTP? ",
                      children: [
                        TextSpan(
                          text: "Resend",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

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
                        final bool isValidOtp =
                            context.read<AuthProvider>().verifyOtp(otp);

                        if (isValidOtp) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        } else {
                          resetOtp();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid OTP"),
                            ),
                          );
                        }
                      },
                      child: const Text("Verify"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
