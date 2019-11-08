import '../../presentation/bloc/food_profile_bloc.dart';
import '../../presentation/bloc/food_profile_state.dart';
import '../../presentation/bloc/food_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intolera/features/text_recognition/data/models/food_profile_model.dart';
import 'package:intolera/features/text_recognition/data/transforms/food_profile_transform.dart';

import '../../../../injection_container.dart';

class FoodProfilePage extends StatefulWidget {
  FoodProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _FoodProfilePageState createState() => _FoodProfilePageState();
}

class _FoodProfilePageState extends State<FoodProfilePage> {
  Future<List<FoodProfileModel>> _getFoodProfiles() async {
    var data = await http.get('http://134.209.41.142/profiles');

    var jsonData = json.decode(data.body);
    print(jsonData);

    List<FoodProfileModel> profiles = [];

    profiles = jsonData
        .map<FoodProfileModel>((p) => FoodProfileModel.fromJson(p))
        .toList();

    return profiles;
  }

  int _selectedCategoryIndex = 0;

  final Map<String, int> categories = {
    'Notes': 112,
    'Work': 58,
    'Home': 23,
    'Complete': 31,
  };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Profiles'),
      ),
      body: buildBody(context),
      //body: ListView(
      //children: <Widget>[
      //SizedBox(height: 40.0),
      //Padding(
      //padding: EdgeInsets.symmetric(horizontal: 30.0),
      //child: Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      //children: <Widget>[
      //Container(
      //height: 280.0,
      //child: ListView.builder(
      //scrollDirection: Axis.horizontal,
      //itemCount: categories.length + 1,
      //itemBuilder: (BuildContext context, int index) {
      //if (index == 0) {
      //return SizedBox(width: 20.0);
      //}
      //return _buildCategoryCard(
      //index - 1,
      //categories.keys.toList()[index - 1],
      //categories.values.toList()[index - 1],
      //);
      //},
      //),
      //),
      //],
      //),
      //),
      //],
      //),
    );
  }

  BlocProvider<FoodProfileBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<FoodProfileBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<FoodProfileBloc, FoodProfileState>(
                builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<FoodProfileBloc>(context)
                        .dispatch(GetFoodListProfiles());
                    return Center(
                      child: Row(children: <Widget>[
                        Text('Empty...'),
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
                      child: Text(state.profiles[1].category),
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

  void dispatchProfiles() {
    BlocProvider.of<FoodProfileBloc>(context).dispatch(GetFoodListProfiles());
  }

  Widget _old(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getFoodProfiles(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading...'),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCard(context, snapshot.data[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, FoodProfileModel profile) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(profile.category),
              subtitle: Text('Teste'),
            ),
          ],
        ),
      ),
    );
  }
}
