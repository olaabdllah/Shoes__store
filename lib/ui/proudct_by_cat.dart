import 'package:flutter_application_1/controllers/proudct_provide.dart';
import 'package:flutter_application_1/shared/category_btn.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../shared/Custom_Spacer.dart';
import '../shared/appstyle.dart';
import '../shared/latest_shoes.dart';

class ProudctByCat extends StatefulWidget {
  const ProudctByCat({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<ProudctByCat> createState() => _ProudctByCatState();
}

class _ProudctByCatState extends State<ProudctByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  List<String> brand = [
    "images/1.png",
    "images/2.png",
    "images/3.png",
    "images/3.png",
  ];
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var proudctNotifier = Provider.of<ProudctNotifier>(context);
    proudctNotifier.getFemale();
    proudctNotifier.getMale();
    proudctNotifier.getKids();
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/top_image.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              filter();
                            },
                            child: const Icon(
                              FontAwesome.sliders_solid,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appstyle(24, Colors.white, FontWeight.bold),
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
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: 16,
                    right: 12),
                child: TabBarView(controller: _tabController, children: [
                  latestShoes(male: proudctNotifier.male),
                  latestShoes(male: proudctNotifier.female),
                  latestShoes(male: proudctNotifier.kids),
                ]),
              )
            ],
          ),
        ));
    // ignore: dead_code
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(children: [
                    const CustomSpacer(),
                    Text(
                      "Fliter",
                      style: appstyle(34, Colors.black, FontWeight.w600),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Gender",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        CategoryBtn(
                          lable: "Men",
                          buttonClr: Colors.black,
                        ),
                        CategoryBtn(
                          lable: "Women",
                          buttonClr: Colors.grey,
                        ),
                        CategoryBtn(
                          lable: "Kids",
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appstyle(20, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        CategoryBtn(
                          lable: "Men",
                          buttonClr: Colors.black,
                        ),
                        CategoryBtn(
                          lable: "Women",
                          buttonClr: Colors.grey,
                        ),
                        CategoryBtn(
                          lable: "Kids",
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appstyle(20, Colors.black, FontWeight.w600),
                    ),
                    const CustomSpacer(),
                    Slider(
                      value: _value,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      max: 500,
                      divisions: 50,
                      label: _value.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (double value) {},
                    ),
                    const CustomSpacer(),
                    Text(
                      "Brand",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 70,
                      child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                    )
                  ]),
                )
              ]),
            ));
  }
}
