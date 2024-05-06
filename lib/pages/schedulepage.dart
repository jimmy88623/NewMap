import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class schedulepage extends StatefulWidget {
  const schedulepage({super.key});

  @override
  State<StatefulWidget> createState() => _schedulepageState();
}

class _schedulepageState extends State<schedulepage> {
  TextEditingController _begindateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'begin Date :',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _begindateController,
                      decoration: InputDecoration(
                        filled: true,
                        prefix: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.calendar_today),
                        ),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(true);
                        print(
                            "current _begindateController value is :　${_begindateController.text}");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'end Date :',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _enddateController,
                      decoration: InputDecoration(
                        filled: true,
                        prefix: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.calendar_today),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
