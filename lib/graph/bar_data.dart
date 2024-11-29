import 'package:jacksonsburger/graph/individual_bar.dart';

class BarData {
  final double domAmount;
  final double segAmount;
  final double terAmount;
  final double quaAmount;
  final double quiAmount;
  final double sexAmount;
  final double sabAmount;

  BarData({
    required this.domAmount,
    required this.segAmount,
    required this.terAmount,
    required this.quaAmount,
    required this.quiAmount,
    required this.sexAmount,
    required this.sabAmount
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: domAmount),

      IndividualBar(x: 1, y: segAmount),

      IndividualBar(x: 2, y: terAmount),

      IndividualBar(x: 3, y: quaAmount),

      IndividualBar(x: 4, y: quiAmount),

      IndividualBar(x: 5, y: sexAmount),

      IndividualBar(x: 6, y: sabAmount),
    ];
  }
}