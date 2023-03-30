import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transactions;
  final Function deleteTransaction;

   TransactionItem( {required this.transactions, required this.deleteTransaction,});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(child: Text('\$${transactions.amount}')),
        ),
        title: Text(
          transactions.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transactions.dateTime),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 300
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                onPressed: () => deleteTransaction(transactions.id),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).errorColor)),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTransaction(transactions.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
