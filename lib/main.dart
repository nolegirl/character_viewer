import 'package:character_viewer/pages/character_list_view/character_list_view_cubit.dart';
import 'package:character_viewer/utils/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/character_list_view/character_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.home: (context) =>
            BlocProvider(
              create: (context) => CharacterListViewCubit(),
              child: CharacterListView(),
            ),
      }
    );
  }
}