import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_demo/features/pokemon/model/pokemon_model.dart';
import 'package:web_demo/features/pokemon/services/api_services.dart';
import '../services/local_storage_provider.dart';

final asyncPokeProvider =
    AsyncNotifierProvider<AsyncPokeNotifier, List<PokemonItemModel>>(() {
  return AsyncPokeNotifier();
});

final loadMoreNotifier = NotifierProvider<LoadMoreNotifier, bool>(() {
  return LoadMoreNotifier();
});
final filterNotifier =
    NotifierProvider<FilterNotifier, List<PokemonItemModel>?>(() {
  return FilterNotifier();
});

class LoadMoreNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle(bool value) {
    state = value;
  }
}

class FilterNotifier extends Notifier<List<PokemonItemModel>?> {
  void filter(String value) {
    if (value.isNotEmpty) {
      var data = ref
          .read(asyncPokeProvider)
          .value!
          .where((element) => element.name!.toLowerCase().contains(value))
          .toList();
      print("data  $data");
      state = data;
    } else {
      state = ref
          .read(asyncPokeProvider)
          .value!;
    }
  }

  @override
  List<PokemonItemModel>? build() {
    return null;
  }
}

class AsyncPokeNotifier extends AsyncNotifier<List<PokemonItemModel>> {
  @override
  Future<List<PokemonItemModel>> build() async {
    return _fetchPokemons();
  }

  Future<void> filter(String searchText) async {}

  Future<List<PokemonItemModel>> _fetchPokemons() async {
    var data = await LocalStorage().getLocalData();
    return data ?? await _fetchFromRemote();
  }

  _fetchFromRemote() async {
    List<PokemonItemModel> pokemonList = [];
    final json = await ApiServices.fetchPokemonList();
    var pokemons = (json["results"] as List<dynamic>)
        .map((item) => PokeModel.fromJson(item))
        .toList();
    for (var element in pokemons) {
      pokemonList.add(await fetchPokemonDetail(name: element.name));
    }
    await LocalStorage().setLocalData(pokemonList);
    return pokemonList;
  }

  Future<void> loadMorePokemons() async {
    ref.read(loadMoreNotifier.notifier).toggle(true);
    List<PokemonItemModel> pokemonList = [];

    pokemonList.addAll(state.value!);
    final json =
        await ApiServices.fetchPokemonList(offset: (pokemonList.length + 1));
    var pokemons = (json["results"] as List<dynamic>)
        .map((item) => PokeModel.fromJson(item))
        .toList();
    for (var element in pokemons) {
      pokemonList.add(await fetchPokemonDetail(name: element.name));
    }
    state = AsyncValue.data(pokemonList);
    LocalStorage localStorage = LocalStorage();
    await localStorage.setLocalData(pokemonList);
    ref.read(loadMoreNotifier.notifier).toggle(false);
  }

  Future<PokemonItemModel> fetchPokemonDetail({required String name}) async {
    return await ApiServices.fetchPokemonDetail(name);
  }
}
