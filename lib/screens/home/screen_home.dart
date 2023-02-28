import 'package:flutter/material.dart';
import 'package:money_manager_pro/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_pro/screens/categories/category_add_popup.dart';
import 'package:money_manager_pro/screens/categories/screen_category.dart';
import 'package:money_manager_pro/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_pro/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.money,
                  size: 35,
                  // color: Colors.greenAccent[100],
                ),
              ),
              Text(
                'Money Manager Pro',
                style: TextStyle(
                  // color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
        ),
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            // print('Add Transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
            // print('Add Category');

            showCategoryAddPopup(context);
          }
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
