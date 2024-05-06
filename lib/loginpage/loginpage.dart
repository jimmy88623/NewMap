import 'package:flutter/material.dart';
import 'package:new_map/pages/homepage.dart';

class loginpage extends StatefulWidget {
  loginpage({super.key});

  @override
  State<StatefulWidget> createState() => _loginpagestate();
}

class _loginpagestate extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/logo.jpg"),
          //輸入帳號密碼部分
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.1,
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: const Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "input your account",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "input your passward",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => homepage(),),
                );
              },
              child: const Text('登入')),
        ],
      ),
    );
  }
}
