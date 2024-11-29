import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/bottom_navigation_bar.dart';
import 'package:jacksonsburger/components/profit_summary.dart';
import 'package:jacksonsburger/components/profit_tile.dart';
import 'package:jacksonsburger/models/profit_item.dart';
import 'package:provider/provider.dart';


import '../data/profit_data.dart';

class LucroPage extends StatefulWidget {
  static const String id = 'lucro_page';
  static const String routeName = 'lucro_page';

  const LucroPage({super.key});

  @override
  State<LucroPage> createState() => _LucroPageState();
}

class _LucroPageState extends State<LucroPage> {
  final newProfitNameController = TextEditingController();
  final newProfitRealController = TextEditingController();
  final newProfitCentsController = TextEditingController();


  void deleteProfit(ProfitItem profit) {
    Provider.of<ProfitData>(context, listen: false).deleteProfit(profit);
  }

  @override
  void initState() {
    super.initState();

    Provider.of<ProfitData>(context, listen: false).prepareData();
  }

  void addNewProfit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar venda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newProfitNameController,
              decoration: const InputDecoration(
                hintText: "Venda",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newProfitRealController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Reais",
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: newProfitCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Centavos",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Salvar'),

          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void save() {

    String amount = '${newProfitRealController.text}.${newProfitCentsController.text}';

    ProfitItem newProfit = ProfitItem(
      name: newProfitNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );

    Provider.of<ProfitData>(context, listen: false).addNewProfit(newProfit);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newProfitNameController.clear();
    newProfitRealController.clear();
    newProfitCentsController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<ProfitData>(builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewProfit,
          child: const Icon(Icons.add),
          backgroundColor: Colors.red[700],
        ),
        body: ListView(
          children: [
            ProfitSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllProfitList().length,
              itemBuilder: (context, index) => ProfitTile(
                name: value.getAllProfitList()[index].name,
                amount: value.getAllProfitList()[index].amount,
                dateTime: value.getAllProfitList()[index].dateTime,
                onDelete: () {
                  deleteProfit(value.getAllProfitList()[index]);
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBarClass(),
      ),
    );
  }
}
