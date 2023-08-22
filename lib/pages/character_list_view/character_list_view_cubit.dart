import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:character_viewer/models/character.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'character_list_view_state.dart';

class CharacterListViewCubit extends Cubit<CharacterListViewState> {
  CharacterListViewCubit() : super(CharacterListViewInitial());

  void getCharacters() async {
    final response = await http
        .get(Uri.parse('http://api.duckduckgo.com/?q=simpsons+characters&format=json'));
    if (response.statusCode == 200) {
      final List<Character> characters = _parseCharacters(jsonDecode(response.body));
      emit(CharacterListViewCharactersReturned(characters));
    } else {
      //TODO: Error Handling
    }
  }

  List<Character> _parseCharacters(Map<String, dynamic> characterData) {
  List<Character> parsedCharacters = [];

  final List characters = characterData['RelatedTopics'];
  characters.forEach((element) {
    Character newCharacter = Character.fromJson(element);
    parsedCharacters.add(newCharacter);
  });


  return parsedCharacters;
  }
}
