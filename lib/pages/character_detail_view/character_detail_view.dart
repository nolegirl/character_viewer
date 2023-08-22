import 'package:character_viewer/pages/character_detail_view/character_detail_view_cubit.dart';
import 'package:character_viewer/utils/app_routes.dart';
import 'package:character_viewer/widgets/full_screen_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:character_viewer/models/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailView extends StatefulWidget {
  const CharacterDetailView({Key? key}) : super(key: key);

  static Future<void> routeTo(BuildContext context, Character character) =>
      Navigator.of(context)
          .pushNamed(AppRoutes.detail, arguments: character);

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  Character? character;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Character? args =
      ModalRoute
          .of(context)!
          .settings
          .arguments as Character?;
      if (args != null) {
        character = args;
        setState(() {
          character = args;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(character?.name ?? ''),
        ),
        body: SafeArea(
            child: BlocConsumer<
                CharacterDetailViewCubit,
                CharacterDetailViewState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CharacterDetailViewLoading) {
                    return FullScreenLoadingWidget();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Text(character?.text ?? ''),)
                        ],
                      ),
                    );
                  }
                })));
  }
}