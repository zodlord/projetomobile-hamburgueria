import 'package:hive/hive.dart';
import 'package:jacksonsburger/models/profit_item.dart';

class HiveDataBase {
  final _myBox = Hive.box("profit_database");

  void saveData(List<ProfitItem> allProfit) {

    List<List<dynamic>> allProfitsFormatted = [];

    for (var profit in allProfit) {
      List<dynamic> profitFormatted = [
        profit.name,
        profit.amount,
        profit.dateTime,
      ];
      allProfitsFormatted.add(profitFormatted);
    }
    
    _myBox.put("ALL_PROFITS", allProfitsFormatted);
  }

  List<ProfitItem> readData() {
    List savedProfits = _myBox.get("ALL_PROFITS") ?? [];
    List<ProfitItem> allProfits = [];

    for (int i = 0; i < savedProfits.length; i++) {
      String name = savedProfits[i][0];
      String amount = savedProfits[i][1];
      DateTime dateTime = savedProfits[i][2];
      
      ProfitItem profit = ProfitItem(
          name: name,
          amount: amount,
          dateTime: dateTime
      );

      allProfits.add(profit);
    }

    return allProfits;
  }
}