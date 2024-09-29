import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/screens/auth/components/forgot_password_dialog.dart';
import 'package:inovarescan/src/screens/common_widgets/app_name.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:inovarescan/src/services/validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppName(),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Balanço'),
                            FadeAnimatedText('Separação'),
                            FadeAnimatedText('Conferência'),
                            FadeAnimatedText('Gestão'),
                            FadeAnimatedText('Praticidade'),
                            FadeAnimatedText('Estoque'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // # E-mail #
                      CustomTextField(
                        controller: emailController,
                        labelText: 'E-mail',
                        prefixIcon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        validator: Validators.emailValidator,
                      ),
                      // # Senha #
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Senha',
                        prefixIcon: Icons.lock,
                        isSecret: true,
                        validator: Validators.passwordValidator,
                      ),
                      // # Botão de Entrar #
                      SizedBox(
                        height: VariablesUtils.heightButton,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password = passwordController.text;
                                        authController.signIn(email: email, password: password);
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      // # Esqueceu a Senha #
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (context) => ForgotPasswordDialog(
                                email: emailController.text,
                              ),
                            );
                            if (result ?? false) {
                              Utils.showToast(message: 'Verifique Seu E-mail!');
                            }
                          },
                          child: Text(
                            'Esqueceu a Senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),
                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // # Criar Conta #
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed(PageRoutes.signUpRoute),
                          child: Text(
                            'Criar Conta',
                            style: TextStyle(
                              color: CustomColors.customContrastColor2,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
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