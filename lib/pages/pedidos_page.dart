import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jacksonsburger/services/firestore.dart';
import '../components/bottom_navigation_bar.dart';

class PedidosPage extends StatefulWidget {
  static const String id = 'pedidos_page';
  static const String routeName = 'pedidos_page';

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  double totalValor = 0.0;
  double totalCommission = 0.0;

  void openPedidoBox({String? docID}) {
    double valor = 0.0;

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Pedido'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Pedido",
                  ),
                  controller: textController,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Valor",
                  ),
                  onChanged: (value) {
                    valor = double.parse(value);
                  },
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (docID == null) {
                    double commission = firestoreService.calculateCommission(
                        valor);

                    firestoreService.addPedido(textController.text, valor);
                  } else {
                    double commission = firestoreService.calculateCommission(
                        valor);

                    firestoreService.updatePedido(
                        docID, textController.text, valor);
                  }

                  textController.clear();
                  Navigator.of(context).pop();
                },
                child: Text("Adicionar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: openPedidoBox,
        child: const Icon(Icons.add),
        backgroundColor: Colors.red[700],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPedidosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List pedidosList = snapshot.data!.docs;

            double totalValor = 0.0;
            double totalCommission = 0.0;

            pedidosList.forEach((document) {
              Map<String, dynamic> data = document.data() as Map<String,
                  dynamic>;
              double pedidoValor = data['valor'];
              double pedidoCommission = data['commission'];

              totalValor += pedidoValor;
              totalCommission += pedidoCommission;
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'T O T A L - $totalValor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'C O M I S S Ã O - $totalCommission',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),

                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: pedidosList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = pedidosList[index];
                      String docID = document.id;

                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      String pedidoText = data['pedido'];
                      double pedidoValor = data['valor'];
                      double pedidoCommission = data['commission'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                        child: ListTile(
                          title: Text(pedidoText),
                          subtitle: Text(
                              'Valor: $pedidoValor\nComissão(5%): $pedidoCommission'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => openPedidoBox(docID: docID),
                                icon: const Icon(Icons.settings),
                                color: Colors.black,
                              ),
                              IconButton(
                                onPressed: () =>
                                    firestoreService.deletePedido(docID),
                                icon: const Icon(Icons.delete),
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Text("Nenhum pedido...");
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
}

