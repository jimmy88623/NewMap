import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'night_item_information.dart';
import 'package:google_translate/google_translate.dart';

class schedulePage extends StatefulWidget {
  const schedulePage({super.key});

  @override
  State<StatefulWidget> createState() => _schedulePageState();
}

class _schedulePageState extends State<schedulePage> {
  final String apiKey = "AIzaSyADc4aVVOm0VBXTUCalXX6Oqfkg1wE3vXg";
  final TextEditingController searchController = TextEditingController();
  List<dynamic> nightItems = [];
  String dropdownValue = "中文";
  String? selectMarket = null;
  Set<String> searchMarkets = {};
  bool showText = false;
  bool pressMarket = false;

  Future<void> _loadMenuItems() async {
    String jsonData = await rootBundle.loadString('assets/nightfood.json');
    setState(() {
      nightItems = json.decode(jsonData);
    });
  }

  Future<String> translateText(String text, String targetLanguage) async {
    String translation = await text.translate(
        sourceLanguage: 'zh', targetLanguage: targetLanguage);
    return translation;
  }

  Set<String> searchNightMarketsByDistrict(
      String district, List<dynamic> nightItems) {
    Set<String> nightMarkets = {};
    for (var market in nightItems) {
      if (market['district'] == district) {
        nightMarkets.add(market['location']);
      }
    }
    return nightMarkets;
  }

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: '中文',
                      child: Text('中文'),
                    ),
                    DropdownMenuItem<String>(
                      value: '日文',
                      child: Text('日文'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SearchBar(
                  controller: searchController,
                  trailing: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            pressMarket = false;
                            selectMarket = null;
                            print(searchController.text);
                            FocusScope.of(context).unfocus();
                            //searchController.text是user的輸入(...區)、nightItems是整個夜市json
                            searchMarkets = searchNightMarketsByDistrict(
                                searchController.text, nightItems);
                            showText = true;
                          });
                        },
                        icon: const Icon(Icons.search)),
                  ],
                  hintText: '你想查詢台南哪區夜市...',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // if (showText && searchController.text.isNotEmpty)
                //   Text('以下為${searchController.text}的夜市!!'),
                if (showText && searchController.text.isNotEmpty)
                  Container(
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DropdownButton(
                            value: selectMarket, // 当前选择的市场
                            onChanged: (String? newValue) { // 当用户选择了一个新的市场时调用的回调函数
                              setState(() {
                                selectMarket = newValue!; // 更新选择的市场
                                pressMarket = true;
                              });
                            },
                            items: searchMarkets.map<DropdownMenuItem<String>>((String market) {
                              return DropdownMenuItem<String>(
                                value: market,
                                child: Text(market),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                if (pressMarket)
                  Container(
                    color: Colors.yellow,
                    child: SingleChildScrollView(
                      child: Column(
                        children: nightItems.map((item) {
                          if (item['location'] == selectMarket) {
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.star),
                                trailing: Icon(Icons.star),
                                title: Text('店家名稱: ${item['foodname']}'),
                                subtitle: Text('地區${item['district']}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => nightItemInformationPage(data: item),
                                    ),
                                  );
                                  print(item);
                                },
                              ),
                            );
                          } else {
                            return SizedBox(); // 如果不符合条件，返回一个空的 SizedBox
                          }
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
