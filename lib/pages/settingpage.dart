import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingpage extends StatefulWidget {
  const settingpage({super.key});

  @override
  State<StatefulWidget> createState() => _settingpageState();
}

class _settingpageState extends State<settingpage>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/iu.png'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){},
                child: Text('account'),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text('setting'),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text('preference'),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text('logout'),
              ),
            ],
          ),
        )


      ],
    );
  }
}