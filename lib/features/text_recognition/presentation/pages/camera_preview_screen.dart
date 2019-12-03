import 'dart:core';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:async';

import 'package:intolera/features/text_recognition/domain/entities/words.dart';
import '../../presentation/bloc/text_recognition_bloc.dart';
import '../../presentation/bloc/text_recognition_state.dart';
import '../../../../injection_container.dart';
import './detail_screen.dart';
import '../widgets/speed_dial_buttons_widget.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreen createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  File _image;
  FirebaseVisionImage vImage;
  List<String> foundedWords = [];
  StringBuffer capturedWords = StringBuffer();
  final logger = Logger();
  int _selectedCategoryIndex = 0;
  final mainBloc = sl<TextRecognizerBloc>();
  var bloc;

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() async {
      _image = image;
      vImage = FirebaseVisionImage.fromFile(_image);
      await readText();
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() async {
      _image = image;
      vImage = FirebaseVisionImage.fromFile(_image);
      await readText();
    });
  }

  Future readText() async {
    if (_image == null) {
      logger.d('[CameraPreviewScreen] - Empty image');
    }
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await recognizeText.processImage(vImage);

    for (TextBlock block in visionText.blocks) {
      //final Rect boundingBox = block.boundingBox;
      //final List<Offset> cornerPoints = block.cornerPoints;
      //final String text = block.text;
      //final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          capturedWords.write(" " + element.text);
        }
      }
      foundedWords.add(capturedWords.toString());
      print('VOU CHAMAR O FILTRAR PERFIL');
    }

    logger.d(foundedWords);
    mainBloc.onFindFoodListProfiles(FoundedWords(wordsFound: foundedWords));
  }

  @override
  Widget build(BuildContext context) {
    return CameraButtons(
        bloc: buildBody(context),
        getImageFromCamera: getImageFromCamera,
        getImageFromGallery: getImageFromGallery);
  }

  BlocProvider<TextRecognizerBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => mainBloc,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<TextRecognizerBloc, TextRecognizerState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Container(
                      child: Column(children: <Widget>[
                        Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 50.0, horizontal: 10.0),
                              height: 200.0,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Busca por categorias',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'Para efetuar uma busca por categorias de restrições alimentar, basta tirar uma foto do rótulo.',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 18.0,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ]),
                    );
                  } else if (state is Loading) {
                    print('Entrou no estado de LOADING');
                    return SafeArea(
                      child: Center(
                        //width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "Loading",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is Loaded) {
                    print('Entrou no estado de LOADED');
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.profiles.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return SizedBox(width: 20.0);
                          }
                          return _buildCategoryCard(
                            index - 1,
                            state.profiles.toList()[index - 1].category,
                            state.profiles.toList().length,
                          );
                        },
                      ),
                    );
                  } else if (state is Error) {
                    return Center(
                      child: Text('Error: ' + state.message),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailScreen(title, "")));
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 140.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xFF417BFB)
              : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xFFAFB4C6),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
