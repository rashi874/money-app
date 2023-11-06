import 'package:flutter/material.dart';
import 'package:money_manager_pro/core/colors/colors.dart';
import 'package:money_manager_pro/core/constant.dart';
import 'package:money_manager_pro/db/transactions/transaction_db.dart';
import 'package:money_manager_pro/models/transaction/transaction_model.dart';

class Total extends StatelessWidget {
  const Total({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TransactionDB.instance.refresh();
    // CategoryDB.instance.refreshUI();
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          totalIncome = 0.0;
          totalExpense = 0.0;
          for (TransactionModel data in newlist) {
            if (data.type.name == "income") {
              totalIncome += data.amount;
            } else {
              totalExpense += data.amount;
            }
          }
          return Column(
            children: <Widget>[
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Income & Expense.',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      cardIncome(
                        totalIncome.toString(),
                      ),
                      kHeight20,
                      cardExpense(
                        totalExpense.toString(),
                      ),
                      kHeight20,
                      Row(
                        children: [
                          const Text(
                            'Balance : ',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            '₹ ${totalIncome - totalExpense}',
                            style: const TextStyle(
                                fontSize: 20.0, fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Appcolors.kprimary,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Appcolors.kwhite,
          ),
          margin: const EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Income",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              ('₹ $value'),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20.0, fontFamily: 'Roboto'),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Appcolors.kprimary,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Appcolors.kwhite,
          ),
          margin: const EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expense",
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              ('₹ $value'),
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 20.0, fontFamily: 'Roboto'),
            ),
          ],
        ),
      ],
    );
  }
}
