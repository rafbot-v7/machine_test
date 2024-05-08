import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/device/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '''{
        "deviceType": "andriod",
        "deviceId": "C6179909526094",
        "deviceName": "Samsung-MT200",
        "deviceOSVersion": "2.3.6",
        "deviceIPAddress": "11.433.445.66",
        "lat": 9.9312,
        "long": 76.2673,
        "buyer_gcmid": "",
        "buyer_pemid": "",
        "app": {
          "version": "1.20.5",
          "installTimeStamp": "2022-02-10T12:33:30.696Z",
          "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
          "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
        }
      }''',
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
