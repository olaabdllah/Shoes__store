import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/favoritesProvider.dart';
import 'package:flutter_application_1/shared/appstyle.dart';
import 'package:flutter_application_1/ui/favorites.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ProudctCard extends StatefulWidget {
  const ProudctCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProudctCard> createState() => _ProudctCardState();
}

class _ProudctCardState extends State<ProudctCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();
    bool selected = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: 
                          NetworkImage("https://i.pinimg.com/236x/b7/e4/d5/b7e4d5cb88db2bd8fe2026746853fc2e.jpg"))),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (favoritesNotifier.ids.contains(widget.id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorites()));
                        } else {
                          favoritesNotifier.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });
                        }
                        setState(() {
                          
                        });
                      },
                      child: favoritesNotifier.ids.contains(widget.id)
                          ? const Icon(AntDesign.heart_fill)
                          : const Icon(AntDesign.heart_outline),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: appstyleWithHt(
                            36, Colors.black, FontWeight.bold, 1.1)),
                    Text(
                      widget.category,
                      style:
                          appstyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: appstyle(18, Colors.grey, FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "Colors",
                            style: appstyle(18, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ChoiceChip(
                            label: const Text(""),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                          ),
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
  