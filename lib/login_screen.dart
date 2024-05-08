import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  Future<void> requestOTP(BuildContext context, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "mobileNumber": phoneNumber,
          "deviceId": "62b341aeb0ab5ebe28a758a3",
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/otp');
      } else {
        print('Failed to request OTP: ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to request OTP'),
          ),
        );
        Navigator.pushNamed(context, '/otp');
      }
    } catch (e) {
      print('Error requesting OTP: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error requesting OTP'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (phoneNumber.isNotEmpty) {
                  requestOTP(context, phoneNumber);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your phone number'),
                    ),
                  );
                }
              },
              child: Text('Request OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
