import 'package:flutter/material.dart';
import 'package:money_manager_pro/db/category/category_db.dart';
import 'package:money_manager_pro/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          if (newlist.isEmpty) {
            return const Center(
              child: Text(
                'Add Income Categories',
                style: TextStyle(
                  // color: kwhiteColor,
                  fontSize: 16,
                ),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newlist[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Center(
                    child: Text(category.name[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Roboto')),
                  ),
                ),
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDB.instance.deleteCategory(category.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 0);
            },
            itemCount: newlist.length,
          );
        });
  }
}
