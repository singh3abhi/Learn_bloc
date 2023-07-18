// If  there is no data in the all the state classes then we can define them in enum
// For one line we don't need to create a different file , we will do it in cubit  only

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState {
  initial,
  lost,
  gained
}

class InternetCubit extends Cubit<InternetState> {
  final _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetCubit() : super(InternetState.initial) {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        emit(InternetState.gained);
      } else {
        emit(InternetState.lost);
      }
    });
  }

  @override
  Future<void> close() {
    // If not null only then it will cancel
    connectivitySubscription?.cancel();
    return super.close();
  }
}
