import 'package:bloc_1/mydata/mymodels/characters.dart';
import 'package:bloc_1/mydata/web_services/characters_api.dart';

class CharactersRepsitory {
  CharachtersWebServices charachtersWebServices;

  CharactersRepsitory(this.charachtersWebServices);

  Future<List<Charachter>> getAllCharachters() async {
    final charachters = await charachtersWebServices.getAllCharachters();
    return charachters
        .map((charachter) => Charachter.fromJson(charachter))
        .toList();
  }
}
