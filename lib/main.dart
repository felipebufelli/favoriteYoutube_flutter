import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube/bloc/videos_bloc.dart';

import 'ui/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
      )));
}
