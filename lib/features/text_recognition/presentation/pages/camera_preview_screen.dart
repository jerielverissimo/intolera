import 'dart:core';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'dart:async';

import 'package:intolera/core/presentation/utilities/styles.dart';
import 'package:intolera/features/text_recognition/domain/entities/words.dart';
import '../../presentation/bloc/text_recognition_bloc.dart';
import '../../presentation/bloc/text_recognition_state.dart';
import '../../presentation/bloc/text_recognition_event.dart';
import '../../../../injection_container.dart';
import './detail_screen.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreen createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  File _image;
  FirebaseVisionImage vImage;
  List<String> foundedWords = [];
  StringBuffer capturedWords = StringBuffer();
  int _selectedCategoryIndex = 0;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() async {
      _image = image;
      vImage = FirebaseVisionImage.fromFile(_image);
      readText();
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() async {
      _image = image;
      vImage = FirebaseVisionImage.fromFile(_image);
      readText();
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() async {
      _image = image;
      vImage = FirebaseVisionImage.fromFile(_image);
      readText();
    });
  }

  Future readText() async {
    if (_image == null) {
      print("Imagem nula");
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
      print(foundedWords);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = buildBody(context);
    return Scaffold(
      body: bloc,
      backgroundColor: primaryColor,
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.add_a_photo, color: Colors.white),
              backgroundColor: alertColor,
              label: 'Camera',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => getImageFromCamera()),
          SpeedDialChild(
            child: Icon(Icons.add_photo_alternate, color: Colors.white),
            backgroundColor: alertColor,
            label: 'Galeria de fotos',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => getImageFromGallery(),
          ),
        ],
      ),
    );
  }

  BlocProvider<TextRecognizerBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<TextRecognizerBloc>(),
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
                            height: MediaQuery.of(context).size.height / 2,
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
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Vazio',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            BlocProvider.of<TextRecognizerBloc>(context)
                                .dispatch(FindFoodListProfiles(
                                    FoundedWords(wordsFound: foundedWords)));
                          },
                          child: Text(
                            'PESQUISAR',
                            style: TextStyle(color: Colors.white),
                          ),
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
                    return Container(
                      height: 280.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
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
        height: 240.0,
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
