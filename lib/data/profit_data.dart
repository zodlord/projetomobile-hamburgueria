import 'package:flutter/foundation.dart';
import 'package:jacksonsburger/data/hive_database.dart';
import 'package:jacksonsburger/datetime/date_time_helper.dart';

import '../models/profit_item.dart';

class ProfitData extends ChangeNotifier{

  //list of ALL profits
  List<ProfitItem> overallProfitList = [];


  // get profit list
  List<ProfitItem> getAllProfitList() {
    return overallProfitList;
  }
  final db = HiveDataBase();
  void prepareData() {

    if (db.readData().isNotEmpty) {
      overallProfitList = db.readData();
    }
  }

  // add new profit
  void addNewProfit(ProfitItem newProfit) {
    overallProfitList.add(newProfit);

    notifyListeners();
    db.saveData(overallProfitList);
  }

  // delete profit
  void deleteProfit(ProfitItem profit) {
    overallProfitList.remove(profit);

    notifyListeners();
  }

  // get weekday (seg, ter, etc) from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Dom';
      case 2:
        return 'Seg';
      case 3:
        return 'Ter';
      case 4:
        return 'Qua';
      case 5:
        return 'Qui';
      case 6:
        return 'Sex';
      case 7:
        return 'Sab';
      default:
        return '';
    }
  }


  // get the date for the start of the week (domingo)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sab') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }
  /*

  convert overall list of profits into a daily profit summary

  e.g.

  overallProfitList =

  [
    {
      [food, 2023/01/30, $10],
      [food, 2023/01/30, $18],
      [food, 2023/01/30, $17],
      [food, 2023/02/30, $16],
      [food, 2023/01/30, $10],
      [food, 2023/05/25, $15],
      [food, 2023/01/30, $1],
      [food, 2023/01/30, $10],
    }
  ]
   */

  Map<String, double> calculateDailyProfitSummary() {
    Map<String, double> dailyProfitSummary = {
    };

    for (var profit in overallProfitList) {
      String date = convertDateTimeToString(profit.dateTime);
      double amount = double.parse(profit.amount);
      
      if (dailyProfitSummary.containsKey(date)) {
        double currentAmount = dailyProfitSummary[date]!;
        currentAmount += amount;
        dailyProfitSummary[date] = currentAmount;
      } else {
        dailyProfitSummary.addAll({date: amount});
      }
    }

    return dailyProfitSummary;
  }
}