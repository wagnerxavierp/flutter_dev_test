part of 'recovery_form_bloc.dart';

abstract class RecoveryFormEvent extends Equatable {
  const RecoveryFormEvent();

  @override
  List<Object> get props => [];
}

class PinChanged extends RecoveryFormEvent {
  final String pin;

  const PinChanged(this.pin);

  @override
  List<Object> get props => [pin];
}

class PinCompleted extends RecoveryFormEvent {
  final String pin;

  const PinCompleted(this.pin);

  @override
  List<Object> get props => [pin];
}

class FormReset extends RecoveryFormEvent {}
