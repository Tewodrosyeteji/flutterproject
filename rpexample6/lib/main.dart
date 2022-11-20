import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    ),
  ));
}

@immutable
class Films {
  final String id;
  final String title;
  final String description;
  final bool isfavorite;

  const Films({
    required this.id,
    required this.title,
    required this.description,
    required this.isfavorite,
  });

  Films copy({required bool isfavorite}) => Films(
        id: id,
        title: title,
        description: description,
        isfavorite: isfavorite,
      );

  @override
  String toString() =>
      'Films(id=$id, title=$title,descriiption=$description,isFavorite=$isfavorite)';

  @override
  bool operator ==(covariant Films other) =>
      id == other.id && isfavorite == other.isfavorite;

  @override
  int get hashCode => Object.hashAll([id, isfavorite]);
}

const allFilms = [
  Films(
    id: '1',
    title: 'title 1',
    description: 'description 1',
    isfavorite: false,
  ),
  Films(
    id: '2',
    title: 'title 2',
    description: 'description 2',
    isfavorite: false,
  ),
  Films(
    id: '3',
    title: 'title 3',
    description: 'description 3',
    isfavorite: false,
  ),
  Films(
    id: '4',
    title: 'title 4',
    description: 'description 4',
    isfavorite: false,
  ),
];

class FilmNotifier extends StateNotifier<List<Films>> {
  FilmNotifier() : super(allFilms);

  void update(Films films, bool isfavorite) {
    state = state
        .map((thisfilm) => thisfilm.id == films.id
            ? thisfilm.copy(isfavorite: isfavorite)
            : thisfilm)
        .toList();
  }
}

enum FavoriteStatus {
  all,
  favorrite,
  unFavorite,
}

final favoriteStateprovider = StateProvider<FavoriteStatus>(
  ((_) => FavoriteStatus.all),
);

final allFilmProvider = StateNotifierProvider<FilmNotifier, List<Films>>(
  ((_) => FilmNotifier()),
);

final favoriteFilmProvider = Provider<Iterable<Films>>(
  (ref) => ref.watch(allFilmProvider).where((film) => film.isfavorite),
);

final unFavoriteFilmProvider = Provider<Iterable<Films>>(
  (ref) => ref.watch(allFilmProvider).where((film) => !film.isfavorite),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(builder: ((context, ref, child) {
            final filter = ref.watch(favoriteStateprovider);
            switch (filter) {
              case FavoriteStatus.all:
                return FilmList(provider: allFilmProvider);
              case FavoriteStatus.favorrite:
                return FilmList(provider: favoriteFilmProvider);
              case FavoriteStatus.unFavorite:
                return FilmList(provider: unFavoriteFilmProvider);
            }
          }))
        ],
      ),
    );
  }
}

class FilmList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Films>> provider;
  const FilmList({required this.provider, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: ((context, index) {
          final film = films.elementAt(index);
          final favoriteIcon = film.isfavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: favoriteIcon,
              onPressed: (() {
                final isfavorite = !film.isfavorite;
                ref.read(allFilmProvider.notifier).update(film, isfavorite);
              }),
            ),
          );
        }),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return DropdownButton(
        value: ref.watch(favoriteStateprovider),
        items: FavoriteStatus.values
            .map(
              (fs) => DropdownMenuItem(
                value: fs,
                child: Text(fs.toString().split('.').last),
              ),
            )
            .toList(),
        onChanged: (fs) {
          ref.read(favoriteStateprovider.notifier).state = fs!;
        },
      );
    }));
  }
}
