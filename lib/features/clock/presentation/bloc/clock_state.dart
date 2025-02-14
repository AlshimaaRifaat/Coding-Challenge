import 'package:equatable/equatable.dart';

abstract class ClockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClockInitial extends ClockState {}

class ClockUpdated extends ClockState {
  final DateTime currentTime;

  ClockUpdated(this.currentTime);

  @override
  List<Object?> get props => [currentTime];
}
