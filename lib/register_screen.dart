import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  Future<void> _registerUser() async {
    var request = http.Request(
      'POST',
      Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/email/referral'),
    );
    request.headers['Content-Type'] = 'application/json';
    request.body = '''{
      "email": "${_emailController.text}",
      "password": "${_passwordController.text}",
      "referralCode": ${_referralCodeController.text},
      "userId": "${_userIdController.text}"
    }''';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pushNamed(context, '/home');
    } else {
      print(response.reasonPhrase);
      // Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller: _referralCodeController,
                decoration: InputDecoration(labelText: 'Referral Code'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _userIdController,
                decoration: InputDecoration(labelText: 'User ID'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
