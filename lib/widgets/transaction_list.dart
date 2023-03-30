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
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text("No transactions added yet"),
                const SizedBox(height: 20,),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/bird.jpg'))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(transactions: _transactions[index], deleteTransaction: _deleteTransaction,);
            },
            itemCount: _transactions.length,
          );
  }
}
