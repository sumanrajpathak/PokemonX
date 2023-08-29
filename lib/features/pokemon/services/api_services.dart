
import 'package:dio/dio.dart';
import 'package:web_demo/core/consts/const.dart';
import 'package:web_demo/features/pokemon/model/pokemon_model.dart';

class ApiServices {
  static Future<PokemonItemModel> fetchPokemonDetail(String name) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
    ));
    var response = await dio.get(Endpoints.pokemonDetail,
        options: Options(headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": '*',
        }),
        queryParameters: {"name": name});
    var data = PokemonItemModel.fromJson(response.data);
    return data;
  }

  static Future fetchPokemonList({int? offset = 1}) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
    ));
    var response = await dio.get(Endpoints.pokemonList,
        queryParameters: {"offset": offset},
        options: Options(headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": '*',
        }));

    return response.data;
  }
}
