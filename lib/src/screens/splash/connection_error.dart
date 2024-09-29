import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/page_routes.dart';

class ConnectionErrorScreen extends StatelessWidget {
  const ConnectionErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color.fromRGBO(47, 79, 79, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ops...\nParece que você não conseguiu se conectar ao nosso servidor.\nPor favor Verifique sua conexão de rede e tente novamente.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(PageRoutes.initRoute);
                },
                child: Text('Tentar Novamente'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
