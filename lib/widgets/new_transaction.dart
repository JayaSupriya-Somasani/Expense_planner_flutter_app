import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx){
    print("Constructor new transaction state is called");
  }


  @override
  State<NewTransaction> createState() {
    print("Create state is called");
    return _NewTransactionState();
  }

}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState(){
    print("Constructor new transaction state is called");
  }

  @override void initState(){
    super.initState();
    print("Init state is called");
  }

  @override
  void didUpdateWidget(NewTransaction widget) {
    print("didUpdateWidget is called");
    super.didUpdateWidget(widget);
  }

  @override void dispose(){
    print("Dispose is called");
    super.dispose();
  }

  void submitData(String val) {
    if(_amountController.text.isEmpty){return;}
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(_titleController.text, double.parse(_amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding:  EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(label: Text('Title')),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('Amount')),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date choosen !"
                            : 'Selected Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline4?.color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AdaptiveTextButton("Choose Date",_presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    submitData("Transaction added");
                  },
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button?.color)),
                  child: Text('Add transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
