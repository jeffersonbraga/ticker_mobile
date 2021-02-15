import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final double opacity;
  final Function done;

  const NewTransaction(this.opacity, this.done);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        color: Colors.white.withOpacity(opacity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              readOnly: true,
              initialValue: 'App subscription',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Title',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12)
              ),
            )
          ],
        ),
      ),
    );
  }
}
