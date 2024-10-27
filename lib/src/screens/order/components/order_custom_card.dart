import 'package:flutter/material.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:intl/intl.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class OrderCustomCard extends StatelessWidget {
  const OrderCustomCard({
    super.key,
    required this.tipoMov,
    required this.numMov,
    required this.statusSepMov,
    required this.dateType,
    required this.dtMov,
    required this.codClient,
    required this.nameClient,
    required this.razClient,
    required this.cpfCNPJClient,
    required this.vendor,
  });

  final String tipoMov;
  final String numMov;
  final String statusSepMov;
  final String dateType;
  final DateTime dtMov;
  final String codClient;
  final String nameClient;
  final String razClient;
  final String cpfCNPJClient;
  final String vendor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
      width: size.width,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$tipoMov - $numMov',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: Text(
                  statusSepMov,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$codClient - $nameClient',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Data de ${VariablesUtils.dateOptions.firstWhere((t) => t == dateType)}: ${DateFormat('dd/MM/yyyy HH:mm').format(dtMov)}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          razClient,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'CPF/CNPJ: $cpfCNPJClient',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Vendedor: $vendor',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  RiveAnimatedIcon(
                    riveIcon: getRiveIcon(statusSepMov),
                    width: 50,
                    height: 50,
                    color: getStatusColor(statusSepMov),
                    strokeWidth: 3,
                    loopAnimation: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  RiveIcon getRiveIcon(String status) {
    switch (status) {
      case 'Separado':
        return RiveIcon.check;
      case 'Separado c/ Divergência':
        return RiveIcon.warning;
      case 'Finalizado':
        return RiveIcon.bin;
      case 'Em Separação':
        return RiveIcon.timer2;
      default:
        return RiveIcon.edit;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Separado':
        return Colors.green;
      case 'Separado c/ Divergência':
        return Colors.red;
      case 'Finalizado':
        return Colors.blue;
      case 'Em Separação':
        return Colors.orange;
      default:
        return Colors.deepOrange;
    }
  }
}
