import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Weather',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    ),
  ));
}

enum City {
  bahir_dar,
  addis_ababa,
  hawasa,
}

Future<String> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    (() => {
          City.addis_ababa: "sunny",
          City.bahir_dar: "rain",
          City.hawasa: "cloud",
        }[city]!),
  );
}

final currentCityState = StateProvider<City?>(
  ((ref) => null),
);

final weatherProvider = FutureProvider<String>(
  ((ref) {
    final city = ref.watch(currentCityState);
    if (city != null) {
      return getWeather(city);
    } else {
      return 'unknown';
    }
  }),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          weather.when(
            data: (data) {
              return Text(
                data,
                style: TextStyle(fontSize: 35.0),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: (() {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: City.values.length,
                itemBuilder: ((context, index) {
                  final city = City.values[index];
                  final isSelected = city == ref.watch(currentCityState);
                  return ListTile(
                    title: Text(city.toString()),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    onTap: () {
                      ref.read(currentCityState.notifier).state = city;
                    },
                  );
                })),
          )
        ],
      ),
    );
  }
}
