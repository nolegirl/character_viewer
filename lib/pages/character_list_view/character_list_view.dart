import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/pages/character_detail_view/character_detail_view.dart';
import 'package:character_viewer/pages/character_list_view/character_list_view_cubit.dart';
import 'package:character_viewer/widgets/error_dialog.dart';
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
  List<Character> filteredList = [];
  String searchField = '';

  @override
  void initState() {
    context.read<CharacterListViewCubit>().getCharacters();
    super.initState();
  }

  List<Character> _getFilteredList() {
    if (searchField.isEmpty) {
      return characters;
    } else {
      return characters
          .where((character) =>
          character.name!.toLowerCase().contains(
              searchField.toLowerCase()) || character.text!.toLowerCase().contains(searchField.toLowerCase())).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _getFilteredList();
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
                } else if (state is CharacterListViewError) {
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return ErrorMessageDialog(
                          title: 'Uh Oh',
                          message: 'Looks like we couldn\'t find character information. Please try again later.',
                        );
                      });
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only()),
                            onChanged: (text) {
                              setState(() {
                                searchField = text;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: filteredList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (filteredList.length < 0) {
                                  return ListTile(
                                      title: Text('No Characters Returned...Yet')
                                  );
                                } else {
                                  Character character = filteredList.elementAt(index);
                                  return GestureDetector(
                                      onTap: () {
                                        CharacterDetailView.routeTo(context, character);
                                      },
                                      child: ListTile(
                                        title: Text(character.name ?? 'Error'),
                                      ));
                                }}),
                        ),
                      ],
                    ),
                    Visibility(child: FullScreenLoadingWidget(),visible: state is CharacterListViewLoading,)
                ]);
              })));
  }
}
