import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:xpense/models/debt_hive_model.dart';
import 'package:xpense/models/daily_expense_hive_model.dart';
import 'package:xpense/models/lent_hive_model.dart';
import 'package:xpense/models/models.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(DailyExpenseHiveModelAdapter());
  Hive.registerAdapter(DebtHiveModelAdapter());
  Hive.registerAdapter(LentHiveModelAdapter());

  await Hive.openBox<DailyExpenseHiveModel>('Daily Expense');
  await Hive.openBox<DebtHiveModel>('Debt');
  await Hive.openBox<LentHiveModel>('Lent');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _dReasonController = TextEditingController();
    TextEditingController _dMoneyController = TextEditingController();

    TextEditingController _bUserController = TextEditingController();
    TextEditingController _bMoneyController = TextEditingController();
    TextEditingController _bReasonController = TextEditingController();

    TextEditingController _lUserController = TextEditingController();
    TextEditingController _lMoneyController = TextEditingController();
    TextEditingController _lReasonController = TextEditingController();

    return MaterialApp(
      title: 'xpense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('xpense'),
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'Daily Expense',
                    ),
                    Tab(
                      text: 'Debt',
                    ),
                    Tab(
                      text: 'Lent',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  //Daily Expense Screen
                  ValueListenableBuilder<Box<DailyExpenseHiveModel>>(
                    valueListenable: Boxes.getDailyExpensesBox().listenable(),
                    builder: (context, box, _) {
                      final dailyExpenses =
                          box.values.toList().cast<DailyExpenseHiveModel>();

                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: dailyExpenses.map<Widget>(
                            (element) {
                              final date =
                                  DateFormat.yMMMd().format(element.dateTime);
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoAlertDialog(
                                        title: Text('Delete?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteDailyExpense(element);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  elevation: 10,
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    title: Text(
                                      element.reason,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(date),
                                    trailing: Text(
                                      '${element.amount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),

                  //Debt Screen
                  ValueListenableBuilder<Box<DebtHiveModel>>(
                    valueListenable: Boxes.getDebtBox().listenable(),
                    builder: (context, box, _) {
                      final borrowed =
                          box.values.toList().cast<DebtHiveModel>();

                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: borrowed.map<Widget>(
                            (element) {
                              final date =
                                  DateFormat.yMMMd().format(element.dateTime);
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoAlertDialog(
                                        title: Text('Delete?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteDebt(element);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  elevation: 10,
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    title: Text(
                                      element.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(date),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Reason: ' + element.reason,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                    trailing: Text(
                                      '${element.amount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),

                  //Lent Screen
                  ValueListenableBuilder<Box<LentHiveModel>>(
                    valueListenable: Boxes.getLentBox().listenable(),
                    builder: (context, box, _) {
                      final lent = box.values.toList().cast<LentHiveModel>();

                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: lent.map<Widget>(
                            (element) {
                              final date =
                                  DateFormat.yMMMd().format(element.dateTime);
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoAlertDialog(
                                        title: Text('Delete?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteLent(element);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  elevation: 10,
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    title: Text(
                                      element.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(date),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Reason: ' + element.reason,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                    trailing: Text(
                                      '${element.amount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  var index = DefaultTabController.of(context)!.index;
                  
                  if (index == 0) {
                    _addDailyExpense(
                      context,
                      _formKey,
                      _dReasonController,
                      _dMoneyController,
                    );
                  }

                  if (index == 1) {
                    _addDebt(
                      context,
                      _formKey,
                      _bUserController,
                      _bReasonController,
                      _bMoneyController,
                    );
                  }

                  if (index == 2) {
                    _addLent(
                      context,
                      _formKey,
                      _lUserController,
                      _lReasonController,
                      _lMoneyController,
                    );
                  }
                },
                child: Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Functions and Classes
_addDailyExpense(
  context,
  _formKey,
  _reasonController,
  _moneyController,
) {
  return showModalBottomSheet(
    elevation: 100,
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _reasonController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Reason For Expenditure',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _moneyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addDailyExpense(
                    DailyExpenseModel(
                      reason: _reasonController.text,
                      amount: double.parse(_moneyController.text),
                    ),
                  );
                  _reasonController.text = '';
                  _moneyController.text = '';
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
            SizedBox(height: 3),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      );
    },
  );
}

_addDebt(
  context,
  _formKey,
  _bUserController,
  _bReasonController,
  _bMoneyController,
) {
  showModalBottomSheet(
    elevation: 100,
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _bUserController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _bReasonController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _bMoneyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var name = _bUserController.text;
                  var reason = _bReasonController.text;
                  var amount = double.parse(_bMoneyController.text);

                  _bUserController.text = '';
                  _bReasonController.text = '';
                  _bMoneyController.text = '';

                  addDebt(
                    DebtModel(
                      name: name,
                      reason: reason,
                      amount: amount,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
            SizedBox(height: 3),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      );
    },
  );
}

_addLent(
  context,
  _formKey,
  _lUserController,
  _lReasonController,
  _lMoneyController,
) {
  showModalBottomSheet(
    elevation: 100,
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _lUserController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _lReasonController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: TextFormField(
                controller: _lMoneyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var name = _lUserController.text;
                  var reason = _lReasonController.text;
                  var amount = double.parse(_lMoneyController.text);

                  _lUserController.text = '';
                  _lReasonController.text = '';
                  _lMoneyController.text = '';

                  addLent(
                    LentModel(name: name, reason: reason, amount: amount),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
            SizedBox(height: 3),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      );
    },
  );
}

Future addDailyExpense(DailyExpenseModel dailyExpenseModel) async {
  final dailyExpenseHiveModel = DailyExpenseHiveModel()
    ..reason = dailyExpenseModel.reason
    ..amount = dailyExpenseModel.amount
    ..dateTime = DateTime.now();
  final box = Boxes.getDailyExpensesBox();
  box.add(dailyExpenseHiveModel);
}

Future deleteDailyExpense(DailyExpenseHiveModel dailyExpenseHiveModel) async {
  await dailyExpenseHiveModel.delete();
}

Future addDebt(DebtModel borrowedModel) async {
  final borrowed = DebtHiveModel()
    ..name = borrowedModel.name
    ..reason = borrowedModel.reason
    ..amount = borrowedModel.amount
    ..dateTime = DateTime.now();
  final box = Boxes.getDebtBox();
  box.add(borrowed);
}

Future deleteDebt(DebtHiveModel borrowedHiveModel) async {
  await borrowedHiveModel.delete();
}

Future addLent(LentModel lentModel) async {
  final lent = LentHiveModel()
    ..name = lentModel.name
    ..reason = lentModel.reason
    ..amount = lentModel.amount
    ..dateTime = DateTime.now();
  final box = Boxes.getLentBox();
  box.add(lent);
}

Future deleteLent(LentHiveModel lentHiveModel) async {
  await lentHiveModel.delete();
}

class Boxes {
  static Box<DailyExpenseHiveModel> getDailyExpensesBox() =>
      Hive.box('Daily Expense');
  static Box<DebtHiveModel> getDebtBox() => Hive.box('Debt');
  static Box<LentHiveModel> getLentBox() => Hive.box('Lent');
}
