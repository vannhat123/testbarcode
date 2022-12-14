import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/blocs/country/bloc.dart';
import 'package:training_app/constants/constants.dart';
import 'package:training_app/constants/images.dart';
import 'package:training_app/models/country.dart' as CountryModel;
import 'package:training_app/repositories/repositories.dart';
import 'package:training_app/widgets/widgets.dart';

class SelectCountry extends StatefulWidget {
  final updateSelectedCountry;
  final countryBloc;
  SelectCountry({this.updateSelectedCountry, this.countryBloc});
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  //states
  //List<CountryModel.Country> _countries = [].obs;
  //filteredCountries is a "calculated value" / "getter" of "countries"

  // List<CountryModel.Country> get _filteredCountries =>
  //     _countries.where((eachCountry) => eachCountry.countryName.toLowerCase()
  //                   .contains(searchString.toLowerCase()))
  //               .toList();
  List<CountryModel.Country> _filteredCountries(List<CountryModel.Country> countries) =>
      countries.where((eachCountry) => eachCountry.countryName.toLowerCase()
                    .contains(searchString.toLowerCase()))
                .toList();
  //bool _isLoading = false;
  String searchString = '';
  @override
  void initState() {
    super.initState();
    //_isLoading = true;
    //in Bloc, it must be An EVEEEENTTTTTT !
    //SelectCountry is "Listener"
    //context.read<CountryBloc>().add(CountryEventGetAll(page: 0, limit: 10));

    //context.read<CountryBloc>().getCountries(page: 0, limit: 10);

    /*
    CountryRepository.instance.getCountries()
    .then((value){
      setState(() {
        _isLoading = false;
        _countries = value;
      });
    }).catchError((error) {
      setState(() {
        _countries = [];
        _isLoading = false;
      });
    });
    */     
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Select country'),
        content: BlocBuilder<CountryBloc, CountryState>(builder: (context, countryState) {
          print('aaa');
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width - 2 * 20,
            child: countryState.isLoading == true ? Loading(title: 'Loading countries')
                : Container(
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      cursorColor: MyColors.light,
                      onChanged: (typedText) {
                        setState(() {
                          searchString = typedText; //No!, because "state" is immutable
                        });
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        hintText: "Search country",
                        hintStyle: TextStyle(
                            fontSize: FontSizes.h5, color: Colors.black),
                      ),
                    ),
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: ListView.builder(
                      itemCount: _filteredCountries(countryState.countries).length,
                      itemBuilder: (BuildContext context, int index) {
                        CountryModel.Country eachCountryObject = _filteredCountries(countryState.countries)[index];
                        return GestureDetector(
                          child: Container(
                            color: index % 2 == 0 ? MyColors.light : MyColors.inactive,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(eachCountryObject.countryName, style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                                Text(eachCountryObject.code),
                                const SizedBox(height: 10,)
                              ],
                            ),
                          ),
                          onTap: () {
                            //implement function from "function ref"
                            widget.updateSelectedCountry(selectedCountry: eachCountryObject);
                            Navigator.of(context, rootNavigator: true).pop('Discard');
                          },
                        );
                      }))
                ],
              ),
            ),
          );
    }));
  }
}
