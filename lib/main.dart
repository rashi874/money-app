import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
        primaryColor: Colors.white,
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        cardColor: Colors.green.shade100.withOpacity(0.5),
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green.shade200,
          ),
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,

        /* light theme settings */
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,

        // primarySwatch: Colors.blueGrey,
        cardColor: Colors.blueGrey.shade900.withOpacity(0.6),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          foregroundColor: Colors.white,
          shadowColor: Colors.white.withOpacity(0.0),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green.shade200,
          ),
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        canvasColor: Colors.black,

        /* dark theme settings */
      ),
      // themeMode: ThemeMode.dark,

      /* ThemeMode.system to follow system theme,
             ThemeMode.light for light theme,
             ThemeMode.dark for dark theme
          */
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction(),
      },
    );
  }
}
