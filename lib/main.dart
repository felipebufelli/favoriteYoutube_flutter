import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube/bloc/favorite_bloc.dart';
import 'package:favorite_youtube/bloc/videos_bloc.dart';

import 'ui/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: VideosBloc(),
        child: BlocProvider(
          bloc: FavoriteBloc(),
          child: MaterialApp(
          title: "Favorite Youtube",
          home: Splash(),
          debugShowCheckedModeBanner: false,
        ),
        ),
    );
  }
}
