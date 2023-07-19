import 'package:bloc/bloc.dart';
import 'package:bloc_1/mydata/mymodels/characters.dart';
import 'package:bloc_1/mydata/repositories/characters_repository.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final CharactersRepsitory charactersRepsitory;
  List<Charachter> charachters = [];

  CharachtersCubit(this.charactersRepsitory) : super(CharachtersInitial());

  List<Charachter> getAllCharachters() {
    charactersRepsitory.getAllCharachters().then((charachters) {
      emit(CharachtersLoaded(charachters: charachters));
      this.charachters = charachters;
    });

    return charachters;
  }
}
