import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/pages/character_list_view/character_list_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  List<Character> characters = [];

  @override
  void initState() {
    context.read<CharacterListViewCubit>().getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character List'),
      ),
      body: SafeArea(
          child: BlocConsumer<CharacterListViewCubit, CharacterListViewState>(
              listener: (context, state) {
                if (state is CharacterListViewCharactersReturned) {
                  setState(() {
                    characters = state.characters;
                  });
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (characters.length < 0) {
                        return ListTile(
                          title: Text('No Characters Returned...Yet')
                        );
                      } else {
                        String text = characters.elementAt(index).text ?? '';
                        List textSplit = text.split('-');
                        String name = textSplit[0];

                      return GestureDetector(
                          onTap: () {
                            // context.read<CharacterListViewCubit>().getLegislators(states.values.elementAt(index));
                          },
                          child: ListTile(
                            title: Text(name),
                          ));
                    }});
              })));
  }
}
