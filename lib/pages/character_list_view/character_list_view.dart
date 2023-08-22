import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/pages/character_detail_view/character_detail_view.dart';
import 'package:character_viewer/pages/character_list_view/character_list_view_cubit.dart';
import 'package:character_viewer/widgets/full_screen_loading_widget.dart';
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
        actions: [
          IconButton(onPressed: () {
            context.read<CharacterListViewCubit>().getCharacters();
    }, icon: Icon(Icons.refresh))
        ],
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
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (characters.length < 0) {
                          return ListTile(
                            title: Text('No Characters Returned...Yet')
                          );
                        } else {
                          Character character = characters.elementAt(index);
                        return GestureDetector(
                            onTap: () {
                              CharacterDetailView.routeTo(context, character);
                            },
                            child: ListTile(
                              title: Text(character.name ?? 'Error'),
                            ));
                      }}),
                    Visibility(child: FullScreenLoadingWidget(),visible: state is CharacterListViewLoading,)
                ]);
              })));
  }
}
