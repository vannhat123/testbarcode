//bloc is "controller"
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:training_app/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:training_app/repositories/repositories.dart';

part './event.dart';
part './state.dart';

class CountryBloc extends Cubit<CountryState> {
  //constructor:
  //initial state => create Bloc object
  CountryBloc() : super(CountryState(
    countryStatus: CountryStatus.initial,
    countries: []
  ));
  void getCountries({required int page, required int limit}) async {
    try {
      List<Country> countries = await CountryRepository.instance.getCountries();
      //emit state "SUCCESS"
      emit(CountryState(
          countries: countries,
          countryStatus: CountryStatus.success,
          errorMessage: '',
          isLoading: false
      ));
    }catch(error) {
      //emit state "FAILED"
      emit(CountryState(
          countries: [],
          countryStatus: CountryStatus.failed,
          errorMessage: 'Cannot get countries: ${error.toString()}',
          isLoading: false
      ));
    }
  }
}
