import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/services/notification_service.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/recovery_form_bloc/recovery_form_bloc.dart';
import 'package:flutter_dev_test/features/auth/presentation/widgets/custom_pin_code_input.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dev_test/features/auth/presentation/widgets/custom_button.dart';

class RecoverySecretPage extends StatefulWidget {
  const RecoverySecretPage({super.key});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecoveryFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              // Exibir mensagem de erro usando serviço de notificação
              NotificationService.showSnackBar(
                context: context,
                message: state.message,
                type: NotificationType.warning,
              );
            } else if (state is AuthSecretRecoverySuccess) {
              NotificationService.showSnackBar(
                context: context,
                message: 'Verificação concluída. Por favor, faça o login!',
                type: NotificationType.success,
              );
              context.go('/login');
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verificação',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Insira o código que foi enviado:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 64.0),
                BlocBuilder<RecoveryFormBloc, RecoveryFormState>(
                  builder: (context, formState) {
                    String currentPin = '';

                    if (formState is RecoveryFormUpdated) {
                      currentPin = formState.pin;
                    }

                    return PinCodeInput(
                      length: 6,
                      initialValue: currentPin,
                      onChanged: (pin) => context.read<RecoveryFormBloc>().add(
                            PinChanged(pin),
                          ),
                      onCompleted: (pin) => context
                          .read<RecoveryFormBloc>()
                          .add(PinCompleted(pin)),
                    );
                  },
                ),
                const SizedBox(height: 32),
                BlocBuilder<RecoveryFormBloc, RecoveryFormState>(
                  builder: (context, formState) {
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        bool isButtonEnabled = false;
                        String recoveryCode = '';

                        if (formState is RecoveryFormUpdated) {
                          isButtonEnabled = formState.isComplete;
                          recoveryCode = formState.pin;
                        }

                        return CustomButton(
                          text: 'Confirmar',
                          isLoading: authState is AuthLoading,
                          onPressed: isButtonEnabled
                              ? () {
                                  context.read<AuthBloc>().add(
                                        RecoveryRequested(
                                          username: 'admin',
                                          password: 'password123',
                                          recoveryCode: recoveryCode,
                                        ),
                                      );
                                }
                              : null,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32.0),
                // TODO: Implementar lógica de reenvio de código
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/message-question.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Não recebi o código',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
