import 'package:flutter/material.dart';
import 'package:web_demo/features/pokemon/ui/pokemon_list_view.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PokemonX'),
        ),
        body: const PokemonListView());
  }
}
