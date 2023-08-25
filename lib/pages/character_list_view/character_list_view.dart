import 'package:character_viewer/models/character.dart';
import 'package:character_viewer/pages/character_detail_view/character_detail_view.dart';
import 'package:character_viewer/pages/character_list_view/character_list_view_cubit.dart';
import 'package:character_viewer/widgets/custom_list_widget.dart';
import 'package:character_viewer/widgets/error_dialog.dart';
import 'package:character_viewer/widgets/full_screen_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  List<Character> characters = [];
  List<Character> filteredList = [];
  String searchField = '';
  Character? selectedCharacter;

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
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    DeviceType deviceType = SizerUtil.deviceType;

    if (currentOrientation == Orientation.landscape && deviceType == DeviceType.tablet) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Character List'),
            actions: [
              IconButton(onPressed: () {
                context.read<CharacterListViewCubit>().getCharacters();
              }, icon: Icon(Icons.refresh))
            ],
          ),
        body: Row(
          children: [
            // use SizedBox to constrain the AppMenu to a fixed width
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2 - 5,
              child: Scaffold(
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
                                          child: CustomListWidget(onPress: (character) {
                                            setState(() {
                                              selectedCharacter = character;
                                            });
                                          }, characters: filteredList,)
                                      ),
                                    ],
                                  ),
                                  Visibility(child: FullScreenLoadingWidget(),visible: state is CharacterListViewLoading,)
                                ]);
                          }))),
            ),
            Container(width: 0.5, color: Colors.black),
            Expanded(
              child: selectedCharacter != null ? Scaffold(
                  appBar: AppBar(
                    title: Text(selectedCharacter?.name ?? ''),
                  ),
                  body: SafeArea(
                      child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: selectedCharacter != null ? Image.network(selectedCharacter?.iconURL ?? '', fit: BoxFit.cover, width: MediaQuery.sizeOf(context).width/2,) : Container(),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Text(selectedCharacter?.text ?? ''),)
                                  ],
                                ),
                              )
                  )
              )
                  : Scaffold(
                appBar: AppBar(
                  title: Text('Select a Character'),
                ),
                body: Text('Please select a character to continue'),
              ) )
          ])
      );

    } else {
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
                                child: CustomListWidget(onPress: (character) {
                                  CharacterDetailView.routeTo(context, character);
                                }, characters: filteredList,)
                              ),
                            ],
                          ),
                          Visibility(child: FullScreenLoadingWidget(),visible: state is CharacterListViewLoading,)
                        ]);
                  })));
    }



  }
}
