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

enum City {
  addis,
  gonder,
  bahirdar,
}

typedef WeatherEmoj = String;

Future<WeatherEmoj> getWeather(City city) {
  return Future.delayed(
    Duration(seconds: 1),
    (() => {
          City.addis: 'suny',
          City.bahirdar: 'rain',
          City.gonder: 'windy',
        }[city]!),
  );
}

final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

final weatherProvider = FutureProvider<WeatherEmoj>(((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return 'unknown';
  }
}));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          currentWeather.when(
              data: (data) => Text(
                    data,
                    style: TextStyle(fontSize: 40),
                  ),
              error: (_, __) => const Text('error'),
              loading: () => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
          Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: ((context, index) {
                    final city = City.values[index];
                    final isSelected = city == ref.watch(currentCityProvider);
                    return ListTile(
                      title: Text(city.toString()),
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () =>
                          ref.read(currentCityProvider.notifier).state = city,
                    );
                  })))
        ],
      ),
    );
  }
}
