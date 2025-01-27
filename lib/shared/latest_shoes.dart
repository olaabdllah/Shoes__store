import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sneaker_model.dart';
import 'package:flutter_application_1/shared/stagger_tile.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// ignore: camel_case_types
class latestShoes extends StatelessWidget {
  const latestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              itemCount: male!.length,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (index) => StaggeredTile.extent(
                  (index % 2 == 0) ? 1 : 1,
                  (index % 4 == 1 || index % 4 == 3)
                      ? MediaQuery.of(context).size.height * 0.38
                      : MediaQuery.of(context).size.height * 0.4),
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return StaggerTile(
                    imageUrl: shoe.imageUrl[0],
                    name: shoe.name,
                    price: shoe.price);
              },
            );
          }
        });
  }
}
