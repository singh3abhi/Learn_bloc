import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/blocs/internet_bloc/internet_event.dart';
import 'package:learn_bloc/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  // super is used  to initialize parent class (here Bloc<InternetEvent, InternetState>)

  final _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetIntialState()) {
    // To check Internet Connectivity

    // on checks which event came
    // Event is added and state is emitted
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainEvent>((event, emit) => emit(InternetGainedState()));

    // Listening to stream of data which tells about connectivity when changed

    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        add(InternetGainEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  // Bloc closes itself when screen is changed but we have to close the connectivitySubscription
  // because it can affect the perfomance in long run
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
