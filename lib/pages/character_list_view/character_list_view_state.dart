part of 'character_list_view_cubit.dart';

@immutable
abstract class CharacterListViewState {}

class CharacterListViewInitial extends CharacterListViewState {}
class CharacterListViewLoading extends CharacterListViewState {}
class CharacterListViewCharactersReturned extends CharacterListViewState {
  final List<Character> characters;
  CharacterListViewCharactersReturned(this.characters);
  List<Object> get props => [characters];
}
