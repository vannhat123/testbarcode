import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/blocs/country/bloc.dart';
import 'package:training_app/constants/constants.dart';
import 'package:training_app/constants/images.dart';
import 'package:training_app/models/models.dart';
import 'package:training_app/utilities/utilities.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      body: BlocListener<CountryBloc,  CountryState>(
        listener: (context, state) {
          print('profile');
        },
        child: Center(
          child: Text('profile', style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    ));
  }
}
