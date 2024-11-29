import 'package:flutter/material.dart';

class ProfitTile extends StatelessWidget {

  final String name;
  final String amount;
  final DateTime dateTime;
  final Function onDelete;

  const ProfitTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('\R' + '\$ ' + amount),
          IconButton(
            onPressed: () => onDelete(),
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
