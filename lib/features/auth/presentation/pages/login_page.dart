import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/services/notification_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dev_test/features/auth/presentation/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSecretMissing || state is AuthTotpInvalid) {
            context.push('/recover-secret');
          } else if (state is AuthFailure) {
            // Exibir mensagem de erro usando serviço de notificação
            NotificationService.showSnackBar(
              context: context,
              message: state.message,
              type: NotificationType.warning,
            );
          } else if (state is AuthSuccess) {
            context.go('/home');
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/brand-login-logo.png',
                                height: 222,
                                width: 222,
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, insira seu e-mail';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24.0),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return CustomButton(
                                  text: 'Entrar',
                                  isLoading: state is AuthLoading,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            LoginRequested(
                                              username: _usernameController.text
                                                  .trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                            ),
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Spacer(),
                        // TODO: Implementar funcionalidade de recuperação de senha
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueci a senha',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
