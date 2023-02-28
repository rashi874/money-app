import 'package:flutter/material.dart';
import 'package:money_manager_pro/db/category/category_db.dart';
import 'package:money_manager_pro/models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          if (newlist.isEmpty) {
            return const Center(
              child: Text(
                'Add Expense Categories',
                style: TextStyle(
                  // color: kwhiteColor,
                  fontSize: 16,
                ),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final Category = newlist[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(Category.name),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDB.instance.deleteCategory(Category.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
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
