import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_pro/core/constant.dart';
import 'package:money_manager_pro/db/category/category_db.dart';
import 'package:money_manager_pro/db/transactions/transaction_db.dart';
import 'package:money_manager_pro/models/category/category_model.dart';
import 'package:money_manager_pro/models/transaction/transaction_model.dart';
import 'package:money_manager_pro/screens/transactions/total.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          if (newlist.isEmpty) {
            return const Center(
              child: Text(
                'Transactions is empty',
                style: TextStyle(
                  // color: kwhiteColor,
                  fontSize: 16,
                ),
              ),
            );
          }
          return ListView(children: [
            const Total(),
            kHeight,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Text(
                'Transactions ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              //values
              itemBuilder: (ctx, index) {
                final _value = newlist[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) {
                          TransactionDB.instance.deleteTransaction(_value.id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        // color: Colors.grey[900],
                        elevation: 0,
                        child: ListTile(
                          trailing: Container(
                            // color: Colors.red,
                            // // margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[600],
                              // border: Border.all(
                              //   color: Colors.blueAccent,
                              // ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                                //          <--- border radius here
                              ),
                            ),
                            child: Text(
                              _value.purpose,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            child: Text(
                              parseDate(_value.date),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: _value.type == CategoryType.income
                                ? Colors.green[600]
                                : Colors.red[600],
                          ),
                          title: Text(
                            '₹ ${_value.amount}',
                          ),
                          subtitle: Text(_value.category.name),
                        ),
                      ),
                    ),
                  ),
                );
              },
              // separatorBuilder: (ctx, index) {
              //   return const SizedBox(
              //     height: 0,
              //   );
              // },

              itemCount: newlist.length,
            )
          ]);
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
  }
}
