import 'package:flutter/cupertino.dart';
import 'package:expense_planner_flutter_app/widgets/chart.dart';
import 'package:expense_planner_flutter_app/widgets/transaction_list.dart';
import '/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          primaryColor: Colors.green,
          textTheme: ThemeData.light().textTheme.copyWith(
              button: const TextStyle(color: Colors.white),
              caption: TextStyle(color: Colors.purple),
              headline4: TextStyle(color: Colors.purple))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(
      String txTitile, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitile,
        amount: txAmount,
        dateTime: choosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar =
        (Theme.of(context).platform == TargetPlatform.iOS
            ? CupertinoNavigationBar(
                middle: Text("Expense Planner"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      child: Icon(CupertinoIcons.add),
                      onTap: () => _startAddNewTransaction(context),
                    )
                  ],
                ),
              )
            : AppBar(
                title: const Text("Expense Planner"),
                actions: [
                  IconButton(
                      onPressed: () => _startAddNewTransaction(context),
                      icon: Icon(Icons.add))
                ],
              )) as PreferredSizeWidget;
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final pagebody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Switch",style: Theme.of(context).textTheme.titleSmall,),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLandScape)
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
          if (!isLandScape) txListWidget,
          if (isLandScape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : txListWidget
        ],
      ),
    ));
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pagebody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () => _startAddNewTransaction(context),
                        child: const Icon(Icons.add),
                      ),
          );
  }
}
