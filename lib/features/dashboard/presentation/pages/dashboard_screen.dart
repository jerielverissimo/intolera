import 'package:flutter/material.dart';
import '../../../text_recognition/presentation/pages/camera_preview_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _buttonAction(asset) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: asset,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buttonAction(Icon(Icons.home)),
            SizedBox(width: 48.0),
            _buttonAction(Icon(Icons.person)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: ImageIcon(AssetImage('assets/icons/barcode-scan.png')),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraPreviewScreen()),
          );
        },
      ),
      //body: _body(),
    );
  }
}
