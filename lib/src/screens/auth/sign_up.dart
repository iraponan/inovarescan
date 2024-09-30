import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:inovarescan/src/services/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwathColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  // # Formulário #
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Obx(() {
                        CompanyController companyController = Get.find<CompanyController>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              labelText: 'Empresa',
                              prefixIcon: Icons.contacts_outlined,
                              initialValue: companyController.company.name,
                              isReadOnly: true,
                              onSaved: (value) {
                                authController.user.company = companyController.company;
                              },
                            ),
                            CustomTextField(
                              labelText: 'E-mail',
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                              validator: Validators.emailValidator,
                              onSaved: (value) {
                                authController.user.email = value;
                              },
                            ),
                            CustomTextField(
                              labelText: 'Senha',
                              prefixIcon: Icons.lock,
                              isSecret: true,
                              validator: Validators.passwordValidator,
                              enableSuggestions: false,
                              onSaved: (value) {
                                authController.user.password = value;
                              },
                            ),
                            CustomTextField(
                              labelText: 'Nome Completo',
                              prefixIcon: Icons.person,
                              textCapitalization: TextCapitalization.words,
                              validator: Validators.nameValidator,
                              onSaved: (value) {
                                authController.user.fullName = value;
                              },
                            ),
                            CustomTextField(
                              labelText: 'CPF',
                              prefixIcon: Icons.person_pin,
                              textInputFormatter: CpfInputFormatter(),
                              textInputType: TextInputType.number,
                              validator: Validators.cpfValidator,
                              onSaved: (value) {
                                authController.user.cpf = value;
                              },
                            ),
                            CustomTextField(
                              labelText: 'Celular',
                              prefixIcon: Icons.phone,
                              textInputFormatter: TelefoneInputFormatter(),
                              textInputType: TextInputType.number,
                              validator: Validators.phoneValidator,
                              onSaved: (value) {
                                authController.user.phone = value;
                              },
                            ),
                            SizedBox(
                              height: VariablesUtils.heightButton,
                              child: ElevatedButton(
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Cadastrar Usuário',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
