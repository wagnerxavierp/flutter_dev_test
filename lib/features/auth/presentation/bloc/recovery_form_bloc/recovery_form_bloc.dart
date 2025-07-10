import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'recovery_form_event.dart';
part 'recovery_form_state.dart';

class RecoveryFormBloc extends Bloc<RecoveryFormEvent, RecoveryFormState> {
  RecoveryFormBloc() : super(RecoveryFormInitial()) {
    on<PinChanged>(_onPinChanged);
    on<PinCompleted>(_onPinCompleted);
    on<FormReset>(_onFormReset);
  }

  void _onPinChanged(
    PinChanged event,
    Emitter<RecoveryFormState> emit,
  ) {
    emit(RecoveryFormUpdated(
      pin: event.pin,
      isComplete: event.pin.length == 6,
    ));
  }

  void _onPinCompleted(
    PinCompleted event,
    Emitter<RecoveryFormState> emit,
  ) {
    emit(RecoveryFormUpdated(
      pin: event.pin,
      isComplete: true,
    ));
  }

  void _onFormReset(
    FormReset event,
    Emitter<RecoveryFormState> emit,
  ) {
    emit(RecoveryFormInitial());
  }
}
