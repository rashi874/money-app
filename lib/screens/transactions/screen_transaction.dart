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
              itemBuilder: (ctx, index) {
                final _value = newlist[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.transparent,
                        onPressed: (ctx) {
                          TransactionDB.instance.deleteTransaction(_value.id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: ListTile(
                    trailing: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text(
                          _value.purpose,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 22,
                      child: Text(
                        parseDate(_value.date),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            height: 1),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.green[600]
                          : Colors.red[600],
                    ),
                    title: Text(
                      '₹ ${_value.amount}',
                      style: const TextStyle(fontFamily: 'Roboto'),
                    ),
                    subtitle: Text(_value.category.name),
                  ),
                );
              },
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
