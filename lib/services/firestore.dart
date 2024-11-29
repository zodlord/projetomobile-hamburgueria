import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference pedidos =
      FirebaseFirestore.instance.collection('pedidos');

  Future<void> addPedido(String pedido, double valor) {
    double commission = calculateCommission(valor);
    return pedidos.add({
      'pedido': pedido,
      'valor': valor,
      'commission': commission,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPedidosStream() {
    final pedidosStream = pedidos.orderBy('timestamp', descending: true).snapshots();

    return pedidosStream;
  }

  Future<void> updatePedido(String docID, String newPedido, double newValor) {
    double commission = calculateCommission(newValor);
    return pedidos.doc(docID).update({
      'pedido': newPedido,
      'valor': newValor,
      'commission': commission,
      'timestamp': Timestamp.now(),
    });
  }

  double calculateCommission(double valor) {
    // Calculate 5% commission
    double commissionPercentage = 0.05;
    double commission = valor * commissionPercentage;
    return commission;
  }

  Future<void> deletePedido(String docID) {
    return pedidos.doc(docID).delete();
  }

}