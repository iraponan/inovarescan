import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/screens/auth/components/validate_email_dialog.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:inovarescan/src/services/search_cep.dart';
import 'package:inovarescan/src/services/validate_email.dart';
import 'package:inovarescan/src/services/validators.dart';
import 'package:search_cep/search_cep.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.userCronos});

  final String userCronos;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final addressController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  ViaCepInfo? viaCepInfo = ViaCepInfo();
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwathColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      Text(
                        'Cadastro de Usuário',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                // # Formulário #
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
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
                                  labelText: 'Usuário Cronos',
                                  prefixIcon: Icons.person_pin_outlined,
                                  initialValue: widget.userCronos,
                                  isReadOnly: true,
                                  onSaved: (value) {
                                    authController.user.userCronos = value;
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked!;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value;
                                          });
                                        },
                                        activeColor: CustomColors.customContrastColor2,
                                      ),
                                      Text('Informar endereço?'),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: isChecked ?? false,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        labelText: 'CEP',
                                        prefixIcon: Icons.signpost_outlined,
                                        textInputFormatter: CepInputFormatter(),
                                        textInputType: TextInputType.number,
                                        onChanged: (value) async {
                                          if (value?.length == 10) {
                                            viaCepInfo = await SearchCep.searchCep(value?.replaceAll('.', '').replaceAll('-', '') ?? '');
                                            addressController.text = viaCepInfo?.logradouro ?? '';
                                            neighbourhoodController.text = viaCepInfo?.bairro ?? '';
                                            cityController.text = viaCepInfo?.localidade ?? '';
                                            stateController.text = viaCepInfo?.uf ?? '';
                                          }
                                        },
                                        onSaved: (value) {
                                          authController.user.postCode = value;
                                        },
                                      ),
                                      CustomTextField(
                                        labelText: 'Endereço',
                                        controller: addressController,
                                        prefixIcon: Icons.pin_drop_outlined,
                                        textCapitalization: TextCapitalization.words,
                                        onSaved: (value) {
                                          authController.user.address = value;
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: CustomTextField(
                                              labelText: 'N°',
                                              prefixIcon: Icons.numbers_outlined,
                                              textInputType: TextInputType.number,
                                              onSaved: (value) {
                                                authController.user.number = value;
                                              },
                                            ),
                                          ),
                                          VerticalDivider(),
                                          Expanded(
                                            flex: 2,
                                            child: CustomTextField(
                                              labelText: 'Complemento',
                                              prefixIcon: Icons.pin_drop_outlined,
                                              textCapitalization: TextCapitalization.words,
                                              onSaved: (value) {
                                                authController.user.complement = value;
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      CustomTextField(
                                        labelText: 'Bairro',
                                        controller: neighbourhoodController,
                                        prefixIcon: Icons.home,
                                        textCapitalization: TextCapitalization.words,
                                        onSaved: (value) {
                                          authController.user.neighbourhood = value;
                                        },
                                      ),
                                      CustomTextField(
                                        labelText: 'Cidade',
                                        controller: cityController,
                                        prefixIcon: Icons.location_city,
                                        textCapitalization: TextCapitalization.words,
                                        onSaved: (value) {
                                          authController.user.city = value;
                                        },
                                      ),
                                      CustomTextField(
                                        labelText: 'Estado',
                                        controller: stateController,
                                        prefixIcon: Icons.map_outlined,
                                        textCapitalization: TextCapitalization.words,
                                        onSaved: (value) {
                                          authController.user.state = value;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: VariablesUtils.heightButton,
                                  child: ElevatedButton(
                                    onPressed: authController.isLoading.value
                                        ? null
                                        : () async {
                                            if (formKey.currentState!.validate()) {
                                              FocusScope.of(context).unfocus();
                                              formKey.currentState!.save();
                                              if (await authController.signUp()) {
                                                Get.offAllNamed(PageRoutes.signInRoute);
                                                final int codeValid = await ValidateEmail.sendEmailValidator(authController.user.email);
                                                if (codeValid != 0) {
                                                  if (context.mounted) {
                                                    final bool? result = await showDialog(
                                                      context: context,
                                                      builder: (context) => ValidateEmailDialog(codeValid: codeValid.toString()),
                                                    );
                                                    if (result ?? false) {
                                                      authController.user.emailVerified = true;
                                                      authController.updateEmailValidation(authController.user.email!, true);
                                                      Utils.showToast(
                                                          message: 'Aguarde o administrador da empresa aceitar seu usuário e depois tente fazer o login.', isInfo: true);
                                                    }
                                                  }
                                                } else {
                                                  Utils.showToast(message: 'Não foi possível o e-mail de verificação!\nPor favor tente novamente mais tarde.');
                                                }
                                              }
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
                      ),
                    ),
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
    );
  }
}
