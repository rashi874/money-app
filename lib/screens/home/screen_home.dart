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
        title: const Text(
          'CashFlow',
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
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
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
