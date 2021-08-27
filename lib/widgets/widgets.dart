import 'package:app_filmes/screens/home.dart';
import 'package:app_filmes/screens/web_view.dart';
import 'package:flutter/material.dart';

class Widgets {
  Widget buildAppBar(height, width, page, context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => {
            if (page == "home") {_toSite(context)} else {_toHome(context)}
          },
          child: Container(
            margin: EdgeInsets.only(
                top: height * 0.1, left: width * 0.04, bottom: height * 0.05),
            height: height * 0.05,
            width: width * 0.2,
            decoration: BoxDecoration(
                color: page == "webView" ? Colors.grey : Colors.white,
                border: Border.all(
                  color: page == "webView" ? Colors.green : Colors.black,
                )),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.015),
              child: Text(
                "Site Oficial",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}

_toHome(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}

_toSite(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewClass()));
}

_toAvatar() {}
