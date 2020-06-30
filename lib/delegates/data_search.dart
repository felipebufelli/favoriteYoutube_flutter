import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataSearch extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    //*Funcao que desenha os ícones à direita do campo de digitação
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //*Funcao que desenha o ícone à esquerda do campo de digitação
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, 
          progress: transitionAnimation,
        ), 
        onPressed: () {
          close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    //*Funcao que é ativada quando clica no icone no teclado de pesquisa.
    //*Como essa funcao desenha uma tela no próprio search, da um erro se tentando redesenhar
    //*a tela anterior. Por isso o comando abaixo.
    Future.delayed(Duration.zero).then((_)=> close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //*Funcao ativada quando o usuário escreve algum texto
    if(query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
        future: suggestions(query),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center();
          } else {
            return ListView.builder(
              itemBuilder: (contex, index) {
                return ListTile(
                  title: Text(snapshot.data[index]),
                  leading: Icon(Icons.play_arrow),
                  onTap: () {
                    close(context, snapshot.data[index]);
                  },
                );
              },
              itemCount: snapshot.data.length,
            );
          }
        }
      );
    }
  }

  Future<List> suggestions(String search) async {
    //*Funcao que busca na API as sugestões baseado na query

    http.Response response = await http.get(
      "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
    );

    if(response.statusCode ==200) {

      return json.decode(response.body)[1]
      .map((v){
        return v[0];
      })
      .toList();

    } else {
      throw Exception('Failed to load suggestions!');
    }

  }

}