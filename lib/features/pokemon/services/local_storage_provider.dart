import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:web_demo/features/pokemon/model/pokemon_model.dart';
import 'package:web_demo/utils/utils.dart';

class LocalStorage {
  setLocalData(List<PokemonItemModel> items) async {
    await GetStorage().write("LastUpdated", DateTime.now().toString());
    await GetStorage().write("PokemonData", jsonEncode(items));
  }

  Future<List<PokemonItemModel>?> getLocalData() async {
    var data = await GetStorage().read("PokemonData");
    var lastUpdated = await GetStorage().read("LastUpdated");
    if (data != null && lastUpdated.toString().getTimeDiff().inHours < 1) {
      var pokemons = (jsonDecode(data) as List<dynamic>)
          .map((item) => PokemonItemModel.fromLocalJson(item))
          .toList();
      return pokemons;
    }
    return null;
  }
}
