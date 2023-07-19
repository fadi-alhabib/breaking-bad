part of 'charachters_cubit.dart';

abstract class CharachtersState {}

class CharachtersInitial extends CharachtersState {}

class CharachtersLoaded extends CharachtersState {
  final List<Charachter> charachters;

  CharachtersLoaded({required this.charachters});
}
