import 'package:flutter/material.dart';
import 'package:flutter_app_01/data/deceased_data.dart';

class DeceasedCard extends StatefulWidget {
  const DeceasedCard({
    super.key,
    required this.deceased,
  });

  final DeceasedData deceased;

  @override
  State<DeceasedCard> createState() => _DeceasedCardState();

  toList() {}
}

class _DeceasedCardState extends State<DeceasedCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.deceased.dTitle} ${widget.deceased.dForenames} ${widget.deceased.dSurname}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.deceased.dCommitalDate,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.deceased.dCommitalLocation,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
