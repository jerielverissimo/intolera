import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreen createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  File _image;
  FirebaseVisionImage vImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
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

    String text = visionText.text;
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          print(element.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image == null ? Text('No image selected') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
