import 'package:equatable/equatable.dart';

abstract class NumberEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNumber extends NumberEvent {}
