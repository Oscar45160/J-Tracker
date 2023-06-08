import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cannabis_tracker/models/consumption.dart';
import 'package:cannabis_tracker/providers/consumption_provider.dart';

class LastEntriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final consumptionProvider = Provider.of<ConsumptionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dernières entrées'),
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
                  subtitle: Text('Date: ${consumption.date.toString()}'),
                  trailing: Text('Poids: ${consumption.weight.toString()}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Une erreur s\'est produite');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
