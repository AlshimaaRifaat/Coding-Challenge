import 'package:equatable/equatable.dart';

abstract class ClockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartClock extends ClockEvent {}
