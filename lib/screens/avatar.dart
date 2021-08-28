import 'package:app_filmes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Widgets widgets = Widgets();
  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          widgets.buildAppBar(height, width, "avatar", context),
          _buildAvatarCustomize(width)
        ],
      ),
    );
  }

  Widget _buildAvatarCustomize(width) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FluttermojiCircleAvatar(
              radius: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
            child: FluttermojiCustomizer(
              //scaffoldHeight: 400,
              scaffoldWidth: width,
            ),
          ),
        ],
      ),
    );
  }
}
