import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cannabis_tracker/models/consumption.dart';
import 'package:cannabis_tracker/services/database_service.dart';
import 'package:cannabis_tracker/models/statistics.dart';

class ConsumptionProvider with ChangeNotifier {
  final DatabaseService dbService;

  ConsumptionProvider(this.dbService);

  Stream<List<Consumption>> watchAllConsumptions() {
    return dbService.watchAllConsumptions().map((consumptions) => consumptions.map((map) => Consumption.fromMap(map)).toList());
  }

  Future<List<Consumption>> getConsumptions() async {
    final consumptions = await dbService.getConsumptions();
    return consumptions
        .map((map) => Consumption.fromMap(map))
        .toList()
        .reversed
        .toList(); // Tri des entrées par date décroissante
  }


  Future<void> addConsumption(Consumption consumption) async {
    await dbService.addConsumption(consumption.toMap());
    notifyListeners();
  }

  Future<void> updateConsumption(Consumption consumption) async {
    await dbService.updateConsumption(consumption.toMap());
    notifyListeners();
  }

  Future<void> deleteConsumption(int id) async {
    await dbService.deleteConsumption(id);
    notifyListeners();
  }

  Future<Statistics> getStatistics() async {
    final consumptions = await getConsumptions();
    final consumptionCount = consumptions.length;
    final totalWeight = consumptions.map((c) => c.weight!).reduce((a, b) => a + b);
    final averageAmount = totalWeight / consumptionCount;

    return Statistics(
      totalConsumptions: consumptionCount,
      totalWeight: totalWeight,
      averageAmount: averageAmount,
    );
  }
}
