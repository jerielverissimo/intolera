import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:async';

import 'package:intolera/features/text_recognition/domain/entities/words.dart';
import '../../presentation/bloc/text_recognition_bloc.dart';
import '../../presentation/bloc/text_recognition_state.dart';
import '../../presentation/bloc/text_recognition_event.dart';
import '../../../../injection_container.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreen createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  File _image;
  FirebaseVisionImage vImage;
  List<String> foundedWords = [];
  int _selectedCategoryIndex = 0;

  final Map<String, int> categories = {
    'Notes': 112,
    'Work': 58,
    'Home': 23,
    'Complete': 31,
  };

  Future getImage() async {
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
          foundedWords.add(element.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      //body: Center(
      //child: _image == null ? Text('No image selected') : Image.file(_image),
      //),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
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
                    if (!foundedWords.isEmpty) {
                      BlocProvider.of<TextRecognizerBloc>(context).dispatch(
                          FindFoodListProfiles(
                              FoundedWords(wordsFound: foundedWords)));
                    }
                    return Center(
                      child: Row(children: <Widget>[
                        Text('Empty...'),
                        FlatButton(
                          onPressed: () {
                            BlocProvider.of<TextRecognizerBloc>(context)
                                .dispatch(FindFoodListProfiles(
                                    FoundedWords(wordsFound: foundedWords)));
                          },
                          child: Text('Teste'),
                        ),
                      ]),
                    );
                  } else if (state is Loading) {
                    print('Entrou no estado de LOADING');
                    return Center(
                      child: Text('Loading...'),
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
                            categories.values.toList()[index - 1],
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
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.0,
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
