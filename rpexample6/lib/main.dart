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
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  Film copy({required bool isFavorite}) => Film(
        id: id,
        title: title,
        description: description,
        isFavorite: isFavorite,
      );

  @override
  String toString() =>
      'Film(id=$id,title=$title,description=$description,isFavorite=$isFavorite)';

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll([
        id,
        isFavorite,
      ]);
}

const allfilms = [
  Film(
    id: "1",
    title: "title 1",
    description: "description 1",
    isFavorite: false,
  ),
  Film(
    id: "2",
    title: "title 2",
    description: "description 2",
    isFavorite: false,
  ),
  Film(
    id: "2",
    title: "title 3",
    description: "description 3",
    isFavorite: false,
  ),
  Film(
    id: "4",
    title: "title 4",
    description: "description 4",
    isFavorite: false,
  ),
];

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(allfilms);

  void update(Film film, bool isfavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copy(isFavorite: isfavorite)
            : thisFilm)
        .toList();
  }
}

enum favoriteStatus {
  all,
  favorite,
  unfavorite,
}

final favoriteStatusProvider = StateProvider<favoriteStatus>(
  (_) => favoriteStatus.all,
);

final allFilmsProvider = StateNotifierProvider<FilmNotifier, List<Film>>(
  (_) => FilmNotifier(),
);

final favoriteFilmsProvider = Provider<Iterable<Film>>(
  ((ref) => ref.watch(allFilmsProvider).where((film) => film.isFavorite)),
);

final unFavoriteFilmsProvider = Provider<Iterable<Film>>(
  ((ref) => ref.watch(allFilmsProvider).where((film) => !film.isFavorite)),
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
          FilmFilter(),
          Consumer(builder: ((context, ref, child) {
            final filter = ref.watch(favoriteStatusProvider);
            switch (filter) {
              case favoriteStatus.all:
                return FilmWidget(provider: allFilmsProvider);

              case favoriteStatus.favorite:
                return FilmWidget(provider: favoriteFilmsProvider);

              case favoriteStatus.unfavorite:
                return FilmWidget(provider: unFavoriteFilmsProvider);
            }
          }))
        ],
      ),
    );
  }
}

class FilmWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmWidget({required this.provider, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
        child: ListView.builder(
      itemCount: films.length,
      itemBuilder: ((context, index) {
        final film = films.elementAt(index);
        final favoriteIcon = film.isFavorite
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border);
        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.description),
          trailing: IconButton(
            icon: favoriteIcon,
            onPressed: () {
              final isFavorite = !film.isFavorite;
              ref.watch(allFilmsProvider.notifier).update(
                    film,
                    isFavorite,
                  );
            },
          ),
        );
      }),
    ));
  }
}

class FilmFilter extends StatelessWidget {
  const FilmFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return DropdownButton(
        value: ref.watch(favoriteStatusProvider),
        items: favoriteStatus.values
            .map(
              (fs) => DropdownMenuItem(
                value: fs,
                child: Text(fs.toString().split('.').last),
              ),
            )
            .toList(),
        onChanged: (favoriteStatus? fs) {
          ref.read(favoriteStatusProvider.notifier).state = fs!;
        },
      );
    }));
  }
}
