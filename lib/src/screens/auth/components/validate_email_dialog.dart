import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';

class ValidateEmailDialog extends StatefulWidget {
  const ValidateEmailDialog({super.key, required this.codeValid});

  final String codeValid;

  @override
  State<ValidateEmailDialog> createState() => _ValidateEmailDialogState();
}

class _ValidateEmailDialogState extends State<ValidateEmailDialog> {
  final codeController = TextEditingController();
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Foi enviado um código de verificação para seu e-mail.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Digite o código no campo abaixo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                CustomTextField(
                  formFieldKey: _formFieldKey,
                  controller: codeController,
                  labelText: 'Código',
                  prefixIcon: Icons.perm_identity,
                  textInputType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formFieldKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      if (codeController.text == widget.codeValid) {
                        Get.back(result: true);
                      } else {
                        Utils.showToast(message: 'O código informado não é valido.', isError: true);
                        Utils.showToast(message: 'Por favor informe o código valido enviado para seu e-mail.');
                      }
                    }
                  },
                  child: const Text(
                    'Verificar',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
