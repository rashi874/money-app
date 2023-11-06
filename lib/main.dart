import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_pro/core/colors/colors.dart';
import 'package:money_manager_pro/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_pro/screens/home/screen_home.dart';

import 'models/category/category_model.dart';
import 'models/transaction/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager Pro',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Appcolors.kwhite,
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Product Sans',
        cardTheme: CardTheme(
          color: Appcolors.kprimary,
        ),
        cardColor: Appcolors.kprimary,
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: Appcolors.kwhite,
                statusBarColor: Appcolors.kwhite,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Appcolors.kprimary,
            foregroundColor: Appcolors.kwhite),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.kprimary,
              foregroundColor: Appcolors.kwhite),
        ),

        /* light theme settings */
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        fontFamily: 'Product Sans',
        useMaterial3: true,
        cardColor: Colors.blueGrey.shade900.withOpacity(0.6),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Color.fromARGB(255, 27, 27, 27),
              statusBarColor: Color.fromARGB(255, 27, 27, 27),
              statusBarIconBrightness: Brightness.light),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction(),
      },
    );
  }
}
