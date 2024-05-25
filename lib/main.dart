import 'package:flutter_application_1/controllers/cart_provider.dart';
import 'package:flutter_application_1/controllers/favoritesProvider.dart';
import 'package:flutter_application_1/controllers/mainscreen_provider.dart';
import 'package:flutter_application_1/controllers/proudct_provide.dart';
import 'package:flutter_application_1/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationSupportDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox("cart_box");
  await Hive.openBox('fav_box');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProudctNotifier()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
         title: 'Shoes ',
         theme: ThemeData(
         primarySwatch: Colors.blue,
      ),

        home:LoginPage (),
    );
      },
    );
  }
}