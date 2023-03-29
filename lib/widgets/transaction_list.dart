import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: _transactions.isEmpty
            ? Container(
                height: 200,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("No transactions added yet"),
                    SizedBox(height: 20,),
                    Image.asset('assets/images/bird.jpg')
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                    ),
                  );
                },
                itemCount: _transactions.length,
              ));
  }
}
