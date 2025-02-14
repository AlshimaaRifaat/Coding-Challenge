import 'package:equatable/equatable.dart';

abstract class NumberState extends Equatable {
  @override
  List<Object> get props => [];
}

class NumberInitial extends NumberState {}

class NumberLoading extends NumberState {}

class NumberError extends NumberState {
  final String message;
  NumberError(this.message);

  @override
  List<Object> get props => [message];
}

class PrimeFound extends NumberState {
  final int number;
  final Duration timeElapsed;

  PrimeFound({required this.number, required this.timeElapsed});

  @override
  List<Object> get props => [number, timeElapsed];
}

class NonPrimeNumber extends NumberState {
  final int number;

  NonPrimeNumber({required this.number});

  @override
  List<Object> get props => [number];
}
