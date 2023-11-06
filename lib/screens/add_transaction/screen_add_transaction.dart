import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_pro/core/colors/colors.dart';

import 'package:money_manager_pro/core/constant.dart';
import 'package:money_manager_pro/db/category/category_db.dart';
import 'package:money_manager_pro/db/transactions/transaction_db.dart';
import 'package:money_manager_pro/models/category/category_model.dart';
import 'package:money_manager_pro/models/transaction/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime selectedDate = DateTime.now();
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;
  final _puposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Add Transaction',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Fill The Details Below',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            kHeight,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                controller: _puposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: "Electricity Bill",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Appcolors.kprimary, width: 0.07),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Appcolors.kprimary, width: 0.07),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: "500",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Appcolors.kprimary, width: 0.07),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Appcolors.kprimary, width: 0.07),
                  ),
                ),
              ),
            ),
            //calender

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Appcolors.kprimary,
                  width: 0.09,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: TextButton.icon(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: const Icon(
                    Icons.date_range,
                  ),
                  label: Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]}",
                    style: const TextStyle(),
                  ),
                ),
              ),
            ),

            // category
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Appcolors.kprimary,
                      width: 0.09,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = CategoryType.income;
                              _categoryID = null;
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Income',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Appcolors.kprimary,
                      width: 0.09,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = CategoryType.expense;
                              _categoryID = null;
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Expense',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // category type
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Appcolors.kprimary,
                    width: 0.09,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    elevation: 0,
                    underline: const SizedBox(),
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select Category',
                      ),
                    ),
                    value: _categoryID,
                    items: (_selectedCategoryType == CategoryType.income
                            ? CategoryDB().incomeCategoryListListener
                            : CategoryDB().expenseCategoryListListener)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Appcolors.kprimary,
                              width: 0.09,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              e.name,
                              style: const TextStyle(),
                            ),
                          ),
                        ),
                        onTap: () {
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      if (kDebugMode) {
                        print(selectedValue);
                      }

                      setState(
                        () {
                          _categoryID = selectedValue;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            kHeight,
            //submit
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Submit',
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _puposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    //_selectedDate
    //_selectedCategoryType
    //_categoryID

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: selectedDate,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
