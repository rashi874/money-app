import 'package:flutter/material.dart';
import 'package:money_manager_pro/core/constant.dart';
import 'package:money_manager_pro/db/transactions/transaction_db.dart';
import 'package:money_manager_pro/models/transaction/transaction_model.dart';

class Total extends StatelessWidget {
  const Total({Key? key}) : super(key: key);

  /// no
  ///
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
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              // color: Colors.blueAccent[300],
              elevation: 0,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      focusColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // tileColor: Colors.black,
                      // trailing: Container(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Icon(
                      //       Icons.safety_divider,
                      //       // size: 55,
                      //       color: Colors.blueGrey[500],
                      //     ),
                      //   ),
                      // ),
                      // trailing: Text('Analytics'),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Total ',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Income & Expense.',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                // kHeight,
                              ],
                            ),
                            Icon(
                              Icons.safety_divider,
                              size: 30,
                              color: Colors.blueGrey[500],
                            ),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardIncome(
                              totalIncome.toString(),
                            ),
                            kHeight20,
                            cardExpense(
                              totalExpense.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //     vertical: 20,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       cardIncome(
                  //         totalIncome.toString(),
                  //       ),
                  //       // kHeight20,
                  //       cardExpense(
                  //         totalExpense.toString(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
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
            color: Colors.green[700],
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
                color: Colors.green,
              ),
            ),
            Text(
              ('₹ $value'),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
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
            color: Colors.white60,
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
            color: Colors.red[700],
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
                color: Colors.red,
              ),
            ),
            Text(
              ('₹ $value'),
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

// class RandomColorModel {
//   Random random = Random();
//   Color getColor() {
//     return Color.fromARGB(random.nextInt(300), random.nextInt(300),
//         random.nextInt(300), random.nextInt(300));
//   }
// }
}
