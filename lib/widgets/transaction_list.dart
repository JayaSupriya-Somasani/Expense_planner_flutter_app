import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
                  SizedBox(
                    height: 20,
                  ),
                  Container( height: constraints.maxHeight*0.6,
                      child: Image.asset('assets/images/bird.jpg'))
                ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                        child: Text('\$${_transactions[index].amount}')),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].dateTime),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTransaction(_transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
