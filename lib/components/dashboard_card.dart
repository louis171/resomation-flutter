import 'package:flutter/material.dart';
import 'package:flutter_app_01/data/deceased_data.dart';
import 'package:intl/intl.dart';
import 'package:beamer/beamer.dart';

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
    return Column(children: <Widget>[
      Card(
          elevation: 5,
          child: InkWell(
            onTap: () =>
                context.beamToNamed('/dashboard/${widget.deceased.dId}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.deceased.dTitle} ${widget.deceased.dForenames} ${widget.deceased.dSurname}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('EEE dd MMM y - kk:mm aaa').format(
                              DateTime.tryParse(
                                  widget.deceased.dCommitalDate)!),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.deceased.dCommitalLocation,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}
