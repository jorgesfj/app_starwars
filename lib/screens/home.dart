import 'dart:convert';
import 'dart:ffi';

import 'package:app_filmes/db/database.dart';
import 'package:app_filmes/models/favorites.dart';
import 'package:app_filmes/models/fetch_characters.dart';
import 'package:app_filmes/models/fetch_movies.dart';
import 'package:app_filmes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper db = DatabaseHelper();
  List<Favorite> favorites = <Favorite>[];

  Widgets widgets = Widgets();
  late double height;
  late double width;
  bool _isMoviesSelected = false;
  bool _isCharactersSelected = false;
  bool _isFavesSelected = false;
  var page = "home";

  late var futureMovies;

  var movies = <Movie>[];
  var characters = <Character>[];

  _getMovies() {
    API.getMovies().then((response) {
      setState(() {
        var varJson = json.decode(response.body);
        Iterable lista = varJson["results"];
        movies = lista.map((model) => Movie.fromJson(model)).toList();
      });
    });
  }

  _getCharacters() {
    APICharacter.getCharacter().then((response) {
      setState(() {
        var varJson = json.decode(response.body);
        Iterable lista = varJson["results"];
        characters = lista.map((model) => Character.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
    _getCharacters();
    db.deleteMovie("Harry Potter");
    db.deleteMovie("A New Hope");
    db.deleteMovie("The Empire Strikes Back");
    db.deleteCharacter("C-3PO");
    db.deleteCharacter("Luke Skywalker");
    db.getFavorites().then((lista) {
      setState(() {
        favorites = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          widgets.buildAppBar(height, width, page, context),
          _buildButtons(height, width),
          _isCharactersSelected
              ? _buildCharacters(height, width, context)
              : Container(),
          _isFavesSelected ? _buildFaves(height, width, context) : Container(),
          (!_isCharactersSelected && !_isFavesSelected)
              ? _buildMovies(height, width, context)
              : Container(),
        ],
      ),
    );
  }

  Widget _buildFaves(height, width, context) {
    return Expanded(
        child: ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (BuildContext context, int i) {
        var item = favorites[i];
        return movieCard(item, context, height, width, "fave");
      },
    ));
  }

  Widget _buildCharacters(height, width, context) {
    return Expanded(
        child: ListView.builder(
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int i) {
        var item = characters[i];
        return movieCard(item, context, height, width, "character");
      },
    ));
  }

  Widget _buildMovies(height, width, context) {
    return Expanded(
        child: ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int i) {
        var item = movies[i];
        return movieCard(item, context, height, width, "movie");
      },
    ));
  }

  bool _isFave(item) {
    var isFave = false;
    for (int i = 0; i < favorites.length; i++) {
      if (item.title == favorites[i].title) {
        isFave = true;
      }
    }
    return isFave;
  }

  movieCard(item, context, height, width, type) {
    bool isFave = _isFave(item);
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
          height: height * 0.1,
          child: Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                  ),
                  Container(
                    width: width * 0.2,
                    child: IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          setState(() {
                            isFave = true;
                            type == "movie"
                                ? db.insertMovie(item)
                                : db.insertChatacter(item);
                          });
                        },
                        icon: isFave
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border_outlined)),
                  )
                ],
              )),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.transparent)),
    );
  }

  Widget _buildButtons(height, width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => {
            setState(() {
              _isMoviesSelected = true;
              _isCharactersSelected = false;
              _isFavesSelected = false;
            })
          },
          child: Container(
            width: width * 0.3,
            height: height * 0.04,
            decoration: BoxDecoration(
                color: _isMoviesSelected ? Colors.grey : Colors.white,
                border: Border.all(
                    color: _isMoviesSelected ? Colors.green : Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: Text(
                "Filmes",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        GestureDetector(
          onTap: () => {
            setState(() {
              _isMoviesSelected = false;
              _isCharactersSelected = true;
              _isFavesSelected = false;
            })
          },
          child: Container(
            width: width * 0.3,
            height: height * 0.04,
            decoration: BoxDecoration(
                color: _isCharactersSelected ? Colors.grey : Colors.white,
                border: Border.all(
                    color:
                        _isCharactersSelected ? Colors.green : Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: Text(
                "Personagens",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        GestureDetector(
          onTap: () => {
            setState(() {
              _isMoviesSelected = false;
              _isCharactersSelected = false;
              _isFavesSelected = true;
            })
          },
          child: Container(
            width: width * 0.3,
            height: height * 0.04,
            decoration: BoxDecoration(
                color: _isFavesSelected ? Colors.grey : Colors.white,
                border: Border.all(
                    color: _isFavesSelected ? Colors.green : Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: Text(
                "Favoritos",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
