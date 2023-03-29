import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData(String val) {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(label: Text('Title')),
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Amount')),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("No Date choosen !"),
                  TextButton(
                      onPressed: () {},
                      // style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                      style: ButtonStyle(
                             foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                      child: const Text( "Choose Date", style: TextStyle(fontWeight: FontWeight.bold),)
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  submitData("Transaction added");
                },
                style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).textTheme.button?.color)),
                child: Text('Add transaction')
                )
          ],
        ),
      ),
    );
  }
}
