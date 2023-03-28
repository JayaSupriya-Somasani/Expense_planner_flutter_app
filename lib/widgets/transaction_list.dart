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
                      child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.purple)),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_transactions[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            DateFormat()
                                .format(_transactions[index].dateTime),
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ));
                },
                itemCount: _transactions.length,
              ));
  }
}
