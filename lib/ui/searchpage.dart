import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/shared/appstyle.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> allShoes = [];
  List<dynamic> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAllShoesData();
  }

  Future<void> loadAllShoesData() async {
    List<String> fileNames = [
      'json/men_shoes.json',
      'json/women_shoes.json',
      'json/kids_shoes.json',
      // إضافة أسماء الملفات الأخرى هنا
    ];

    List<dynamic> shoes = [];

    for (var fileName in fileNames) {
      String jsonString = await rootBundle.loadString(fileName);
      List<dynamic> fileShoes = json.decode(jsonString);
      shoes.addAll(fileShoes);
    }

    setState(() {
      allShoes = shoes;
    });
  }

  void searchShoes(String keyword) {
    List<dynamic> results = allShoes
        .where((shoe) =>
            shoe['name'].toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
    });

    if (results.length == 1 &&
        results[0]['name'].toLowerCase() == keyword.toLowerCase()) {
      // إذا كان هناك منتج واحد وهو مطابق تمامًا للبحث
      Navigator.pop(context); // للعودة إلى الصفحة الرئيسية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sreach Page',
            style: appstyle(30, Colors.black, FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(
                        color: Colors.black), // تعيين لون الخط إلى الأبيض
                    onChanged: (value) {
                      searchShoes(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',

                      hintStyle: TextStyle(
                          color:
                              Colors.grey), // تعيين لون نص الاقتراح إلى الأبيض
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // تعيين لون حواف مربع البحث إلى الأسود
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // تعيين لون حواف مربع البحث عند التركيز إلى الأسود
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 24, // تعيين لون الأيقونة إلى الأبيض
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var shoe = searchResults[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shoe['name'],
                        style: appstyle(20, Colors.black, FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'category: ${shoe['category']}',
                        style: appstyle(14, Colors.grey, FontWeight.w600),
                      ),
                      Text(
                        'price: \$${shoe['price']}',
                        style: appstyle(18, Colors.black, FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
