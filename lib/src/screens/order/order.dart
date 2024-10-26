import 'package:flutter/material.dart';
import 'package:inovarescan/src/screens/order/components/order_custom_card.dart';
import 'package:inovarescan/src/screens/order/components/order_placeholder.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.tune_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CardOrderPlaceholder(),
            OrderCustomCard(
              tipoMov: 'Pré-Venda',
              numMov: '123456789012',
              statusMov: 'Separado',
              dateType: 'Operação',
              dtMov: DateTime.now(),
              codClient: 'C01234',
              nameClient: 'Nome do Cliente',
              razClient: 'Razão Sócial do Cliente',
              cpfCNPJClient: '12.345.678/0001-99',
              vendor: 'João Maria',
            ),
            OrderCustomCard(
              tipoMov: 'Pré-Venda',
              numMov: '123456789012',
              statusMov: 'Separado c/ Divergência',
              dateType: 'Emissão',
              dtMov: DateTime.now(),
              codClient: 'C01234',
              nameClient: 'Nome do Cliente',
              razClient: 'Razão Sócial do Cliente',
              cpfCNPJClient: '12.345.678/0001-99',
              vendor: 'João Maria',
            ),
            OrderCustomCard(
              tipoMov: 'Pré-Venda',
              numMov: '123456789012',
              statusMov: 'Finalizado',
              dateType: 'Emissão',
              dtMov: DateTime.now(),
              codClient: 'C01234',
              nameClient: 'Nome do Cliente',
              razClient: 'Razão Sócial do Cliente',
              cpfCNPJClient: '12.345.678/0001-99',
              vendor: 'João Maria',
            ),
            OrderCustomCard(
              tipoMov: 'Pré-Venda',
              numMov: '123456789012',
              statusMov: 'Em Separação',
              dateType: 'Operação',
              dtMov: DateTime.now(),
              codClient: 'C01234',
              nameClient: 'Nome do Cliente',
              razClient: 'Razão Sócial do Cliente',
              cpfCNPJClient: '12.345.678/0001-99',
              vendor: 'João Maria',
            ),
          ],
        ),
      ),
    );
  }
}
