import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_demo/features/pokemon/ui/dashboard.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const ProviderScope(
  child:   MaterialApp(
        title: "PokemonX",
        home: Dashboard(),
        debugShowCheckedModeBanner: false,
      ),
));
}
