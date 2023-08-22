import 'package:flutter/material.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character List'),
      ),
      body: Container(

      ),
    );
  }
}
