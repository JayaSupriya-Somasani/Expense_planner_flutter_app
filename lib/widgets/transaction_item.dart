import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transactions;
  final Function deleteTransaction;

  TransactionItem({
    required Key key,
    required this.transactions,
    required this.deleteTransaction,
  }):super(key:key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.orange,
      Colors.purple,
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.accents
    ];
    _bgColor = availableColors[Random().nextInt(6)] as Color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: FittedBox(child: Text('\$${widget.transactions.amount}')),
        ),
        title: Text(
          widget.transactions.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transactions.dateTime),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 300
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                onPressed: () => widget.deleteTransaction(widget.transactions.id),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).errorColor)),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () =>
                    widget.deleteTransaction(widget.transactions.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
