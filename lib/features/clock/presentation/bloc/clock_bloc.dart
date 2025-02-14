import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'clock_event.dart';
import 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  Timer? _timer;

  ClockBloc() : super(ClockInitial()) {
    on<StartClock>((event, emit) {
      _timer?.cancel();
      emit(ClockUpdated(DateTime.now()));

      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        emit(ClockUpdated(DateTime.now()));
      });
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
