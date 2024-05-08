import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();

  Future<void> verifyOtp(String otp) async {
    try {
      final response = await http.post(
        Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp/verification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "otp": otp,
          "deviceId": "62b43472c84bb6dac82e0504",
          "userId": "62b43547c84bb6dac82e0525",
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/home');
      } else {
        print('Failed to verify OTP: ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to verify OTP'),
          ),
        );
        Navigator.pushNamed(context, '/register');
      }
    } catch (e) {
      print('Error verifying OTP: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying OTP'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String otp = _otpController.text;
                if (otp.isNotEmpty) {
                  verifyOtp(otp);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter OTP'),
                    ),
                  );
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
