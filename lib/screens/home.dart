import 'package:app_filmes/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widgets widgets = Widgets();
  late double height;
  late double width;
  bool _isMoviesSelected = false;
  bool _isCharactersSelected = false;
  bool _isFavesSelected = false;
  var page = "home";

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          widgets.buildAppBar(height, width, page, context),
          _buildButtons(height, width),
        ],
      ),
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
