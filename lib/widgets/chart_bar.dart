import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$ ${spendingAmount.toStringAsFixed(0)}')),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.6,
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
              height: constraint.maxHeight * 0.05,
            ),
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.caption?.color,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ],
        );
      },
    );
  }
}
