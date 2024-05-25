import 'package:flutter_application_1/controllers/favoritesProvider.dart';
import 'package:flutter_application_1/controllers/proudct_provide.dart';
import 'package:flutter_application_1/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../shared/homeWidget.dart';
import '../shared/reusable_Text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var proudctNotifier = Provider.of<ProudctNotifier>(context);
    proudctNotifier.getMale();
    proudctNotifier.getFemale();
    proudctNotifier.getKids();

    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();
    return Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height:812.h,
          width: 375.w,
          child: Stack(
            children: [
              Container(
                padding:  EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
                height: 325.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/top_image.png"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 15),
                  width: 375.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: reusableText(
                          text:
                          "Good Shoes",
                          style: appstyleWithHt(
                              44, Colors.white, FontWeight.bold, 1.5),
                        ),
                      ),
                      Center(
                        child: reusableText(
                          text:
                          "Collection",
                          style: appstyleWithHt(
                              40, Colors.white, FontWeight.bold, 1.2),
                        ),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          tabs: const [
                            Tab(
                              text: "Men Shoes",
                            ),
                            Tab(
                              text: "Women Shoes",
                              ),
                            Tab(
                              text: "Kids Shoes",
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                      male: proudctNotifier.male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: proudctNotifier.female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: proudctNotifier.kids,
                      tabIndex: 2,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
