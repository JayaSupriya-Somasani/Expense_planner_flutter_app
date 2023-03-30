import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
          return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const SizedBox(height: 10,),
             Text("No transactions added yet",style: Theme.of(context).textTheme.titleSmall,),
            const SizedBox(height: 20,),
            Container(
               height: constraints.maxHeight * 0.5,
               child: Image.asset('assets/images/bird.jpg'))
          ],
        );
        })
        : ListView(children: _transactions.map((tx) => TransactionItem(
            key:ValueKey(tx.id) ,transactions: tx,
            deleteTransaction: _deleteTransaction,)).toList()
          );
  }
}
