import 'package:flutter/foundation.dart';

@immutable
class PokeModel {
  final String name;
  final String url;

  const PokeModel({
    required this.name,
    required this.url,
  });

  factory PokeModel.fromJson(Map<String, dynamic> map) {
    return PokeModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}

@immutable
class PokemonItemModel {
  final String? name;
  final String? image;
  final List<PokeType>? types;

  const PokemonItemModel({
    this.name,
    this.image,
    this.types,
  });

  factory PokemonItemModel.fromJson(Map<String, dynamic> map) {
    final types = map['types'] != null
        ? (map['types'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((typeMap) {
            return PokeType.fromJson(typeMap);
          }).toList()
        : null;
    return PokemonItemModel(
      name: map['name'] as String,
      image: map['sprites'] != null
          ? map['sprites']['other']['home']['front_default']
          : null,
      types: types,
    );
  }
  factory PokemonItemModel.fromLocalJson(Map<String, dynamic> map) {
    final types = map['types'] != null
        ? (map['types'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((typeMap) {
            return PokeType.fromJson(typeMap);
          }).toList()
        : null;
    return PokemonItemModel(
      name: map['name'] as String,
      image: map['image'] as String,
      types: types,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@immutable
class PokeType {
  final int? slot;
  final Type? type;

  const PokeType({
    required this.slot,
    required this.type,
  });

  factory PokeType.fromJson(Map<String, dynamic> map) {
    return PokeType(
      slot: map['slot'],
      type: map['type'] != null ? Type.fromJson(map['type']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot'] = slot;
    data['type'] = type;
    return data;
  }
}

@immutable
class Type {
  final String? name;

  const Type({
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> map) {
    return Type(
      name: map['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
