import 'package:flutter/material.dart';
import 'package:jacksonsburger/data/profit_data.dart';
import 'package:jacksonsburger/datetime/date_time_helper.dart';
import 'package:jacksonsburger/graph/bar_graph.dart';
import 'package:provider/provider.dart';

class ProfitSummary extends StatelessWidget {

  final DateTime startOfWeek;
  const ProfitSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(
        ProfitData value,
        String domingo,
        String segunda,
        String terca,
        String quarta,
        String quinta,
        String sexta,
        String sabado
      ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyProfitSummary()[domingo] ?? 0,
      value.calculateDailyProfitSummary()[segunda] ?? 0,
      value.calculateDailyProfitSummary()[terca] ?? 0,
      value.calculateDailyProfitSummary()[quarta] ?? 0,
      value.calculateDailyProfitSummary()[quinta] ?? 0,
      value.calculateDailyProfitSummary()[sexta] ?? 0,
      value.calculateDailyProfitSummary()[sabado] ?? 0,
    ];

    values.sort();

    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
      ProfitData value,
      String domingo,
      String segunda,
      String terca,
      String quarta,
      String quinta,
      String sexta,
      String sabado
      ) {
    List<double> values = [
      value.calculateDailyProfitSummary()[domingo] ?? 0,
      value.calculateDailyProfitSummary()[segunda] ?? 0,
      value.calculateDailyProfitSummary()[terca] ?? 0,
      value.calculateDailyProfitSummary()[quarta] ?? 0,
      value.calculateDailyProfitSummary()[quinta] ?? 0,
      value.calculateDailyProfitSummary()[sexta] ?? 0,
      value.calculateDailyProfitSummary()[sabado] ?? 0,
    ];

    double total = 0;

    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {

    String domingo = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String segunda = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String terca = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String quarta = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String quinta = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String sexta = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sabado = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));


    return Consumer<ProfitData>(
      builder: (context, value, child) => Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                const Text('Total da semana: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\R' + '\$ ' + calculateWeekTotal(value, domingo, segunda, terca, quarta, quinta, sexta, sabado)),
              ],
            ),
          ),

          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, domingo, segunda, terca, quarta, quinta, sexta, sabado),
              domAmount: value.calculateDailyProfitSummary()[domingo] ?? 0,
              segAmount: value.calculateDailyProfitSummary()[segunda] ?? 0,
              terAmount: value.calculateDailyProfitSummary()[terca] ?? 0,
              quaAmount: value.calculateDailyProfitSummary()[quarta] ?? 0,
              quiAmount: value.calculateDailyProfitSummary()[quinta] ?? 0,
              sexAmount: value.calculateDailyProfitSummary()[sexta] ?? 0,
              sabAmount: value.calculateDailyProfitSummary()[sabado] ?? 0,
            ),
          )
        ],
      )
    );
  }
}
