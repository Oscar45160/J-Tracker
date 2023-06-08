import 'package:flutter/material.dart';
import 'package:cannabis_tracker/models/statistics.dart'; // Importation de la classe Statistics

class StatisticProvider extends ChangeNotifier {
  List<Statistics> _statistics = []; // Utilisation de la classe Statistics

  List<Statistics> get statistics => _statistics; // Utilisation de la classe Statistics

  void updateStatistics(List<Statistics> newStatistics) {
    _statistics = newStatistics;
    notifyListeners();
  }
}
