import 'package:cannabis_tracker/models/consumption.dart';
import 'package:cannabis_tracker/providers/consumption_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddConsumptionScreen extends StatefulWidget {
  @override
  _AddConsumptionScreenState createState() => _AddConsumptionScreenState();
}

class _AddConsumptionScreenState extends State<AddConsumptionScreen> {
  String? type;
  DateTime? date;
  double? weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Consumption'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: type,
              hint: Text('Select Type'),
              items: ['flower', 'hash', 'extract'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  type = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Pick Date'),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  setState(() {
                    date = selectedDate;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Weight (optional)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (type != null && date != null) {
                  final consumption = Consumption(
                    type: type,
                    date: date,
                    weight: weight,
                  );
                  Provider.of<ConsumptionProvider>(context, listen: false)
                      .addConsumption(consumption);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
