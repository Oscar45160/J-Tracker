import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cannabis_tracker/providers/consumption_provider.dart';
import 'package:cannabis_tracker/models/consumption.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final consumptionProvider = Provider.of<ConsumptionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cannabis Tracker'),
      ),
      body: StreamBuilder<List<Consumption>>(
        stream: consumptionProvider.watchAllConsumptions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final consumptions = snapshot.data!;
            return ListView.builder(
              itemCount: consumptions.length,
              itemBuilder: (context, index) {
                final consumption = consumptions[index];
                return ListTile(
                  title: Text('Type: ${consumption.type}'),
                  subtitle: Text('Weight: ${consumption.weight ?? 'N/A'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      consumptionProvider.deleteConsumption(consumption.id!);
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading consumptions'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addConsumption');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
