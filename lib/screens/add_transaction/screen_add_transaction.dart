import 'package:flutter/material.dart';

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
  CategoryModel? _SelectedCategoryModel;

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

/*
purpose
Date
Amount
Income/Expense
CategoryType
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                // border: Border.all(
                //   color: Colors.grey,
                // ),
                border: Border.all(
                  color: Colors.blueGrey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),

                  //          <--- border radius here
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.close,
            //   ),
            // )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // purpuse

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        // border: Border.all(
                        //   color: Colors.blue.shade100,
                        // ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                          //          <--- border radius here
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 9,
                        ),
                        child: Text(
                          ' Fill The Details Below',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            // backgroundColor: Colors.blue[100]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kHeight,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: TextFormField(
                  // cursorColor: Colors.red,
                  controller: _puposeTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusColor: Colors.amber,
                    labelText: "Purpuse",
                    labelStyle: TextStyle(
                      color: Colors.green.shade300,
                    ),
                    // fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.green.shade100,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: TextFormField(
                  // cursorColor: Colors.white,
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(
                      color: Colors.green.shade300,
                    ),
                    focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.green.shade100,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              //calender

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    // border: Border.all(
                    //     // color: Colors.blue.shade100,
                    //     ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25.0),
                      //          <--- border radius here
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        _selectDate(context);
                        //
                        // to make sure that no keyboard is shown after selecting Date
                        // FocusScope.of(context).unfocus();
                        // async {
                        //   final _selectedDateTemp = await showDatePicker(
                        //     context: context,
                        //     initialDate: DateTime.now(),
                        //     firstDate:
                        //         DateTime.now().subtract(const Duration(days: 30)),
                        //     lastDate: DateTime.now(),
                        //   );

                        //   if (_selectedDateTemp == null) {
                        //     return;
                        //   } else {
                        //     print(_selectedDateTemp.toString());
                        //     String formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                        //         .format(_selectedDateTemp);
                        //     // print(DateFormat.yMMMd().format(_selectedDateTemp));
                        //     setState(() {
                        //       _selectedDate = formattedDate as DateTime?;
                        //     });
                        //     print(formattedDate.toString());
                        //   }
                      },
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      label: Text(
                        "${selectedDate.day} ${months[selectedDate.month - 1]}",
                        // _selectedDate == null
                        //     ? 'Select Date'
                        //     : _selectedDate!.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      // border: Border.all(
                      //     // color: Colors.blue.shade100,
                      //     ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                        //          <--- border radius here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.black,
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
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      // border: Border.all(
                      //     // color: Colors.blue.shade100,
                      //     ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                        //          <--- border radius here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.black,
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
                            child: Text('Expense',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // category type
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25.0),
                      //          <--- border radius here
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      elevation: 0,
                      dropdownColor: Colors.transparent,
                      underline: const SizedBox(),
                      focusColor: Colors.red,
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Select Category',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      value: _categoryID,
                      items: (_selectedCategoryType == CategoryType.income
                              ? CategoryDB().incomeCategoryListListener
                              : CategoryDB().expenseCategoryListListener)
                          .value
                          .map((e) {
                        return DropdownMenuItem(
                          // alignment: Alignment.center,
                          value: e.id,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                                //          <--- border radius here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                e.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            _SelectedCategoryModel = e;
                          },
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        print(selectedValue);

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
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    // if (selectedDate == null) {
    //   return;
    // }
    if (_SelectedCategoryModel == null) {
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
      category: _SelectedCategoryModel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
