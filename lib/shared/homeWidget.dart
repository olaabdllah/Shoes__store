import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sneaker_model.dart';
import 'package:flutter_application_1/shared/appstyle.dart';
import 'package:flutter_application_1/shared/new_shoes.dart';
import 'package:flutter_application_1/shared/proudct_card.dart';
import 'package:flutter_application_1/ui/product_page.dart';
import 'package:flutter_application_1/ui/proudct_by_cat.dart';
import 'package:provider/provider.dart';
import '../controllers/proudct_provide.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var proudctNotifier = Provider.of<ProudctNotifier>(context);

    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            proudctNotifier.shoeSizes = shoe.sizes;
                            // ignore: avoid_print
                            print(proudctNotifier.shoeSizes);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // ignore: non_constant_identifier_names
                                    builder: (Context) => ProudctPage(
                                          id: shoe.id,
                                          category: shoe.category,
                                        )));
                          },
                          child: ProudctCard(
                            price: "\$${shoe.price}",
                            category: shoe.category,
                            id: shoe.id,
                            name: shoe.name,
                            image:
                                shoe.imageUrl[0],
                          ),
                        );
                      },
                    );
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProudctByCat(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(22, Colors.black, FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_circle_right),
                        
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    
                    return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewShoes(imageUrl: shoe.imageUrl[0]),
                        );
                      },
                    );
                  }
                })),
      ],
    );
  }
}
