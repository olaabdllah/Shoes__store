import 'package:flutter_application_1/controllers/cart_provider.dart';
import 'package:flutter_application_1/shared/appstyle.dart';
import 'package:flutter_application_1/ui/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../shared/reusable_Text.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCard();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  AntDesign.close_circle_fill,
                  color: Colors.black,
                ),
              ),
              reusableText(
                text: "             My cart",
                style: appstyle(36, Colors.black, FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: cartProvider.cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cartProvider.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            (Radius.circular(12)),
                          ),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: doNothing,
                                    backgroundColor: const Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: "delete",
                                  )
                                ]),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: const Offset(0, 1),
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl: 'imageUrl',
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.fill,
                                              )),
                                          Positioned(
                                              bottom: -2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .deleteCart(data['key']);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainScreen()));
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    12)),
                                                  ),
                                                  child: const Icon(
                                                    AntDesign.delete_fill,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 14),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            reusableText(
                                              text: data['name'],
                                              style: appstyle(16, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            reusableText(
                                              text: data['category'],
                                              style: appstyle(14, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                reusableText(
                                                  text: data['price'],
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                reusableText(
                                                  text: 'size',
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                /*   reusableText(
                                                    text: '${data['sizes']}',
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),*/

                                                Text(
                                                  "${data['size']}",
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  AntDesign.minus_square_fill,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                              ),
                                              reusableText(
                                                text: data['qty'].toString(),
                                                style: appstyle(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  AntDesign.plus_square_fill,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
