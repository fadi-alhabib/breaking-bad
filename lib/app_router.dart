import 'package:bloc_1/business_logic_layer/cubit/charachters_cubit.dart';
import 'package:bloc_1/constants/strings.dart';
import 'package:bloc_1/mydata/mymodels/characters.dart';
import 'package:bloc_1/mydata/repositories/characters_repository.dart';
import 'package:bloc_1/mydata/web_services/characters_api.dart';
import 'package:bloc_1/presentation_layer/myscreens/charachters_details_screen.dart';
import 'package:bloc_1/presentation_layer/myscreens/charachters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepsitory charactersRepsitory;
  late CharachtersCubit charachtersCubit;

  AppRouter() {
    charactersRepsitory = CharactersRepsitory(CharachtersWebServices());
    charachtersCubit = CharachtersCubit(charactersRepsitory);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charachtersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charachtersCubit,
            child: CharachtersScreen(),
          ),
        );
      case detailsScreen:
        final selectedCharachter = settings.arguments as Charachter;
        return MaterialPageRoute(
            builder: (_) => CharachterDetailsScreen(
                  selectedCharachter: selectedCharachter,
                ));
    }
  }
}
