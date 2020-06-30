import 'package:favorite_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              IconButton(
                icon: Icon(Icons.star_border), 
                color: Colors.white,
                iconSize: 30.0,
                onPressed: (){}
              ),
            ],
          ),
        ],
      ),
    );
  }
}