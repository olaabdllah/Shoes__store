import 'package:flutter_application_1/shared/appstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/proudct_provide.dart';
import 'package:flutter_application_1/ui/favorites.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../controllers/favoritesProvider.dart';
import '../models/sneaker_model.dart';
import '../shared/checkOut_btn.dart';

class ProudctPage extends StatefulWidget {
  const ProudctPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProudctPage> createState() => _ProudctPageState();
}

class _ProudctPageState extends State<ProudctPage> {
  final PageController pageController = PageController();
final _cartBox=Hive.box('cart_box');


  

  
Future<void>_createCart(Map<String,dynamic> newCart)async{
await _cartBox.add(newCart);
}
 

  @override
  Widget build(BuildContext context) {
    var proudctNotifier=Provider.of<ProudctNotifier>(context,listen: true);
     proudctNotifier .getShoes(widget.category,widget.id);
    var favoritesNotifier=Provider.of<FavoritesNotifier>(context,listen: true);
     favoritesNotifier.getFavorites();
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: proudctNotifier.snakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProudctNotifier>(
                    builder: (context, proudctNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  proudctNotifier.shoeSizes.clear();
                                },
                                child: const Icon(Icons.close),
                              ),
                              GestureDetector(
                                onTap: null,
                                child: const Icon(IonIcons.ellipsis_horizontal,color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.white,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    proudctNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            right: 20,
                                            child: Consumer<FavoritesNotifier>(
                                              builder: (context,
                                                  favoritesNotifier, child) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      if (favoritesNotifier.ids
                                                          .contains(
                                                              widget.id)) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        const Favorites())));
                                                      } else {
                                                        favoritesNotifier.createFav({
                                                          "id": sneaker.id,
                                                          "name": sneaker.name,
                                                          "category":
                                                              sneaker.category,
                                                          "price":
                                                              sneaker.price,
                                                          "imageUrl": sneaker
                                                              .imageUrl[0],
                                                        });
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: favoritesNotifier.ids.contains(
                                                            sneaker.id)

                                                        ? const Icon( Ionicons.heart)
                                                        : const Icon(Ionicons.heart_circle_outline));

                                              },
                                            )),
                                           

                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List<Widget>.generate(
                                                sneaker.imageUrl.length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              proudctNotifier
                                                                          .activePage !=
                                                                      index
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black),
                                                    )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                              bottom: 30,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appstyle(40, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appstyle(20, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                  initialRating: 4,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                        Icons.star,
                                                        size: 14,
                                                        color: Colors.black,
                                                      ),
                                                  onRatingUpdate: (rating) {})
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appstyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select Size",
                                                    style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "View Size guide",
                                                    style: appstyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                    itemCount: proudctNotifier
                                                        .shoeSizes.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final sizes =
                                                          proudctNotifier
                                                              .shoeSizes[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: ChoiceChip(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60),
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    style: BorderStyle
                                                                        .solid)),
                                                            disabledColor:
                                                                Colors.white,
                                                            label: Text(
                                                              sizes['size'],
                                                              style: appstyle(
                                                                  18,
                                                                  sizes['isSelected']
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            selectedColor:
                                                                Colors.black,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8),
                                                            selected: sizes[
                                                                'isSelected'],
                                                            onSelected:
                                                                (newState) {
                                                              if (proudctNotifier
                                                                  .sizes
                                                                  .contains(sizes[
                                                                      'size'])) {
                                                                proudctNotifier
                                                                    .sizes
                                                                    .remove(sizes[
                                                                        'size']);
                                                              } else {
                                                                proudctNotifier
                                                                    .sizes
                                                                    .add(sizes[
                                                                        'size']);
                                                              }
                                                              print(
                                                                  proudctNotifier
                                                                      .sizes);
                                                              proudctNotifier
                                                                  .toggleCheck(
                                                                      index);
                                                            }),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.grey),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              sneaker.title,
                                              style: appstyle(26, Colors.black,
                                                  FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            sneaker.description,
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                            style: appstyle(20, Colors.black,
                                                FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: checkoutButton(
                                                  onTap: () async {
                                                    _createCart({
                                                      "id": sneaker.id,
                                                      "name": sneaker.name,
                                                      "category":
                                                          sneaker.category,
                                                      "sizes": sneaker.sizes,
                                                      "imgeUrl":
                                                          sneaker.imageUrl[0],
                                                      "price": sneaker.price,
                                                      "qty": 1
                                                    });
                                                    proudctNotifier.sizes
                                                        .clear();
                                                    Navigator.pop(context);
                                                  },
                                                  label: 'Add to cart ',
                                                ),
                                              ))
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  );
                });
              }
            }));
  }
}
