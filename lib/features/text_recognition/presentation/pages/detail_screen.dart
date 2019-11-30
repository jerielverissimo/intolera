import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String _imageUrl;
  final String _text;

  DetailScreen(this._text, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _createBody(),
      ),
    );
  }

  Widget _createBody() {
    return Column(
      children: <Widget>[
        Hero(
          child: Image.network(_imageUrl),
          tag: _text,
        ),
        Expanded(
            child: Center(
          child: Text(_text, style: TextStyle(fontSize: 40)),
        ))
      ],
    );
  }
}
