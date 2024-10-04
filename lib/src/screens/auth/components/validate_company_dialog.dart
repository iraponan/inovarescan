import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:inovarescan/src/services/validators.dart';

class ValidateCompanyDialog extends StatefulWidget {
  const ValidateCompanyDialog({super.key});

  @override
  State<ValidateCompanyDialog> createState() => _ValidateCompanyDialogState();
}

class _ValidateCompanyDialogState extends State<ValidateCompanyDialog> {
  final cnpjController = TextEditingController();
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  child: Text(
                    'Qual empresa você pertence?',
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
                    'Digite o CNPJ de sua empresa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                CustomTextField(
                  formFieldKey: _formFieldKey,
                  controller: cnpjController,
                  labelText: 'CNPJ',
                  prefixIcon: Icons.perm_identity,
                  validator: Validators.cnpjValidator,
                  textInputFormatter: CnpjInputFormatter(),
                  textInputType: TextInputType.number,
                ),
                GetBuilder<CompanyController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formFieldKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        if (await controller.getCompanyFromCNPJ(cnpjController.text)) {
                          Get.back(result: true);
                        } else {
                          Utils.showToast(message: 'O CNPJ Informado não pertence a nossa base de dados.');
                        }
                      }
                    },
                    child: const Text(
                      'Verificar',
                      style: TextStyle(fontSize: 13),
                    ),
                  );
                }),
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
