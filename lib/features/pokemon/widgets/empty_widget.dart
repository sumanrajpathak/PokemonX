import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 47,
          ),
          SizedBox(
              width: 123, height: 101, child: Image.asset("assets/empty.png")),
          const SizedBox(
            height: 16,
          ),
          const Text('No Pokemons found!')
        ],
      ),
    );
  }
}
