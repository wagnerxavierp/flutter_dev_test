part of 'recovery_form_bloc.dart';

abstract class RecoveryFormState extends Equatable {
  const RecoveryFormState();

  @override
  List<Object> get props => [];
}

class RecoveryFormInitial extends RecoveryFormState {}

class RecoveryFormUpdated extends RecoveryFormState {
  final String pin;
  final bool isComplete;

  const RecoveryFormUpdated({
    required this.pin,
    required this.isComplete,
  });

  @override
  List<Object> get props => [pin, isComplete];
}
