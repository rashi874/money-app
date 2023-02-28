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
            selectedItemColor: Colors.green.shade300,
            unselectedItemColor: Colors.grey[600],
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.cabin),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cable),
                label: 'Categories',
              ),
            ],
          );
        });
  }
}
