import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/user_cronos.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:inovarescan/src/services/validators.dart';

class ValidateUserDialog extends StatefulWidget {
  const ValidateUserDialog({super.key});

  @override
  State<ValidateUserDialog> createState() => _ValidateCompanyDialogState();
}

class _ValidateCompanyDialogState extends State<ValidateUserDialog> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    'Agora qual é seu usuário na empresa informada?',
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
                    'Digite o seu usuário e senha do Cronos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextField(
                          controller: usernameController,
                          labelText: 'Usuário',
                          prefixIcon: Icons.perm_identity,
                          validator: Validators.usernameValidator,
                          textInputType: TextInputType.text,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          labelText: 'Senha',
                          prefixIcon: Icons.password,
                          validator: Validators.passwordValidator,
                          isSecret: true,
                          enableSuggestions: false,
                        ),
                      ],
                    )),
                GetBuilder<UserCronosController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        if (await controller.validateUser(usernameController.text, passwordController.text)) {
                          Get.back(result: true);
                        } else {
                          Utils.showToast(message: 'O usuário e senha informado esta errado ou não pertence a empresa informada.', isError: true);
                        }
                      }
                    },
                    child: const Text(
                      'Validar Usuário',
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
