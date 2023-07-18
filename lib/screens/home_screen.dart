import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/blocs/internet_bloc/internet_bloc.dart';
import 'package:learn_bloc/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Internet Connected'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is InternetLostState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Internet Disconnected'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InternetGainedState) {
                return const Text('Internet Connected');
              } else if (state is InternetLostState) {
                return const Text('Internet Disconnected');
              } else {
                return const Text('Loading...');
              }
            },
          ),
          // child: BlocBuilder<InternetBloc, InternetState>(
          //   builder: (context, state) {
          //     // == to check value
          //     // is to check data type

          //     // int a = 2
          //     // if(a == 2) checks value and returns true
          //     // if(a is int) checks data type and returns true
          //     if (state is InternetGainedState) {
          //       return const Text('Home Screen');
          //     } else if (state is InternetLostState) {
          //       return const Text('Connected');
          //     } else {
          //       return const Text('Loading...');
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}

// Bloc Builder is used for creating widgets and ui
// Bloc Listener is used for perfoming background task
// like Navigating to another screen or showind Dialog or snackbar etc

// If we want to do both the things create ui and perfom background tasks
// then we can take Bloc Consumer