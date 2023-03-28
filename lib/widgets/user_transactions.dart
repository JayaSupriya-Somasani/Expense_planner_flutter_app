import 'package:expense_planner_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: "Food", amount: 250.45, dateTime: DateTime.now()),
    Transaction(
        id: 't2', title: "Groceries", amount: 190.34, dateTime: DateTime.now())
  ];

  void _addNewTransaction(String txTitile, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitile,
        amount: txAmount,
        dateTime: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
