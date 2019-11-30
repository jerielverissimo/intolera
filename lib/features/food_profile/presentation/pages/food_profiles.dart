import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc/food_profile_bloc.dart';
import '../../presentation/bloc/food_profile_state.dart';
import '../../presentation/bloc/food_profile_event.dart';
import '../../../../injection_container.dart';

class FoodProfilePage extends StatefulWidget {
  FoodProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _FoodProfilePageState createState() => _FoodProfilePageState();
}

class _FoodProfilePageState extends State<FoodProfilePage> {
  int _selectedCategoryIndex = 0;

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: //Container(
          //margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          //child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          //children: <Widget>[
          ////ClipRRect(
          ////borderRadius: BorderRadius.circular(20.0),
          ////child: Image(
          ////image: AssetImage("assets/backgrounds/egg.jpg"),
          ////),
          ////),
          //Padding(
          //padding: EdgeInsets.all(20.0),
          //child: Text(
          //title,
          //style: TextStyle(
          //color: _selectedCategoryIndex == index
          //? Colors.white
          //: Color(0xFFAFB4C6),
          //fontSize: 28.0,
          //fontWeight: FontWeight.bold,
          //),
          //),
          //),
          //],
          //),
          //decoration: BoxDecoration(
          //color: _selectedCategoryIndex == index
          //? Color(0xFF417BFB)
          //: Color(0xFFF5F7FB),
          //borderRadius: BorderRadius.circular(20.0),
          //boxShadow: [
          //_selectedCategoryIndex == index
          //? BoxShadow(
          //color: Colors.black26,
          //offset: Offset(0, 2),
          //blurRadius: 10.0)
          //: BoxShadow(color: Colors.transparent),
          //],
          //),
          //),

          Container(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfis de Restrições'),
      ),
      body: buildBody(context),
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
}
