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

const names = [
  'teddy',
  'yared',
  'nebwu',
  'halid',
  'abrham',
  'abrela',
];

final tickerProvoder = StreamProvider(
  ((ref) => Stream.periodic(
        const Duration(seconds: 1),
        (i) => i + 1,
      )),
);

final nameProvider = StreamProvider(
  ((ref) => ref.watch(tickerProvoder.stream).map(
        (count) => names.getRange(0, count),
      )),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        body: names.when(
            data: (names) {
              return ListView.builder(
                itemBuilder: ((context, index) => ListTile(
                      title: Text(names.toString()),
                    )),
              );
            },
            error: ((error, stackTrace) => const Text('reach the end list')),
            loading: (() => const Center(
                  child: CircularProgressIndicator(),
                ))));
  }
}
