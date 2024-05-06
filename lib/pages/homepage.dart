import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_map/pages/settingpage.dart';
import 'package:new_map/pages/schedulepage.dart';
import 'package:new_map/pages/mappage.dart';
import 'package:new_map/pages/playpage.dart';


class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<StatefulWidget> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController _begindateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();

  int _currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('極致智能旅遊'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _currentPageIndex,
        onTap: (currentPageIndex) {
          print("currentPageIndex : $currentPageIndex");
          //即時更新currentPageIndex
          _onPageChanged(currentPageIndex);
          //跳轉到對應index頁面
          _buildScreen()[currentPageIndex];
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
      body: _buildScreen()[_currentPageIndex],
    );
  }

  List<Widget> _buildScreen() {
    return [
      schedulepage(),
      mappage(),
      playpage(),
      settingpage(),
    ];
  }

  Future<void> _selectDate(bool isBeginDate) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        if (isBeginDate) {
          _begindateController.text = picked.toString().split(" ")[0];
          print(
              "current _begindateController value is :　${_begindateController.text}");
        } else {
          _enddateController.text = picked.toString().split(" ")[0];
          print(
              "current _enddateController value is :　${_enddateController.text}");
        }
      });
    }
  }
}
