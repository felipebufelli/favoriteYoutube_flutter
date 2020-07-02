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

    final bloc =  BlocProvider.of<VideosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo_home.png'),
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
                bloc.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: bloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if(index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if(index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40.0,
                    width: 40.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }
}