import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentTotal);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(height: 20,
          child: FittedBox(child: Text('\$ ${spendingAmount.toStringAsFixed(0)}')),),
        SizedBox(height: 4),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 3),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20))),
              FractionallySizedBox(
                heightFactor: spendingPercentTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label),
        SizedBox(height: 20)
      ],
    );
  }
}
