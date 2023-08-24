import 'package:character_viewer/models/character.dart';
import 'package:flutter/material.dart';

class CustomListWidget extends StatelessWidget {
   List<Character>? characters;
   Function(Character) onPress;

  CustomListWidget({this.characters, required this.onPress});

  @override
  Widget build(BuildContext context) {
    List filteredList = characters ?? [];

    return ListView.builder(
        itemCount: characters?.length,
        itemBuilder: (BuildContext context, int index) {
          if (filteredList.length < 0) {
            return ListTile(
                title: Text('No Characters Returned...Yet')
            );
          } else {
            Character character = filteredList.elementAt(index);
            return GestureDetector(
                onTap: () {
                  if (character != null) {
                    onPress(character);
                  }
                },
                child: ListTile(
                  title: Text(character.name ?? 'Error'),
                ));
          }
        });
  }
}
