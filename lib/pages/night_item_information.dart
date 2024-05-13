import 'package:flutter/material.dart';

class nightItemInformationPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const nightItemInformationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Food Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                data['image'],
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            Card(
              child: Padding(
                padding:const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child:
                            Text("Food Name", style: TextStyle(fontSize: 24))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["foodname"],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child:
                            Text("District", style: TextStyle(fontSize: 24))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["district"],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child:
                            Text("Location", style: TextStyle(fontSize: 24))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["location"],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}