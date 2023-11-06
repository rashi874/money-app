import 'package:flutter/material.dart';
import 'package:money_manager_pro/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            elevation: 0,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            iconSize: 20,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.web_stories),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wysiwyg_sharp),
                label: 'Categories',
              ),
            ],
          );
        });
  }
}
