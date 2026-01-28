part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class LoadNextPage extends CharactersEvent {}

class RefreshCharacters extends CharactersEvent {}
