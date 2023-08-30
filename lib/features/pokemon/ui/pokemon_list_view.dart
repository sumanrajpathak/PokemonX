import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_demo/features/pokemon/widgets/empty_widget.dart';
import 'package:web_demo/features/pokemon/widgets/pokemon_card.dart';
import 'package:web_demo/utils/adaptive.dart';
import '../provider/pokemon_provider.dart';

class PokemonListView extends ConsumerWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = ScrollController();
    final pokemonList = ref.watch(asyncPokeProvider);
    final loadMore = ref.watch(loadMoreNotifier);
    final filter = ref.watch(filterNotifier);

    return pokemonList.when(
      data: (items) => SingleChildScrollView(
        controller: scrollController
          ..addListener(() {
            if (scrollController.offset ==
                    scrollController.position.maxScrollExtent &&
                !loadMore) {
              ref.read(asyncPokeProvider.notifier).loadMorePokemons();
            }
          }),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.95,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.9)),
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(22)),
              child: TextFormField(
                onChanged: (value) {
                  ref.read(filterNotifier.notifier).filter(value);
                },
                decoration: InputDecoration(
                  isDense: false,
                  contentPadding: const EdgeInsets.only(left: 8),
                  hintText: "Search",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14, color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            (filter != null && filter.isEmpty)
                ? const EmptyDataWidget()
                : const SizedBox.shrink(),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDisplayDesktop(context) ? 4 : 2),
              itemCount: filter?.length ?? items.length,
              itemBuilder: (context, index) {
                var item = filter?[index] ?? items[index];
                return PokeCard(
                    name: item.name!, image: item.image!, type: item.types);
              },
            ),
            loadMore
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
