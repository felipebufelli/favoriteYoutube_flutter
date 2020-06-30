import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube/bloc/videos_bloc.dart';
import 'package:favorite_youtube/delegates/data_search.dart';
import 'package:favorite_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45,
          child: Image.asset(
            'images/logo_home.png',
            fit: BoxFit.contain,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.star), 
            onPressed: (){
              
            },
          ),
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) {
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.lenght,
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }
}