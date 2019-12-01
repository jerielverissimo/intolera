import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intolera/core/presentation/utilities/styles.dart';

class CameraButtons extends StatefulWidget {
  final bloc;
  final getImageFromCamera;
  final getImageFromGallery;

  CameraButtons({this.bloc, this.getImageFromCamera, this.getImageFromGallery});

  @override
  _CameraButtons createState() => _CameraButtons(
      bloc: bloc,
      getImageFromCamera: getImageFromCamera,
      getImageFromGallery: getImageFromGallery);
}

class _CameraButtons extends State<CameraButtons> {
  final bloc;
  final getImageFromCamera;
  final getImageFromGallery;

  _CameraButtons(
      {this.bloc, this.getImageFromCamera, this.getImageFromGallery});

  @override
  Widget build(BuildContext context) {
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
}
