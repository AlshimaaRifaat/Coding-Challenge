import 'dart:async';

import 'package:challenge/core/services/local_storage_services.dart';
import 'package:challenge/core/utils/prime_checker.dart';
import 'package:challenge/features/number/domain/usecases/get_random_number.dart';
import 'package:challenge/features/number/presentation/bloc/number_event.dart';
import 'package:challenge/features/number/presentation/bloc/number_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  final GetRandomNumber getRandomNumber;
  final LocalStorageService localStorage;
  Timer? _timer;

  NumberBloc({required this.getRandomNumber, required this.localStorage})
      : super(NumberInitial()) {
    on<LoadNumber>(_onLoadNumber);
    _startTimer(); //  Starts timer only once
  }

  Future<void> _onLoadNumber(
      LoadNumber event, Emitter<NumberState> emit) async {
    emit(NumberLoading());

    final result = await getRandomNumber();

    await result.fold(
      (failure) async {
        if (!emit.isDone) emit(NumberError("Failed to load number"));
      },
      (number) async {
        print("Received number: $number");

        if (PrimeChecker.isPrime(number)) {
          print("Is $number prime? ${PrimeChecker.isPrime(number)}");

          final lastTime =
              await localStorage.getLastPrimeTime() ?? DateTime.now();

          final elapsed = DateTime.now().difference(lastTime);

          await localStorage.saveLastPrimeTime(DateTime.now());

          if (!emit.isDone) {
            _timer?.cancel();
            emit(PrimeFound(number: number, timeElapsed: elapsed));
          }
        } else {
          if (!emit.isDone) emit(NonPrimeNumber(number: number));
        }
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      add(LoadNumber());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
