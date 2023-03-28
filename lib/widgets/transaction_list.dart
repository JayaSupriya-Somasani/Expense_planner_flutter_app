import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  TransactionList(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: _userTransactions.isEmpty
            ? Column(
                children: [
                   Text("No transactions added yet"),
                  Image.asset('assets/images/bird.jpg')
                ],
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
                          '\$ ${_userTransactions[index].amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_userTransactions[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            DateFormat()
                                .format(_userTransactions[index].dateTime),
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ));
                },
                itemCount: _userTransactions.length,
              ));
  }
}
